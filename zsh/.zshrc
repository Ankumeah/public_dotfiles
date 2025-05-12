# === SYSTEM INFO ===
fastfetch

# === ALIASES ===
alias kitty_bar='kitty +kitten panel --edge=background -o font_size=16 -o background_opacity=0.4 $1'
alias cmatrix='cmatrix -C cyan'
alias python='python3'
alias ls='ls --color=auto'
alias bop="play -n synth 0.1 sin 880"
alias chwal="~/.config/change_wallpaper/change_wallpaper.sh"

# === ENVIRONMENT ===
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# === PATH STUFF ===
export PATH="$HOME/.local/bin:$PATH"
. "$HOME/.cargo/env"

# === SETUP ===
eval "$(starship init zsh)"
wal -R > ~/.config/.logs/wal
export EDITOR=nvim
export VISUAL=nvim

# Enable some helpful options
autoload -Uz compinit && compinit
setopt histignoredups      # don’t record duplicate history
setopt share_history       # share history between sessions
# Set history file and size
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Share history across sessions
setopt append_history
setopt share_history

# === Fix Home / End keys ===
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

# === Plugins ===
source ~/.config/zsh/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Optional tweaks
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(completion)

color4=$(jq -r '.colors.color4' ~/.cache/wal/colors.json)
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$color4"
echo $colors
