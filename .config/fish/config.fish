function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \c] peco_select_ghq_repository
end

# EMACS
function E -d "Open emacs with client session"
  emacsclient -nw $argv
end
function start-emacs -d "start emacs session"
  emacs --daemon
end
function kill-emacs -d "kill emacs session"
  emacsclient -e '(kill-emacs)'
end


