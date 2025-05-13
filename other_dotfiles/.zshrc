# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/l/.zshrc'

autoload -Uz compinit
compinit

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
# alias xsc="xclip -selection clipboard" #linux
alias xsc="wl-copy" #wayland
alias resetsshagent="killall ssh-agent; eval `ssh-agent`"
alias resetwaybar="killall waybar; hyprctl dispatch exec waybar &"
alias data="cd /mnt/DATA"
alias s='rg --files --hidden --glob "!.git" | fzf'
alias sd='cd $(s | xargs dirname)'
alias sv='nvim $(s)'
alias sudoenv="sudo -E env PATH=$PATH"

how() {
  if [ -z "$1" ]; then
    echo "No search term provided."
    return 1
  fi
  query=$(printf '%q ' "$@")
  sgpt --shell "$query"
}

tnew() {
  if [ -z "$1" ]; then
    echo "No session name provided."
    return 1
  fi

  # Check if tmux session exists
  if tmux has-session -t $1 2>/dev/null; then
    echo "Session $1 already exists."
  else
    tmux new-session -s $1
  fi
}

vs() {
  if [ -f ".vimsession" ]; then
    nvim -S .vimsession
  else
    nvim .
  fi
}

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/l/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/l/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/l/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/l/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export HSA_OVERRIDE_GFX_VERSION=10.3.0

export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$(go env GOPATH)/bin"
export GOPATH=$(go env GOPATH)
# add mason
export PATH="$PATH:/home/l/.local/share/nvim/mason/bin:$PATH"

# java home
export JAVA_HOME="/home/l/jdk/jdk-17.0.10+7"
# End of lines added by compinstall
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/l/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
export ANDROID_HOME="/home/l/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export NDK_HOME="/home/l/Android/Sdk/ndk/27.0.11718014"
export ANDROID_NDK_ROOT="$NDK_HOME"

# bun completions
[ -s "/home/l/.bun/_bun" ] && source "/home/l/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/Apps/bin:$PATH"
export OLLAMA_API_BASE=http://127.0.0.1:11434

export PATH="$HOME/.local/bin:$PATH"

# Odin lang
export PATH="$HOME/.odin:$PATH"

# export VULKAN_SDK="$HOME/VulkanSDK/1.3.296.0/x86_64/"
source /home/l/VulkanSDK/1.3.296.0/setup-env.sh

# export XDG_RUNTIME_DIR="/tmp/"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /home/l/.cache/pnpm/dlx/gjohq4w7nmxx2i3abs2heyqjpm/1910534bd72-f997/node_modules/.pnpm/tabtab@2.2.2/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /home/l/.cache/pnpm/dlx/gjohq4w7nmxx2i3abs2heyqjpm/1910534bd72-f997/node_modules/.pnpm/tabtab@2.2.2/node_modules/tabtab/.completions/electron-forge.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# export XDG_DATA_DIRS="/home/l/.nix-profile/share:$XDG_DATA_DIRS"
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
