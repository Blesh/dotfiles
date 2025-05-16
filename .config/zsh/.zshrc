# zmodload zsh/zprof

MY_ZSH_COMPLETIONS_DIR="$HOME/.zsh/completions"
if [[ -d "$MY_ZSH_COMPLETIONS_DIR" ]]; then
  fpath=("$MY_ZSH_COMPLETIONS_DIR" $fpath)
fi

autoload -Uz compinit # Enable zstyle for autocompletion http://zsh.sourceforge.net/Doc/Release/Completion-System.html
# https://gist.github.com/ctechols/ca1035271ad134841284?permalink_comment_id=3401477#gistcomment-3401477
if [[ -n ${HOME}/.zcompdump(N.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;
zmodload zsh/complist # Enable menuselect keybindings
_comp_options+=(globdots) # Tab complete includes dot files. 'setopt globdots' for everything.


##########################
### General ENV Variables
##########################

export JAVA_HOME=/usr/lib/jvm/java-1.21.0-openjdk-amd64
export BAT_THEME="ansi"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:"$HOME/.fzf/bin"
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/usr/local/texlive/2025/bin/x86_64-linux
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/dotfiles/.local/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export RIPGREP_CONFIG_PATH="$HOME/dotfiles/.config/.ripgreprc"

export KEYTIMEOUT=20 # Set to shortest possible delay is 1/100 second. Not quite sure how and why this works, but removes the delay for mode switch

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_HOME="$HOME/.config"

export LANG=en_US.UTF-8 # Get rid of locale error, not sure what those values do
export PSQL_EDITOR=/usr/local/bin/nvim

##########################
### Prompt
##########################

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats "(%b)"
zstyle ':vcs_info:git:*' actionformats " (%b|%a)"

setopt PROMPT_SUBST
#PS1='%B%F{15}%1d%f%b ${vcs_info_msg_0_}${vcs_info_msg_0_:+ }%B%F{15}|%f%b '
PS1='%B%F{15}%1d%f%b ${vcs_info_msg_0_}${vcs_info_msg_0_:+ }'

precmd() {
    vcs_info 2> /dev/null
    cd . 2>/dev/null || cd $PWD
}

##########################
### Misc
##########################

alias ll="ls --color=always -lah"
eval $(dircolors ~/.dir_colors) # http://www.linux-sxs.org/housekeeping/dircolor.html
alias lldb='/opt/llvm-19/bin/lldb'
alias ls="ls --color=auto"
alias bat="batcat --paging=never"

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Tab complete colors
zstyle ':completion:*' menu select=0 # Tab complete selection with arrows

bindkey -v # http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^w' backward-kill-word
bindkey -M viins 'jj' vi-cmd-mode
bindkey -s ^f "primux_sessionizer\n"

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Fix for terribly slow loading of nvm
# https://github.com/nvm-sh/nvm/issues/2724#issuecomment-1336497491
lazy_load_nvm() {
  unset -f node nvm
  export NVM_DIR="$HOME/.config/nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

node() {
  lazy_load_nvm
  node $@
}

nvm() {
  lazy_load_nvm
  node $@
}

##########################
### FZF Config
##########################

# TODO Add scrolling --bind 'ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-f:page-down,ctrl-b:page-up' \

source <(fzf --zsh)

# NOTE Colors with `+` refer to slected higlights
# https://vitormv.github.io/fzf-themes/
# fg := normal text color, fg+ := text color selection
# bg := normal background color, bg+ := selection background
# hl := matches, hl+ := selection match
# info := number of matches of possible files and in parenthesis current selection count
# spinner := color of icon next to `info`
# marker := color of the icon to the left of selections
# pointer := color of the icon to the left of active / current line
# prompt := color of icon before the text we search for
# header := whater text separating prompt and results
# gutter := Filler space to the left of results
# scrollbar := scrollbar to the right
# separator := Line between prompt and results
# border := border around everything
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --border=none
  --color=fg:#FFFBEF,fg+:#FFFBEF,bg:#272E33,bg+:#272E33
  --color=hl:#E67E80,hl+:#E67E80,info:#D3C6AA,marker:#D3C6AA
  --color=prompt:#D3C6AA,spinner:#D3C6AA,pointer:#D3C6AA,header:#83C092
  --color=gutter:#272E33,border:#ffffff,separator:#D3C6AA,scrollbar:#272E33
  --color=label:#aeaeae,query:#FFFBEF'


# https://github.com/junegunn/fzf/issues/1839#issuecomment-2083079532
# FZF_DEFAULT_COMMAND is just a non-essential shortcut for that-command | fzf
export FZF_COMPLETION_TRIGGER=','
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

## CTRL-R - Paste the selected command from history onto the command-line
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git .'


# TODO does not show `fzf` and the search via fuzzy searching is not that nice to find exact matches?
fman() {
    man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r -I {} zsh -c 'MANPAGER="cat" man {} | nvim -c "set ft=man" -c "nnoremap <buffer> q :q!<CR>" -'
}

# TODO not sure whether we need this vs nvim + CTRL+T
nvim() {
    # If arguments are passed to `nvim`, call the original nvim command
    if [ "$#" -gt 0 ]; then
        command nvim "$@"
        return
    fi
    # Otherwise use fzf.
    # TODO styling of tmux popup
    fzf --tmux --ansi --bind 'enter:become(command nvim {})'
}

# https://github.com/junegunn/everything.fzf/blob/main/rg.fzf
rgopen() {
    RELOAD='reload:rg --column --color=always --smart-case {q} || :'
    fzf --disabled --ansi \
        --bind "start:$RELOAD" --bind "change:$RELOAD" --bind 'enter:become:nvim {1} +{2}' --bind 'ctrl-o:execute:nvim {1} +{2}' \
        --delimiter : --preview 'batcat --style=full --color=always --highlight-line {2} {1}' \
        --preview-window '~4,+{2}+4/3,<80(up)'
}

rgfilter() {
    local filename="$1"
    RELOAD="reload:rg --color=always --smart-case {q} '$filename' || :"
    fzf --disabled --ansi --wrap --multi \
        --bind "start:$RELOAD" --bind "change:$RELOAD" \
        --bind 'ctrl-o:select-all+execute(nvim {+f})' \
        --bind 'ctrl-d:page-down' \
        --bind 'ctrl-u:page-up' \

}

ftail() {
    local filename="$1"
    if [ -z "$filename" ]; then
        echo "Usage: ftail <filename>" >&2
        return 1
    fi
    if [ ! -f "$filename" ]; then
        echo "Error: File '$filename' not found." >&2
        return 1
    fi

    local lines_to_display_in_fzf=100000
    local rg_base_cmd="rg --line-buffered --color=always --smart-case"
    RELOAD="reload:tail --follow --lines $lines_to_display_in_fzf '$filename' | $rg_base_cmd {q} || :"

    # --bind 'ctrl-o:select-all+become(nvim - < <(printf "%s\n" {+}))' \
    fzf --ansi --disabled \
        --tac --tail 11000 \
        --multi \
        --bind "start:$RELOAD" \
        --bind "change:$RELOAD" \
        --bind 'ctrl-o:select-all+become(cat {+f} | nvim -)' \
        --no-sort --exact --wrap \
        --header "Tailing '$filename' with ripgrep. Ctrl-o to open in neovim buffer. Query: rg <type-here>" \
        --prompt "rg-tail> "
}

ftask() {
  task --list | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $2 }' | sed 's/:$//' | xargs -r task
}

# Docker Completion
# https://github.com/junegunn/fzf?tab=readme-ov-file#custom-fuzzy-completion
# https://github.com/pierpo/fzf-docker/blob/master/fzf-docker.plugin.zsh
# TODO
# - cleanup the `_fzf_complete_docker` checks and formatting
# - cleanup docker exec and logs to have them be more precise
FZF_DOCKER_PS_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}"
FZF_DOCKER_PS_START_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"

_fzf_complete_docker() {
  ARGS="$@"
  if [[ $ARGS == 'docker ' ]]; then
    _fzf_complete "--reverse -n 1 --height=80%" "$@" < <(
      echo $DOCKER_COMMANDS
    )
  elif [[ $ARGS == 'docker tag'* || $ARGS == 'docker -f'* || $ARGS == 'docker run'* || $ARGS == 'docker push'* ]]; then
    _fzf_complete "--multi --header-lines=1" "$@" < <(
      docker images --format "table {{.Repository}}:{{.Tag}}\t{{.Size}}\t{{.ID}}\t{{.CreatedSince}}"
    )
  elif [[ $ARGS == 'docker rmi'* ]]; then
    _fzf_complete "--multi --header-lines=1" "$@" < <(
      docker images --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}"
    )
  elif [[ $ARGS == 'docker stop'* || $ARGS == 'docker exec'* || $ARGS == 'docker kill'* || $ARGS == 'docker restart'* ]]; then
    _fzf_complete "--multi --header-lines=1 " "$@" < <(
      docker ps --format "${FZF_DOCKER_PS_FORMAT}"
    )  
  elif [[ $ARGS == 'docker logs'* ]]; then
    _fzf_complete "--multi --header-lines=1 --header 'Enter CTRL-O to open log in editor | CTRL-/ to change height\n\n' --bind 'ctrl-/:change-preview-window(80%,border-bottom|)' --bind \"ctrl-o:execute:docker logs {1} | sed 's/\x1b\[[0-9;]*m//g' | cat | ${EDITOR:-vim} -\" --preview-window up:follow --preview 'docker logs --follow --tail=100 {1}' " "$@" < <(
      docker ps -a --format "${FZF_DOCKER_PS_FORMAT}"
    )
  elif [[ $ARGS == 'docker rm'* ]]; then
    _fzf_complete "--multi --header-lines=1 " "$@" < <(
      docker ps -a --format "${FZF_DOCKER_PS_FORMAT}"
  )
  elif [[ $ARGS == 'docker start'* ]]; then
     _fzf_complete "--multi --header-lines=1 " "$@" < <(
      docker ps -a --format "${FZF_DOCKER_PS_START_FORMAT}"
    )
  fi
}

_fzf_complete_docker_post() {
  # Post-process the fzf output to keep only the command name and not the explanation with it
  awk '{print $1}'
}

dklog() {
    local container_list
    # Get container list: ID, Names, Image, Status (using Tab as delimiter)
    container_list=$(docker ps --format "{{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}")

    if [[ -z "$container_list" ]]; then
        echo "No running Docker containers found."
        return 1
    fi

    local selected_containers_info # Can hold multiple lines now
    # Use fzf to select one or more containers (--multi).
    selected_containers_info=$(echo "$container_list" | fzf \
        --layout=reverse \
        --border \
        --header "Select Docker Container(s) (TAB/Shift-TAB to multi-select, Ctrl-R to refresh)" \
        --multi \
        --ansi \
        --bind 'ctrl-r:reload(docker ps --format "{{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}")' \
        --prompt "Container(s) > ")

    if [[ -z "$selected_containers_info" ]]; then
        echo "No container(s) selected."
        return 1
    fi

    # Array to hold background process IDs for cleanup
    local pids=()
    # Using EXIT INT TERM ensures cleanup on normal exit, Ctrl+C, or kill signals
    # trap 'command(s)' <signals_or_events> executes the given commands when the script or our function receives particular signals, i.e., we
    # are basically setting up signal / event handlers for our script
    #   - EXIT: just before the shell exits, independent of the reason for the exit
    #   - INT: SIGINT, typically due to us pressing Ctrl+C
    #   - TERM: SIGTERM, typically due to something like kill <pid>
    trap 'echo "\nCleaning up background log processes..."; kill ${pids[@]} 2>/dev/null; wait ${pids[@]} 2>/dev/null; echo "Cleanup done."' EXIT INT TERM


    echo "Fetching logs for selected container(s)..."
    echo "Press Ctrl+O to open current selection in Neovim"

    # 2. Live Log Viewing for Multiple Containers
    # We use a subshell group `{ ... }` to combine the output of multiple background processes
    # Each background process tails logs for one container and prefixes lines with its name and color
    {
        local i=0
        # Process each selected line (ID\tName\t...)
        # Use process substitution to feed selected info line by line
        # Use IFS=$'\t' to correctly parse tab-separated values
        # read -r prevents backslash interpretation
        while IFS=$'\t' read -r container_id container_name _; do
            # Skip if ID is empty (shouldn't happen with docker ps, but good practice)
            if [[ -z "$container_id" ]]; then
                continue
            fi

            # Assign a color (cycle through 31-36: Red, Green, Yellow, Blue, Magenta, Cyan)
            # Simple modulo arithmetic for cycling colors
            local color_code=$(( 31 + (i % 6) ))
            # \x1b[...m is the ANSI escape code for color. \x1b[0m resets color.
            local prefix="\x1b[${color_code}m[${container_name}]\x1b[0m" # Colored prefix

            # `sdbuf -oL` to force line buffering for `docker logs` and `sed`
            (stdbuf -oL docker logs --follow --tail 100000 --since "5m" "$container_id" 2>&1 | \
             stdbuf -oL sed -u "s/^/${prefix} /") & # '-u' for unbuffered sed might also help

            # Store the PID of the background process (docker logs | sed)
            pids+=($!)
            ((i++))
        done < <(echo "$selected_containers_info") # Feed selected lines to the while loop

        # Important: Wait for all background processes *within this group*
        # This keeps the pipe to the final fzf open. When fzf exits (e.g., user quits),
        # the SIGPIPE signal should propagate back and terminate the 'docker logs' and 'sed' processes.
        # The trap above provides additional cleanup robustness.
        wait

    } | fzf --ansi --tail 10000 --tac --no-sort --exact --wrap \
        --multi \
        --bind 'ctrl-o:select-all+become(nvim - < <(printf "%s\n" {+}))' \
        --header "Aggregated Logs | Ctrl+O to open selection in Neovim" \
        --prompt "Filter Logs > "

    # The trap's cleanup action runs automatically on EXIT otherwise
    trap - EXIT INT TERM
    return 0 # Indicate success
}

# Function to fuzzy find and exec into a running Docker container
dkex() {
  # Get container list formatted for fzf (ID, Names, Image)
  local container_list
  container_list=$(docker ps --format "{{.ID}}\t{{.Names}}\t{{.Image}}")

  # Check if docker ps returned any containers
  if [[ -z "$container_list" ]]; then
    echo "No running Docker containers found."
    return 1
  fi

  # Pipe the list to fzf for selection
  local selected_line
  selected_line=$(echo "$container_list" | fzf \
    --layout=reverse \
    --header "Select Docker Container (Ctrl-R to refresh)" \
    --ansi \
    --bind 'ctrl-r:reload(docker ps --format "{{.ID}}\t{{.Names}}\t{{.Image}}")' \
    --prompt "Container > ")

  # Exit if fzf was cancelled (e.g., user pressed Esc or Ctrl-C)
  if [[ -z "$selected_line" ]]; then
    return 1
  fi

  # Extract container ID (the first field) from the selected line
  local container_id
  container_id=$(echo "$selected_line" | awk '{print $1}')

  # Check if container ID is valid (basic check)
  if [[ -z "$container_id" ]]; then
    # echo "Failed to extract container ID."
    return 1
  fi

  container_name=$(echo "$selected_line" | awk '{print $2}')
  # Try to exec into the container with bash, fall back to sh
  echo "Connecting to container: $container_name"
  command docker exec -it "$container_id" bash || command docker exec -it "$container_id" sh

  # Check the exit status of the docker exec command
  local exit_status=$?
  if [[ $exit_status -ne 0 ]]; then
      # Both bash and sh failed. The error message from docker exec should have been printed.
      echo "Failed to connect using bash or sh. Exit status: $exit_status"
      return $exit_status
  fi

  return 0
}

##########################
### History
##########################

HISTFILE=~/.zsh_history
HISTSIZE=50000      # Lines of history to keep in memory for the current session
SAVEHIST=100000     # Lines of history to save in the history file

setopt INC_APPEND_HISTORY        # Save history entry as soon as it's executed

setopt HIST_EXPIRE_DUPS_FIRST    # When trimming, delete duplicates first
setopt HIST_IGNORE_DUPS          # Don't record an event if it's identical to the previous one
setopt HIST_FIND_NO_DUPS         # Don't show duplicates when searching history
setopt HIST_SAVE_NO_DUPS         # Don't save duplicate events in the history file (keeps file clean)

setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks


# zprof
