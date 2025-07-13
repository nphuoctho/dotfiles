# ===============================
# 🖥️ Powerlevel10k Instant Prompt
# ===============================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===============================
# 🎨 Theme: Powerlevel10k
# ===============================
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# ===============================
# 📦 Oh-My-Zsh Plugins
# ===============================
plugins=()

# ===============================
# 🔐 SSH Agent Auto-Start
# ===============================
if [[ -z "$SSH_AUTH_SOCK" ]]; then
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/github
fi

# ===============================
# 📁 Aliases: File & Directory
# ===============================
alias c='clear'
alias ls='eza -1 --icons=auto'
alias l='eza -lh --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias mkdir='mkdir -p'

# ===============================
# 📦 Aliases: Package Manager (AUR Helper)
# ===============================
alias un='$aurhelper -Rns'
alias up='$aurhelper -Syu'
alias pl='$aurhelper -Qs'
alias pa='$aurhelper -Ss'
alias pc='$aurhelper -Sc'
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'

# ===============================
# 🚀 Aliases: Apps & Tools
# ===============================
alias vc='code'
alias nf='nvim "$(fzf)"'
alias ld='lazydocker'
alias lg='lazygit'
alias lq='lazysql'
alias yz='yazi "$(zoxide query)"'

# ===============================
# 📂 Directory Shortcuts
# ===============================
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# ===============================
# 🗺️ Zoxide: Directory Jumper
# ===============================
eval "$(zoxide init zsh)"

# ===============================
# 📝 Environment Variables
# ===============================
export EDITOR=nvim
export VISUAL=nvim

# ===============================
# 🔧 NVM: Node Version Manager
# ===============================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# ===============================
# 🌟 Starship Prompt (optional)
# ===============================
eval "$(starship init zsh)"

# ===============================
# 🎨 Pokemon Colorscripts (on login)
# ===============================
pokemon-colorscripts --no-title -r 1,3,6

