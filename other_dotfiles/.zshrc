bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias v=nvim
alias t=tmux
alias so="source .zshrc"
alias tmuxsource="tmux source ~/.config/tmux/tmux.conf"
alias ta="tmux a -t"
alias wiki="ts ~/vimwiki"
alias conf="ts ~/.config/nvim"
alias lg="lazygit"
# alias xsc="pbcopy" #mac
#alias xsc="xclip -selection clipboard" #linux
alias xsc="wl-copy" #wayland
alias resetsshagent="killall ssh-agent; eval `ssh-agent`"
alias s='rg --files --hidden --glob "!.git" | fzf'
alias sd='cd $(s | xargs dirname)'
alias sv='nvim $(s)'

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
source "$HOME/.cargo/env"

export CHROME_EXECUTABLE="/var/lib/flatpak/app/com.google.Chrome/current/active/export/bin/com.google.Chrome"

export PATH="$HOME/dev/flutter/bin:$PATH"

# For invokeAI AMD GPU
export HSA_OVERRIDE_GFX_VERSION=10.3.0

# Unity
# needs mono and dotnet-sdk (7.0.3 or above)
# thanks https://forum.unity.com/threads/vs-code-error-the-reference-assemblies-for-framework-netframework-version-v4-7-1-were-not-foun.706712/
export FrameworkPathOverride=/lib/mono/4.7.1-api

export NDK_HOME="/opt/android-ndk"
export ANDROID_HOME=/home/l/Android/Sdk
export CHROME_EXECUTABLE="/var/lib/flatpak/app/com.google.Chrome/current/active/export/bin/com.google.Chrome"

export PATH="${PATH}:/opt/flutter/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# Mason
export PATH="$PATH:/home/l/.local/share/nvim/mason/bin:$PATH"

# keep this at the end
eval "$(starship init zsh)"
