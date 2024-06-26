# general
alias ls="${LS_HOME:-"/bin/ls"} -FAGgHop --color=always -X --group-directories-first --si"
alias la="${LS_HOME:-"/bin/ls"} -FAGHpC --color=always -X --group-directories-first --si"
alias lo="${LS_HOME:-"/bin/ls"} -F --color=always -X --group-directories-first --si"
alias ll="${LS_HOME:-"/bin/ls"} -lFAHp --color=always -X --group-directories-first --si"
alias sed="${SED_HOME:-"/usr/bin/sed"}"
alias zsource="source $HOME/.zsh/.zshrc"
alias bsource="source $HOME/.bashrc"
alias wget="wget --hsts-file=/dev/null"
alias vim="nvim"
alias scrot="/usr/bin/scrot --file '/tmp/screenshots/screenshot_%y-%m-%d_\$wx\$h.png' -fs"
alias cpc="xclip -sel c <"
alias cppng="xclip -sel c -t image/png "
alias cpjpg="xclip -sel c -t image/jpg "
alias ssh="TERM=xterm-256color $(which ssh)"
alias time="gtime -p"
alias o="xdg-open"

# paths
alias cd~='cd ~'
alias ..='cd ../'
alias cd..='cd ../'
alias ...='cd ../../'
alias cd...='cd ../../'
alias ....='cd ../../../'
alias cd....='cd ../../../'

# nix
alias nxsh='nix-shell'
alias nxshell='nix-shell'

# mosquitto
alias mq="mosquitto -c '/usr/local/etc/mosquitto/mosquitto.conf'"
alias mqn="mosquitto -c '/usr/local/etc/mosquitto/mosquitto.conf' >/dev/null 2>&1 & disown"
alias mqd="mosquitto -d -c '/usr/local/etc/mosquitto/mosquitto.conf'"
alias mqdn="mosquitto -d -c '/usr/local/etc/mosquitto/mosquitto.conf' >/dev/null 2>&1 & disown"
alias mqdv="mosquitto -d -v -c '/usr/local/etc/mosquitto/mosquitto.conf'"
alias mqdvn="mosquitto -d -v -c '/usr/local/etc/mosquitto/mosquitto.conf' >/dev/null 2>&1 & disown"
alias mqsub="mosquitto_sub -t "
alias mqpub="mosquitto_pub -t "

# python
alias venv-start="startvenv"
alias venv-create="python3 -m venv"
alias venv-stop="deactivate"
alias py="python3"
alias python="python3"
alias pip="pip3"
alias pytest="python3 -m unittest"

# flutter
alias fl="${USE_FVM:-""}flutter"
alias flpg="${USE_FVM:-""}flutter pub get"
alias flpa="${USE_FVM:-""}flutter pub add"
alias fldoc="${USE_FVM:-""}flutter doctor"
alias flr="${USE_FVM:-""}flutter run"
alias flrv="${USE_FVM:-""}flutter run --verbose"
alias fvmu="fvm use"
alias fvml="fvm list"

# docker
alias dk="docker"
alias dkl="docker pull"
alias dkp="docker push"
alias dkb="docker build -t"
alias dkx="docker buildx build -t"
alias dkr="docker run --rm -it"
alias dks="docker stop -t 0"
alias dke="docker exec -it"
alias dkll="docker logs -f"
alias dklogs="docker logs"
alias dkps="docker ps"
alias dkpsa="docker ps -a"
alias dkcpf="docker container prune -f"
alias dkipf="docker image prune -f"
alias dkils="docker image ls"
alias dkcls="docker container ls"
alias dki="docker image"
alias dkc="docker container"
alias dkcm="docker compose"
alias dkcu="docker compose up"
alias dkcd="docker compose down"
alias dkrun="docker run"
alias dkcrm="docker rm"
alias dkirm="docker rmi"
alias dkccp="docker cp"

# git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'
alias gapt='git apply --3way'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*($(git_main_branch)|development|develop|devel|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbD='git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit --allow-empty -m'
alias gcas='git commit -a -s'
alias gcasm='git commit -a -s -m'
alias gcsm='git commit -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcl='git clone --recurse-submodules'
alias gclean='git clean -id'
alias gpristine='git reset --hard && git clean -dffx'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout develop'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdnolock='git diff $@ ":(exclude)package-lock.json" ":(exclude)&ast;.lock"'
alias gdv='git diff -w $@ | view -'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfg='git ls-files | grep'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggf='git push --force origin $(current_branch)'
alias ggfl='git push --force-with-lease origin $(current_branch)'
alias ggl='git pull origin $(current_branch)'
alias ggp='git push origin $(current_branch)'
alias ggpnp='ggl && ggp'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpur='ggu'
alias ggpush='git push origin "$(git_current_branch)"'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ggu='git pull --rebase origin $(current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'
alias gk='gitk --all --branches'
alias gke='gitk --all $(git log -g --pretty=%h)'
alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --stat'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --all'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp='git log --pretty=\<format\>'
alias glst='git ls-tree --full-tree --name-only -r HEAD'
alias gm='git merge'
alias gmom='git merge origin/$(git_main_branch)'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gma='git merge --abort'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpu='git push upstream'
alias gpv='git push -v'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase develop'
alias grbi='git rebase -i'
alias grbm='git rebase $(git_main_branch)'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grev='git revert'
alias grss='git reset --soft'
alias grhh='git reset --hard'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'
alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash push'
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='git stash --include-untracked'
alias gstall='git stash --all'
alias gsi='git submodule init'
alias gsu='git submodule update'
alias gsa='git submodule add'
alias gsw='git switch'
alias gswc='git switch -c'
alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gtl='gtl(){ git tag --sort=-v:refname -n -l ${1}* }; noglob gtl'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias glum='git pull upstream $(git_main_branch)'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias gam='git am'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gama='git am --abort'
alias gamscp='git am --show-current-patch'
