# Ctrl-X: ghq のリポジトリを peco で選んで cd（以前は oh-my-fish のパッケージだった）
function peco_select_ghq_repository
    set -l dir (ghq list -p | peco --query (commandline -b))
    if test -n "$dir"
        commandline -r ''
        cd $dir
    end
    commandline -f repaint
end
