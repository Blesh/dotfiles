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
alias ls="\\gls --color=always -G" # BDS ls not working with LS_Colors
eval $(gdircolors ~/.dir_colors) # http://www.linux-sxs.org/housekeeping/dircolor.html

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Tab complete colors
zstyle ':completion:*' menu select=0 # Tab complete selection with arrows

bindkey -v # http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^w' backward-kill-word
bindkey -M viins 'jj' vi-cmd-mode

export KEYTIMEOUT=20 # Set to shortest possible delay is 1/100 second. Not quite sure how and why this works, but removes the delay for mode switch
#export PATH="$PATH:/Library/PostgreSQL/13/bin/"
export PATH="/usr/local/sbin:$PATH"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"

# cpp config
export CC="/usr/local/Cellar/llvm/16.0.4/bin/clang-16"
export CXX="/usr/local/Cellar/llvm/16.0.4/bin/clang-16"
export PATH=/usr/local/Cellar/llvm/16.0.4/bin:$PATH

export PATH="/Users/meinz/go/bin:$PATH"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PSQL_EDITOR=/usr/local/bin/nvim
export HOMEBREW_NO_AUTO_UPDATE=1
source /usr/local/Cellar/zsh-syntax-highlighting/0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Syntax-highlighting prompt line
# set strategy=(completion history)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
