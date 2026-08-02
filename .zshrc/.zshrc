#  ╔═╗╔═╗╦ ╦╦═╗╔═╗  ╔═╗╔═╗╔╗╔╔═╗╦╔═╗	- z0mbi3
#  ╔═╝╚═╗╠═╣╠╦╝║    ║  ║ ║║║║╠╣ ║║ ╦	- https://github.com/gh0stzk/dotfiles
#  ╚═╝╚═╝╩ ╩╩╚═╚═╝  ╚═╝╚═╝╝╚╝╚  ╩╚═╝	- My zsh conf

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#  ┬  ┬┌─┐┬─┐┌─┐
#  └┐┌┘├─┤├┬┘└─┐
#   └┘ ┴ ┴┴└─└─┘
export EDITOR='nvim'
export VISUAL="$EDITOR"
export BROWSER='firefox'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export SUDO_PROMPT="Deploying root access for %u. Password pls: "
export BAT_THEME="base16"
# Java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
# Openproject
export OPENPROJECT_ACCESS_TOKEN='5f36e55b049e276072f90f801c70726415aa0ad032d1fc1d7298c993dae62d10'

#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
autoload -Uz compinit

[[ -d ~/.config/zsh ]] || mkdir -p ~/.config/zsh
zcompdump="$HOME/.config/zsh/zcompdump"

if [[ -n "$zcompdump"(#qN.mh+24) ]]; then
    compinit -i -d "$zcompdump"
else
    compinit -C -d "$zcompdump"
fi

if [[ ! -f "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc" ]]; then
    zcompile -U "$zcompdump"
fi

autoload -Uz add-zsh-hook
_comp_options+=(globdots)

zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':fzf-tab:*' fzf-flags --style=full --height=90% --pointer '>' \
                --color 'pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold,marker:yellow:bold,hl:gray:bold,hl+:yellow:bold' \
                --input-label ' Search ' --color 'input-border:blue,input-label:blue:bold' \
                --list-label ' Results ' --color 'list-border:green,list-label:green:bold' \
                --preview-label ' Preview ' --color 'preview-border:magenta,preview-label:magenta:bold'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always -a $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -1 --icons=always --color=always -a $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'bat --color=always --theme=base16 $realpath'
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
zstyle ':fzf-tab:*' accept-line enter

#  ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
#  ├─┤│└─┐ │ │ │├┬┘└┬┘
#  ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory
setopt sharehistory
setopt extended_history       # save timestamps (history -i)
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#  ┌─┐┌─┐┬ ┬  ┌─┐┌─┐┌─┐┬    ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  ┌─┘└─┐├─┤  │  │ ││ ││    │ │├─┘ │ ││ ││││└─┐
#  └─┘└─┘┴ ┴  └─┘└─┘└─┘┴─┘  └─┘┴   ┴ ┴└─┘┘└┘└─┘
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt LIST_PACKED         # completion menu takes less space
setopt AUTO_LIST           # auto list choices on ambiguous completion
setopt COMPLETE_IN_WORD    # complete from both ends of a word
# MENU_COMPLETE removed — conflicts with fzf-tab (it expects the menu to open, not auto-select)

#  ┌┬┐┬ ┬┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#   │ ├─┤├┤   ├─┘├┬┘│ ││││├─┘ │
#   ┴ ┴ ┴└─┘  ┴  ┴└─└─┘┴ ┴┴   ┴

# PowerLevel10k Theme
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

#  ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
#  ├─┘│  │ ││ ┬││││└─┐
#  ┴  ┴─┘└─┘└─┘┴┘└┘└─┘
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# fzf shell integration (Ctrl-R history, Ctrl-T files, Alt-C cd)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ]   && source /usr/share/fzf/completion.zsh

# zsh-syntax-highlighting MUST be sourced last
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Arrow keys: bind both raw ANSI and terminfo for max portability (kitty app-mode etc.)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" history-substring-search-down
bindkey '^[[3~' delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

#  ┌─┐┬ ┬┌─┐┌┐┌┌─┐┌─┐  ┌┬┐┌─┐┬─┐┌┬┐┬┌┐┌┌─┐┬  ┌─┐  ┌┬┐┬┌┬┐┬  ┌─┐
#  │  ├─┤├─┤││││ ┬├┤    │ ├┤ ├┬┘│││││││├─┤│  └─┐   │ │ │ │  ├┤
#  └─┘┴ ┴┴ ┴┘└┘└─┘└─┘   ┴ └─┘┴└─┴ ┴┴┘└┘┴ ┴┴─┘└─┘   ┴ ┴ ┴ ┴─┘└─┘
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (kitty*|alacritty*|tmux*|screen*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias update="paru -Syu --nocombinedupgrade"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias music="ncmpcpp"

alias cat='bat'   # theme via BAT_THEME env var
alias ls='eza --icons=always --color=always -a'
alias ll='eza --icons=always --color=always -la'
alias lzq='lazysql'
alias lzg='lazygit'
alias lzd='lazydocker'
alias yz='yazi'

# AWS CLI Alias
alias ec2ls="aws ec2 describe-instances \
  --query \"Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key=='Name']|[0].Value,State:State.Name,Type:InstanceType,PublicIP:PublicIpAddress}\" \
  --output table"

ec2pick() {
  aws ec2 describe-instances \
    --query "Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key=='Name']|[0].Value,State:State.Name}" \
    --output text | \
  fzf --no-multi --header="Select EC2 instance" | awk '{print $1}'
}
ec2startf() {
  id=$(ec2pick)
  [ -n "$id" ] && aws ec2 start-instances --instance-ids "$id"
}
ec2stopf() {
  id=$(ec2pick)
  [ -n "$id" ] && aws ec2 stop-instances --instance-ids "$id"
}
ec2rebootf() {
  id=$(ec2pick)
  [ -n "$id" ] && aws ec2 reboot-instances --instance-ids "$id"
}

# Fuzzy Search — functions to handle spaces in filenames + cancel-safe (Ctrl-C → no-op)
alias f='fd'                                                                 # fd thay cho find
alias ff='fzf --preview "bat --style=numbers --color=always {}"'             # preview only
alias fdn='fd -t f'                                                          # tìm file theo pattern
alias fh='history | fzf'                                                     # local fallback (Ctrl-R đã có sẵn từ fzf-keybindings)

fcd() { local d; d=$(fd -t d | fzf) && [ -n "$d" ] && cd "$d"; }            # cd fuzzy (or use Alt-C)
fe()  { local f; f=$(fzf) && [ -n "$f" ] && nvim "$f"; }                    # open in nvim
fn()  { local f; f=$(fd -t f | fzf --preview "bat --color=always {}") && [ -n "$f" ] && nvim "$f"; }

# Ripgrep + fzf with live reload (avoids loading whole repo into fzf upfront)
frg() {
  local rg_cmd="rg --line-number --no-heading --color=always --smart-case"
  fzf --ansi --disabled --query "${1:-}" \
      --bind "start:reload:$rg_cmd {q}" \
      --bind "change:reload:sleep 0.1; $rg_cmd {q} || true" \
      --delimiter : --preview 'bat --color=always {1} --highlight-line {2}'
}

# Git Files — include tracked + untracked (exclude gitignored)
alias gf='git ls-files --cached --others --exclude-standard | fzf'
gfe() { local f; f=$(git ls-files --cached --others --exclude-standard | fzf) && [ -n "$f" ] && nvim "$f"; }

# Zoxide — init tạo lệnh `z` (jump) và `zi` (interactive)
eval "$(zoxide init zsh)"
alias zz='cd "$(zoxide query -l | fzf)"' # jump bằng fzf
alias zr='zoxide query -l' # xem rank thư mục
alias tx='tmux'

#  ┌─┐┌─┐┬ ┬  ┬┌─┌─┐┬ ┬┌─┐
#  └─┐└─┐├─┤  ├┴┐├┤ └┬┘└─┐
#  └─┘└─┘┴ ┴  ┴ ┴└─┘ ┴ └─┘
# Share 1 ssh-agent across all shells via env file; add known keys if not loaded
SSH_ENV="$HOME/.ssh/agent-env"
[ -f "$SSH_ENV" ] && . "$SSH_ENV" > /dev/null
if ! ssh-add -l &>/dev/null; then
	ssh-agent -s > "$SSH_ENV"
	chmod 600 "$SSH_ENV"
	. "$SSH_ENV" > /dev/null
	for key in ~/.ssh/github ~/.ssh/id_ed25519 ~/.ssh/id_rsa; do
		[ -f "$key" ] && ssh-add "$key" 2>/dev/null
	done
fi

#  ┌┐┌┬  ┬┌┬┐
#  ││││  │││││
#  ┘└┘└─┘┴ ┴ ┴
# nvm owns node/npm/npx. Sourcing nvm.sh loads nvm and activates the `default`
if [ -s "/usr/share/nvm/nvm.sh" ]; then
	\. "/usr/share/nvm/nvm.sh"
	[ -s "/usr/share/nvm/bash_completion" ] && \. "/usr/share/nvm/bash_completion"
fi

# AWS ENV
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
