# fish（個人用 Mac のログインシェル）
# PATH は universal 変数（fish_user_paths）に溜めず、起動のたびにここで組み立てる

if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
end

# Claude Code / git-wt / uv など ~/.local/bin のコマンド
fish_add_path -g ~/.local/bin
fish_add_path -g -a ~/.cargo/bin
test -d ~/.docker/bin; and fish_add_path -g -a ~/.docker/bin

# 文字コードの指定
set -x LANG ja_JP.UTF-8

# === alias ===
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
alias tr='tree -N'
alias l 'ls -SAlh'
alias ep "echo $PATH | gsed 's/ /\\n/g'"
alias cpwd 'pwd | pbcopy'
alias gmc 'gitmoji -c'

# === functions ===
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
    bind \cx 'stty sane; peco_select_ghq_repository'
end

function history-merge --on-event fish_preexec
    history --save
    history --merge
end

function pwcp
    pwd | pbcopy
end

# === tools ===
if type -q mise
    mise activate fish | source
end

if type -q direnv
    direnv hook fish | source
end

# git-wt: `git wt <branch>` で worktree 作成 + cd
if type -q git-wt
    git wt --init fish | source
end

# OrbStack（入っていれば）
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
