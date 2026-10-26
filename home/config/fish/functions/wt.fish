function wt --description "Pick a git worktree and open in VSCode"
    set dir (git worktree list | fzf --height 40% --border | awk '{print $1}')
    test -n "$dir" && code $dir
end
