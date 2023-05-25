alias v=nvim
alias t=tmux
alias tmuxsource="tmux source ~/.config/tmux/tmux.conf"
alias ta="tmux a -t"
alias lg="lazygit"
alias xsc="pbcopy" #mac
#alias xsc="xclip -selection clipboard" #linux

lt() {
  tree -I "node_modules" "$@" -C | less -r
}
alias retab='nvim -s <(echo -e "gg=G\n:retab\nZZ")'

# lfcd
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

source ~/.config/lf/icons

export PATH="$HOME/dev/flutter/bin:$PATH"

# keep this at the end
eval "$(starship init zsh)"
