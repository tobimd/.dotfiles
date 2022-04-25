set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

"{{ The Basics }}
    Plug 'gmarik/Vundle.vim'                                 " Vundle
    Plug 'itchyny/lightline.vim'                             " Lightline statusbar
    Plug 'suan/vim-instant-markdown', {'for':'markdown'}     " Markdown Preview
    Plug 'frazrepo/vim-rainbow'                              " Colored brackets
    Plug 'xuhdev/vim-latex-live-preview', {'for':'tex'}      " Latex preview
    Plug 'psliwka/vim-smoothie'                              " Smooth scrolling
    
"{{ File management }}
    Plug 'scrooloose/nerdtree'                               " Nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'           " Highlightin Nerdtree
    Plug 'ryanoasis/vim-devicons'                            " Icons for Nerdtree

"{{ Productivity }}
    Plug 'vimwiki/vimwiki'                                   " VimWiki 
    Plug 'jreybert/vimagit'                                  " Magit-like plugin for vim

"{{ Workflow }}
    Plug 'neoclide/coc.nvim', {'branch': 'release'}          " Conqueror Of Completion
    Plug 'dense-analysis/ale'                                " Get linters and fixers
    Plug 'psf/black', {'branch': 'stable'}                   " 'Black' python fixer
    Plug 'tpope/vim-surround'                                " Change surrounding marks
    Plug 'preservim/nerdcommenter'                           " Comment functions
    
"{{ Syntax Highlighting }}
    Plug 'PotatoesMaster/i3-vim-syntax'                      " i3 config highlighting
    Plug 'kovetskiy/sxhkd-vim'                               " sxhkd highlighting
    Plug 'vim-python/python-syntax'                          " Python highlighting
    Plug 'ap/vim-css-color'                                  " Color previews for CSS
    Plug 'octol/vim-cpp-enhanced-highlight'                  " C/C++ syntax highlighting

"{{ Colorschemes }}
   "Plug 'wojciechkepka/vim-github-dark'                     " Dark Github-like colorscheme
    Plug 'fratajczak/one-monokai-vim'                        " One Monokai colorscheme
    Plug 'wojciechkepka/bogster'                             " Bogster colorscheme

"{{ Junegunn Choi Plugins }}
    Plug 'junegunn/goyo.vim'                                 " Distraction-free viewing
    Plug 'junegunn/limelight.vim'                            " Hyperfocus on a range
    Plug 'junegunn/vim-emoji'                                " Vim needs emojis!

call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=**					" Searches current directory recursively.
set wildmenu					" Display all matches when tab complete.
set incsearch                   " Incremental search
set hidden                      " Needed to keep multiple buffers open
set nobackup                    " No auto backups
set noswapfile                  " No swap
set t_Co=256                    " Set if term supports 256 colors.
set number relativenumber       " Display line numbers
set clipboard=unnamedplus       " Copy/paste between vim and other programs.
syntax enable
let g:rehash256 = 1
set timeoutlen=300
set encoding=utf8
set shell=bash\ -i              " Set default shell as interactive
set linebreak

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The <leader> key will be the comma
let mapleader = ","
let g:mapleader = ","

" Escape insert mode 
:inoremap ii <Esc>

" Start writing on new line below
:inoremap iio <Esc>o

" Start writing on new line on top
:inoremap IIO <Esc>O

" Save and continue writing
:inoremap iwi <Esc>:w<CR>i

" Save and exit insert mode
:inoremap iww <Esc>:w<CR>

" Save and exit vim
:inoremap iwq <Esc>:wq<CR>

" Add new line after cursor
:nnoremap oo m`o<Esc>``
:nnoremap ooo oo

" Add new line before cursor
:nnoremap OO m`O<Esc>``
:nnoremap OOO OO

" Spacebar -> add space character
:nnoremap <Space> i <Esc>

" Toggle ignore casing when searching
:nnoremap <Leader>I :set ignorecase! ignorecase?<CR>

" Save using Ctrl+S
:nnoremap <C-S> :w<CR>
:vnoremap <C-S> <Esc>:w<CR>
:inoremap <C-S> <Esc>:w<CR>a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CoC configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.config/nvim/cocconfig.vim

let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-css',
    \ 'coc-eslint',
    \ 'coc-html',
    \ 'coc-html-css-support',
    \ 'coc-json',
    \ 'coc-markdownlint',
    \ 'coc-prettier',
    \ 'coc-sh',
    \ 'coc-snippets',
    \ ]

command! -nargs=0 Prettier :CocCommand prettier.formatFile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {'python': ['flake8', 'pydocstyle']}
let g:ale_fixers = {'*': [], 'python': ['black', 'isort']}
let g:ale_fix_on_save = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show statusline
set laststatus=2

" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Be smart using tabs ;)
set shiftwidth=4                " One tab == four spaces.
set tabstop=4                   " One tab == four spaces.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable=''
let g:NERDTreeDirArrowCollapsible=''
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeShowHiddenFirst=1
let NERDTreeMinimalUI=1
let NERDTreeCascadeSingleChildDir=1
let g:NERDTreeWinSize=38

" List of symbols and their unicode value
" <symbol>     <code>
"             f107
"             f105
"             f063
"             f061
"             f0ab
"             f0a9

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Theming
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gh_color = "soft"

syntax on
set termguicolors

colorscheme one-monokai
" colorscheme github-dark
" colorscheme bogster

highlight CursorLineNr     guifg=#202328 ctermfg=7    guifg=#ea9444 ctermbg=8     cterm=none
" highlight Normal           guifg=#dfdfdf ctermfg=15   guibg=#282c34 ctermbg=none  cterm=none
" highlight LineNr           guifg=#5b6268 ctermfg=8    guibg=#282c34 ctermbg=none  cterm=none
" highlight VertSplit        guifg=#1c1f24 ctermfg=0    guifg=#5b6268 ctermbg=8     cterm=none
" highlight Statement        guifg=#98be65 ctermfg=2    guibg=none    ctermbg=none  cterm=none
" highlight Directory        guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
" highlight StatusLine       guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
" highlight StatusLineNC     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
" highlight NERDTreeClosable guifg=#98be65 ctermfg=2
" highlight NERDTreeOpenable guifg=#5b6268 ctermfg=8
" highlight Comment          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=italic
" highlight Constant         guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
" highlight Special          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
" highlight Identifier       guifg=#5699af ctermfg=6    guibg=none    ctermbg=none  cterm=none
" highlight PreProc          guifg=#c678dd ctermfg=5    guibg=none    ctermbg=none  cterm=none
" highlight String           guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
" highlight Number           guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
" highlight Function         guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
" highlight Visual           guifg=#dfdfdf ctermfg=1    guibg=#1c1f24 ctermbg=none  cterm=none

" highlight WildMenu         ctermfg=0       ctermbg=80      cterm=none
" highlight Folded           ctermfg=103     ctermbg=234     cterm=none
" highlight FoldColumn       ctermfg=103     ctermbg=234     cterm=none
" highlight DiffAdd          ctermfg=none    ctermbg=23      cterm=none
" highlight DiffChange       ctermfg=none    ctermbg=56      cterm=none
" highlight DiffDelete       ctermfg=168     ctermbg=96      cterm=none
" highlight DiffText         ctermfg=0       ctermbg=80      cterm=none
" highlight SignColumn       ctermfg=244     ctermbg=235     cterm=none
" highlight Conceal          ctermfg=251     ctermbg=none    cterm=none
" highlight SpellBad         ctermfg=168     ctermbg=none    cterm=underline
" highlight SpellCap         ctermfg=80      ctermbg=none    cterm=underline
" highlight SpellRare        ctermfg=121     ctermbg=none    cterm=underline
" highlight SpellLocal       ctermfg=186     ctermbg=none    cterm=underline
" highlight Pmenu            ctermfg=251     ctermbg=234     cterm=none
" highlight PmenuSel         ctermfg=0       ctermbg=111     cterm=none
" highlight PmenuSbar        ctermfg=206     ctermbg=235     cterm=none
" highlight PmenuThumb       ctermfg=235     ctermbg=206     cterm=none
" highlight TabLine          ctermfg=244     ctermbg=234     cterm=none
" highlight TablineSel       ctermfg=0       ctermbg=247     cterm=none
" highlight TablineFill      ctermfg=244     ctermbg=234     cterm=none
" highlight CursorColumn     ctermfg=none    ctermbg=236     cterm=none
" highlight CursorLine       ctermfg=none    ctermbg=236     cterm=none
" highlight ColorColumn      ctermfg=none    ctermbg=236     cterm=none
" highlight Cursor           ctermfg=0       ctermbg=5       cterm=none
" highlight htmlEndTag       ctermfg=114     ctermbg=none    cterm=none
" highlight xmlEndTag        ctermfg=114     ctermbg=none    cterm=none

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimWiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Instant-Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:instant_markdown_autostart = 0         " Turns off auto preview
let g:instant_markdown_browser = "firefox"   " Uses surf for preview
let g:instant_markdown_mathjax = 1           " Allow TeX commands
map <Leader>md :InstantMarkdownPreview<CR> 
map <Leader>ms :InstantMarkdownStop<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Open terminal inside Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>tt :vnew term://alacritty<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mouse Scrolling
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=nicr
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fix Sizing Bug With Alacritty Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright

" Make adjusing split sizes a bit more friendly
nnoremap <nowait> <C-a>h :exe "vertical resize " . (winwidth(0) * 9/10)<CR>
nnoremap <nowait> <C-a>j :exe "resize " . (winheight(0) * 9/10)<CR>
nnoremap <nowait> <C-a>k :exe "resize " . (winheight(0) * 10/9)<CR>
nnoremap <nowait> <C-a>l :exe "vertical resize " . (winwidth(0) * 10/9)<CR>

" Removes pipes | that act as seperators on splits
set fillchars+=vert:\ 

" Create the split windows
map <Leader>sh :split<CR>
map <Leader>sv :vsplit<CR>

" Switch window mappings /*{{{*/
nnoremap <A-Up> :normal <c-r>=SwitchWindow('+')<CR><CR>
nnoremap <A-Down> :normal <c-r>=SwitchWindow('-')<CR><CR>
nnoremap <A-Left> :normal <c-r>=SwitchWindow('<')<CR><CR>
nnoremap <A-Right> :normal <c-r>=SwitchWindow('>')<CR><CR>

function! SwitchWindow(dir)
  let this = winnr()
  if '+' == a:dir
    execute "normal \<c-w>k"
    elseif '-' == a:dir
    execute "normal \<c-w>j"
    elseif '>' == a:dir
    execute "normal \<c-w>l"
    elseif '<' == a:dir
    execute "normal \<c-w>h"
  else
    echo "oops. check your ~/.vimrc"
    return ""
  endif
endfunction
" /*}}}*/

:imap <C-w> <C-o><C-w>


" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_highlight_all = 1

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
"set guifont=SauceCodePro\ Nerd\ Font:h15
set guifont=Mononoki\ Nerd\ Font:h15
"set guifont=JetBrains\ Mono:h15

let g:neovide_transparency=0.95
