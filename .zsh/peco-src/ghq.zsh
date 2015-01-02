# cf. http://weblog.bulknews.net/post/89635306479/ghq-peco-percol

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
    zle clear-screen
}
zle -N peco-src