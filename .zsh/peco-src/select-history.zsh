# cf. http://blog.shibayu36.org/entry/2014/06/27/223538
# cf. http://qiita.com/wada811/items/78b14181a4de0fd5b497
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    # zle clear-screen
}
zle -N peco-select-history