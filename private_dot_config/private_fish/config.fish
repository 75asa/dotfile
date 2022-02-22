switch (uname -m)
case x86_64
  set HOMEBREW_DIR /usr/local
case arm64
  set HOMEBREW_DIR /opt/homebrew
end

# Homebrew
set -U fish_user_paths "$HOMEBREW_DIR/bin" $fish_user_paths

# Homebrew
eval ($HOMEBREW_DIR/bin/brew shellenv)

# Rust
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin

# Example aliases
alias g='git'
alias act='act --container-architecture linux/amd64 '
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
alias tr='tree -N'
alias l 'ls -SAlh'
alias ep "echo $PATH | gsed 's/ /\\n/g'"
alias cpwd 'pwd | pbcopy'
alias gcc='gitmoji -c'

# 文字コードの指定
set -x LANG ja_JP.UTF-8

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
end


function history-merge --on-event fish_preexec
  history --save
  history --merge
end

function pwcp
  pwd | pbcopy
end
