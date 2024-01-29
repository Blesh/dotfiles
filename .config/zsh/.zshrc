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
alias ll="ls --color=always -lah"
alias pip="pip3"
alias vim="nvim"
alias python="python3"
eval $(dircolors ~/.dir_colors) # http://www.linux-sxs.org/housekeeping/dircolor.html
alias ls="ls --color=auto"
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
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"
export PSQL_EDITOR=/usr/local/bin/nvim

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=$HOME/.local/bin:$PATH

export PATH=/usr/lib/llvm-13/bin/:$PATH
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf config

export FZF_DEFAULT_OPTS="--height 25% --layout=reverse --border=none --color='bg:0,gutter:0,bg+:0,info:4,spinner:4' \
                        --color='hl:10,hl+:10,fg:15,header:7,fg+:15' \
                        --color='pointer:3,marker:3,prompt:3,hl+:108'"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PATH=$PATH:/usr/local/go/bin

source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

export LD_LIBRARY_PATH=/usr/local/icu/73.2/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/icu/73.2/lib/pkgconfig:$PKG_CONFIG_PATH

export CXX=/usr/lib/llvm-13/bin/clang++
export CC=/usr/lib/llvm-13/bin/clang

ulimit -n 4096

export JAVA_HOME="$HOME/jre1.8.0_391"
export PATH=$JAVA_HOME/bin:$PATH

alias hwsim=$HOME/nand2tetris/tools/HardwareSimulator.sh
