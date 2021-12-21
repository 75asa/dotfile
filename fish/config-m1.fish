# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# Rust
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin


if status is-interactive
    # Commands to run in interactive sessions can go here
end

# 追加したソフトやパッケージ用のコマンドパスを通す
set -x PATH /usr/local/bin $PATH
# Example aliases
alias g='git'
alias gs='git status'
alias gb='git branch'
alias gd='git diff'
alias gg='git grep'
alias ga='git add'
alias gl='git log'
alias gct='git commit'
alias gcz='git cz'
alias gco='git checkout'
alias vi='vim'
alias so='source'
alias o='open'
alias hr='heroku'
alias input_date='`date "+%Y%m%d_%H%M%S"`'
alias art='php artisan'
alias arts='php artisan serve'
alias tr='tree -N'
alias l 'ls -SAlh'
alias ep "echo $PATH | gsed 's/ /\\n/g'"
alias cpwd 'pwd | pbcopy'

# 文字コードの指定
set -x LANG ja_JP.UTF-8

# jpegoptim
alias jo='jpegoptim'

# openssl powerd by Homebrew
set -x PATH "/usr/local/opt/openssl/bin $PATH"
# libxml2
set -x PATH "/usr/local/opt/libxml2/bin $PATH"

# postgresql v.10
set -gx PATH "/usr/local/opt/postgresql@10/bin $PATH"

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

function peco_sync_select_history
  history-merge
  peco_select_history $argv
end

function cd
  builtin cd $argv
  ls -la
end

function peco
  command peco --layout=bottom-up $argv
end

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \c] 'stty sane; peco_select_ghq_repository'
  # bind \c] peco_select_ghq_repository
end


function history-merge --on-event fish_preexec
  history --save
  history --merge
end

# gitのリモート先(git remote -v)に指定されたリポジトリを開く
function openhub
  open (git remote -v | sed -n $argv[1]p | awk '{ print $2 }' | awk -F '[/]' '{ print $4 "/" $5}' | awk -F '.git' '{ print "https://github.com/" $1 }')
end

# neofetch起動
# function fish_greeting
#   neofetch
# end

function pwcp
  pwd | pbcopy
end

balias g git


set -gx LDFLAGS "-L/usr/local/opt/libxml2/lib"
set -gx CPPFLAGS "-I/usr/local/opt/libxml2/include"

# bison
set -g fish_user_paths "/usr/local/opt/bison/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/libxml2/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/icu4c/lib"
set -gx CPPFLAGS "-I/usr/local/opt/icu4c/include"
set -g fish_user_paths "/usr/local/opt/libiconv/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/libiconv/bin" $fish_user_paths
set -g fish_user_paths "$HOME/.anyenv/envs/phpenv/shims/composer" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/postgresql@10/bin" $fish_user_paths
set -gx PGDATA /usr/local/var/postgres/
set -g fish_user_paths "/usr/local/opt/libpcap/bin" $fish_user_paths

# tmux
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
# mongo
set -g fish_user_paths "/usr/local/opt/mongodb-community@4.0/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths



