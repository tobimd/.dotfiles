#!/usr/bin/zsh

# Wrapper for nvim, to open symlinks
nvim() {
  args=()

  for i in $@; do
    if [[ -h $i ]]; then
      args+=`readlink $i`
    else
      args+=$i
    fi
  done

  /usr/local/bin/nvim -p "${args[@]}"
}

repstring() {
    local input=$1
    local count=$2

    printf -v string '%*s' "$count"
    printf '%s\n' "${string// /$input}"
}

clean() {
    echo $(repstring "\n" 500)
    clear
}

startvenv() {
    local dir=$1
    local act=""

    if [[ -z $dir ]]; then
        dir="$PWD"

    else
        dir=$(realpath $dir)
    fi

    if [[ -d "$dir/bin" && -a "$dir/bin/activate" ]]; then
	act="$dir/bin/activate"
	dir="$dir/bin"

    elif [[ -a "$dir/activate" ]]; then
        act="$dir/activate"

    elif [[ -d "$dir/.env/bin" && -a "$dir/.env/bin/activate" ]]; then
        act="$dir/.env/bin/activate"
	dir="$dir/.env/bin"

    else
        echo -e "couldn't find \x1b[1mvenv\x1b[0m directory."
        return 1
    fi

    if [[ $act != "" ]]; then
	PATH="$dir:$PATH"
	typeset -U path
	export PATH
	source $act
    fi
}

git() {
    if [[ "$PWD" == "$HOME" ]]; then
        if [[ "$1" == "clone" ]];then
            /usr/bin/git "$@"

        elif [[ "$1" == "add" && "$2" == "--all" ]]; then
            /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" add --update

        elif [[ "$1" == "status" ]]; then
            shift
            /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" status -uno "$@"

        else            
            /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
        fi

    else
        /usr/bin/git "$@"
    fi
}

config() {
   
    if [[ ! -z $(which tput 2> /dev/null) ]]; then
        local reset=$(tput sgr0)
        local bold=$(tput bold)
        local red=$(tput setaf 1)
        local green=$(tput setaf 2)
        local yellow=$(tput setaf 3)
        local blue=$(tput setaf 4)
        local magenta=$(tput setaf 5)
        local cyan=$(tput setaf 6)
    else
        autoload -U colors && colors

        local reset="%{$reset_color%}"
        local bold="%{$bold_color%}"
        local red="%{$fg[red]%}"
        local green="%{$fg[green]%}"
        local yellow="%{$fg[yellow]%}"
        local blue="%{$fg[blue]%}"
        local magenta="%{$fg[magenta]%}"
        local cyan="%{$fg[cyan]%}"
    fi

    local config_files_dir="$HOME/.config/utils/configfiles"
    local reserved=".config-help"
    local error_msg="none"
    local cmd_mode="none"
    local flag_order=()

    typeset -A flags=(
        force     0
        link      0
        no_suffix 0
        verbose   0
    )

    typeset -a options=(
        "add -a --add"
        "edit -e --edit"
        "remove -r --remove"
        "help -h --help"
        "list -l --list"
        "force -f --force"
        "link -k --link"
        "no_suffix -x --no-suffix"
        "verbose -v --verbose"
    )

    typeset -a commands=("add" "a" "edit" "e" "remove" "rm" "r" "help" "h" "list" "l")

    typeset -A error_list=(
        [AE0]="(${yellow}ArgumentError$reset) No arguments were given"
        [AE1]="(${yellow}ArgumentError$reset) Missing argument"
        [AE2]="(${yellow}ArgumentError$reset) Too many arguments were used"
        [AE3]="(${yellow}ArgumentError$reset) Unknown argument or shortcut file"
        [CE0]="(${yellow}ConfigError$reset) Shortcut doesn't exist or wasn't found"
        [CE1]="(${yellow}ConfigError$reset) File doesn't exist or wasn't found"
        [CE2]="(${yellow}ConfigError$reset) Can't use \"$cyan$reserved$reset\" as the shortcut's name because it's reserved"
        [CE3]="(${yellow}ConfigError$reset) Name is already being used"
        [FE0]="(${yellow}FlagError$reset) Unknown flag"
        [FE1]="(${yellow}FlagError$reset) Can't use flag"
    )

    tb_info()       { echo "[ ${cyan}config${reset} ]: $@"            ;          }
    tb_warn()       { echo "[ ${yellow}config${reset} ]: $@"          ;          }
    tb_error()      { echo "[ ${red}config${reset} ]: $@"             ; echo ""; }
    tb_success()    { echo "[ ${green}config${reset} ]: $@"           ; echo ""; }
    tb_print_help() { printf "$(cat "$config_files_dir/.config-help")"; echo ""; }

    # Create directory if it doesn't exist yet
    if [[ ! -x "$config_files_dir" || ! -f "$config_files_dir/$reserved" ]]; then
        mkdir -p $config_files_dir
        echo 'usage: config COMMAND [OPTION...] [ARGS...]
  or:  config NAME

Create shortcuts for files that can later be opened using
the NAME of the saved shortcut.

 -f, --force    Do not prompt
 -v, --verbose  Explain what is being done
 -h, --help     Display this help message and exit. Same as
                using \033[1mhelp\033[0m as a command.
 -l, --list     Output list of all shortcuts saved. Same as
                using \033[1mlist\033[0m as a command.

\033[1madd\033[0m, \033[1m-a\033[0m, \033[1m--add\033[0m
    usage: config add [OPTION...] FILE [NAME]

    Create a shortcut for a file.

    -x, --no-suffix  Remove suffix from FILE if no NAME is
                     given.

    If NAME is not used, then a symlink is created with
    FILE instead (directories are not included, only the 
    file name).

\033[1mremove\033[0m, \033[1mrm\033[0m, \033[1m-r\033[0m, \033[1m--remove\033[0m
    usage: config remove [OPTION...] NAME [NAME...]
    
    Remove an existing shortcut from the list.

\033[1medit\033[0m, \033[1m-e\033[0m, \033[1m--edit\033[0m
    usage: config edit [OPTION...] NAME NEW_NAME
      or:  config edit [OPTION...] [-k|--link] NAME NEW_LINK
        
    Change some aspect of saved shortcuts.

    -k, --link  Specifies for the existing shortcut, to
                redirect to a new location

\033[1m\033[3mexamples\033[0m:
    The following two commands create the same shortcut
    named "\033[3mfoo\033[0m" for the file "\033[3mfoo.txt\033[0m" that is located in
    the current directory.
        $ config add foo.txt foo
        $ config add -x foo.txt

    Change name of existing shortcut "\033[3mfoo\033[0m" to "\033[3mbar\033[0m"
        $ config edit foo bar

    Point existing "\033[3mbar\033[0m" shortcut to a new file called
    "\033[3mbaz.txt\033[0m" inside the Desktop folder
        $ config edit --link bar ~/Desktop/baz.txt

' >> "$config_files_dir/.config-help"
    fi
    
    # First iteration over $@ to fix flag mix ("-abc")
    local final_args=()

    for arg in "$@"; do

        # Check if argument is mixing more than one flag in the
        # format "-abc" instead of "-a -b- c"
        if [[ $arg[1] == "-" && $arg[2] != "-" && ${#arg} -ge 3 ]]; then

            # Recreate $@ variable by populating the beggining
            # with the mix of flags into their own arguments.
            # e.g. "-abc" -> "-a -b -c"
            
            for _f in "${(s::)arg[2,-1]}"; do
                final_args+="-$_f"
            done

        else
            final_args+=$arg
        fi
    done

    if [[ ${commands[(ie)$final_args[1]]} -le ${#commands} ]]; then
        cmd_mode=$final_args[1]
        shift final_args
    fi

    # Remove all arguments to start fresh
    shift "${#@}"

    # Find and remove optional arguments
    for arg in "${final_args[@]}"; do

        # Capture a normal flag
        if [[ $arg[1] == "-" ]]; then
            _found="false"
            
            for opt in "${options[@]}"; do
                values=(${(s: :)opt})

                if [[ ${values[(ie)$arg]} -le ${#values} ]]; then
                    flags[$values[1]]=1
                    _found="true"

                    if [[ $cmd_mode == "none" && ${commands[(ie)$values[1]]} -le ${#commands} ]]; then
                        cmd_mode=$values[1]
                    fi

                    break
                fi
            done

            if [[ $_found == "false" ]]; then
                tb_error $error_list[FE0] "\"$cyan$arg$reset\""
                return 3
            fi

        else
            set -- "$@" $arg
        fi

    done

    # Check if there are any arguments at all
    if [[ ! -z "$1" || $cmd_mode != "none" ]]; then

        if [[ $cmd_mode == "none" ]]; then
            cmd_mode=$1; shift
        fi

        # ADD COMMAND =========================================================
        if [[ $cmd_mode == "add" || $cmd_mode == "a" ]]; then

            # ERROR CHECKS
            # *** No file argument was given
            if [[ -z "$1" ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[AE1] "\"${cyan}file$reset\""
                    tb_print_help
                    return 1
                fi

                return 0
            fi
            
            local file="$(realpath -m $1)"
            local name="$2"
            local bn_file="$(basename $file)"

            # *** File doesn't exist
            if [[ ! -f $file ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[CE1] "\"$cyan$file$reset\""
                    return 2
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[CE1] "\"$cyan$file$reset\""
                fi
                return 0

            # *** File name is reserved
            elif [[ $name == $reserved || ($bn_file == $reserved && -z $name) ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[CE2]
                    return 2
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[CE2]
                fi
                return 0

            # *** More arguments than needed were used
            elif [[ ! -z "$3" ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[AE2]
                    tb_print_help
                    return 1
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[AE2]
                fi
                return 0
                
            # *** Symlink already exists in config directory, and no name was given (not using force)
            elif [[ -h "$config_files_dir/${file:t}" && -z $name ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[CE3] "\"$cyan${file:t}$reset\""
                    return 2
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[CE3] "\"$cyan${file:t}$reset\""
                fi
                return 0

            # *** Symlink already exists in config directory
            elif [[ -L "$config_files_dir/$name" && ! -z $name ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[CE3] "\"$cyan$name$reset\""
                    return 2
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[CE3] "\"$cyan$name$reset\""
                fi
                return 0

            # *** name is used as well as no-suffix
            elif [[ ! -z $name && $flags[no_suffix] == "1" ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[FE1] "$yellow--no-suffix$reset when argument ${cyan}name$reset is used (\"$cyan$name$reset\")"
                    tb_print_help
                    return 3
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[FE1] "$yellow--no-suffix$reset when argument ${cyan}name$reset is used (\"$cyan$name$reset\")"
                fi
                return 0
            fi
            
            local link_name=$bn_file

            # Symlink <file> normally and rename later if necessary
            # If no name is given and no-suffix is used, then link name will be the file without suffix
            if [[ -z $name && "$flags[no_suffix]" == "1" ]]; then
                link_name=${link_name%.*}
            elif [[ ! -z $name ]]; then
                link_name=$name
            fi

            ln -s $file "$config_files_dir/$link_name"
            if (( $flags[verbose] == 1 )); then
                tb_info "Created symlink for $cyan$file$reset called $cyan$link_name$reset."
            fi
        
            if (( $flags[force] == 0 )); then
                tb_success "Successfully created config file \"$cyan$link_name$reset\" for $file."
            fi
            return 0
            
           
        # REMOVE COMMAND =======================================================
        elif [[ $cmd_mode == "remove" || $cmd_mode == "rm" || $cmd_mode == "r" ]]; then
            
            for arg in "$@"; do
                local name="$1"
                local file="$config_files_dir/$name"          
                shift
                
                # ERROR CHECKS
                # *** Symlink <name> does not exist (and not using force)
                if [[ ! -L $file ]]; then
                    if (( $flags[force] == 0 )); then
                        tb_error $error_list[CE1] "\"$cyan$file$reset\""
                        return 2
                    fi

                    if (( $flags[verbose] == 1 )); then
                        tb_warn $error_list[CE1] "\"$cyan$file$reset\""
                    fi
                    continue

                # *** More arguments than needed were used
                elif [[ ! -z "$2" ]]; then
                    if (( $flags[force] == 0 )); then
                        tb_error $error_list[AE2]
                        tb_print_help
                        return 1
                    fi

                    if (( $flags[verbose] == 1 )); then
                        tb_warn $error_list[AE2]
                    fi
                    continue
                fi
                
                rm $file
                
                if (( $flags[force] == 0 )); then
                    tb_success "Successfully removed config \"${cyan}$name${reset}\"."
                fi
            done

            return 0

        # EDIT COMMAND ========================================================
        elif [[ "$cmd_mode" == "edit" || $cmd_mode == "e" ]]; then

            local old_name="$1"
            local new_name="$2"
            
            local old_file="$config_files_dir/$old_name"
            local new_file="$config_files_dir/$new_name"

            if (( $flags[link] == 1 )); then
                echo "using link flag"
                new_file="$(realpath -m $new_name)"
            fi            

            echo "DEBUG old_file=$old_file, new_file=$new_file, old_name=$old_name, new_name=$new_name"
            
            # ERROR CHECKS
            # *** Symlink <name> does not exist (and not using force)
            if [[ ! -f $old_file ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[CE1] "\"$cyan$old_file$reset\""
                    return 2
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[CE1] "\"$cyan$old_file$reset\""
                fi
                return 0

            
            # *** Using --link, but <new file> does not exist
            elif [[ ! -f $new_file && "$flags[link]" == "1" ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[CE1] "\"$cyan$new_file$reset\""
                    return 2
                fi
                return 0
            
            # *** File name is reserved
            elif [[ $name == $reserved || ($bn_file == $reserved && -z $name) ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[CE2]
                    return 2
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[CE2]
                fi
                return 0

            # *** More arguments than needed were used
            elif [[ ! -z "$3" ]]; then
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[AE2]
                    tb_print_help
                    return 1
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[AE2]
                fi
                return 0
                
            fi
            
            # If using edit command for changing name of config file
            if (( $flags[link] == 0 )); then
                cp -R "$old_file" "$new_file"
                rm "$old_file"

                local tmp_msg="Successfully renamed config \"${cyan}$old_name${reset}\" "
                tmp_msg+="to \"${cyan}$new_name${reset}\"."
                
            # If using edit command for redirecting existing config file to new location
            else
                rm "$old_file"
                ln -s "$new_file" "$old_file"

                local tmp_msg="Successfully redirected config \"${cyan}$old_name${reset}\" "
                tmp_msg+="to point to \"${cyan}$new_file${reset}\"."
            fi

            if (( $flags[force] == 0 )); then
                tb_success $tmp_msg
            fi
            return 0

        # HELP COMMAND ========================================================
        elif [[ $cmd_mode == "help" || $cmd_mode == "h" ]]; then
            tb_print_help
            return 0

        # LIST COMMAND ========================================================
        elif [[ $cmd_mode == "list" || $cmd_mode == "ls" || $cmd_mode == "l" ]]; then
            local max_length="50"
            local cur_length="0"

            typeset -a bn_files

            for file in "$config_files_dir"/*(N); do
                local bn_file=$(basename $file)

                if [[ $bn_file != $reserved ]]; then

                    local count_reg='%([BSUbfksu]|([FK]|){*})'
                    local len=${#${(S%%)bn_file//$~count_reg/}} 

                    if (( len > cur_length )) && (( len < max_length )); then
                        cur_length=$len
                    fi

                    bn_files+=$bn_file
                fi

            done

            h=$(realpath ~)
            for file in $bn_files; do
                if [[ $file != $reserved ]]; then
                    p=$(readlink "$config_files_dir/$file")
                    if [[ ${p:0:${#h}} == $h ]]; then
                        echo "  $green$bold${(r($cur_length)( ))file}$reset  ->  ~${p:${#h}}"
                    else
                        echo "  $green$bold${(r($cur_length)( ))file}$reset  ->  $p"
                    fi
                fi
            done
            echo ""
            return 0

        # TRY OPENING CONFIG FILE =============================================
        else
            local name=$cmd_mode
            local file="$config_files_dir/$name"

            if [[ -h $file ]]; then
                /usr/local/bin/nvim $(readlink $file)
                return 0

            else
                if (( $flags[force] == 0 )); then
                    tb_error $error_list[AE3] "\"$cyan$file$reset\""
                    tb_print_help
                    return 1
                fi

                if (( $flags[verbose] == 1 )); then
                    tb_warn $error_list[AE3] "\"$cyan$file$reset\""
                fi
                return 0
            fi
        fi
    else 
        if (( $flags[force] == 0 )); then
            tb_error $error_list[AE0]
            tb_print_help
            return 1
        fi

        if (( $flags[verbose] == 1 )); then
            tb_warn $error_list[AE0]
        fi
        return 0
    fi
}
