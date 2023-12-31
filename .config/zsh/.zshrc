autoload -U compinit # Enable zstyle for autocompletion http://zsh.sourceforge.net/Doc/Release/Completion-System.html
compinit
zmodload zsh/complist # Enable menuselect keybindings
_comp_options+=(globdots) # Tab complete includes dot files. 'setopt globdots' for everything.

export LANG=en_US.UTF-8 # Get rid of locale error, not sure what those values do

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats " (%b)"
zstyle ':vcs_info:git:*' actionformats " (%b|%a)"
precmd() { vcs_info }
setopt PROMPT_SUBST
PS1='%B%F{15}%1/ %f%b%${vcs_info_msg_0_}${vcs_info_msg_0_:+ }'

alias vf='vim $(fzf)'
alias ll="ls -lah"
alias pip="pip3"
alias vim="nvim"
alias python="python3"


# vi key bindings
bindkey -v # http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^w' backward-kill-word
bindkey -M viins 'jj' vi-cmd-mode

export KEYTIMEOUT=20 # Set to shortest possible delay is 1/100 second. Not quite sure how and why this works, but removes the delay for mode switch

# xdg specification
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"


# fzf config
export FZF_DEFAULT_OPTS="--height 25% --layout=reverse --border=none --no-scrollbar --color='bg:0,gutter:0,bg+:0,info:4,spinner:4' \
                        --color='hl:10,hl+:10,fg:15,header:7,fg+:15' \
                        --color='pointer:3,marker:3,prompt:3,hl+:108'"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PATH="$HOME/go/bin:$PATH"

## TODO Determine proper way to do this on macOS
# source /usr/share/doc/fzf/examples/completion.zsh
# source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PSQL_EDITOR=/usr/bin/nvim

#### macOS specific
alias ls="\\gls --color=always -G" # BDS ls not working with LS_Colors
eval $(gdircolors ~/.dir_colors) # http://www.linux-sxs.org/housekeeping/dircolor.html
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Tab complete colors
zstyle ':completion:*' menu select=0 # Tab complete selection with arrows

export PSQL_EDITOR=/usr/local/bin/nvim
## zsh extensions
source /usr/local/Cellar/zsh-syntax-highlighting/0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Syntax-highlighting prompt line
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
## homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH="/usr/local/sbin:$PATH"
