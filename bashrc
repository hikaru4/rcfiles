# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Fix SSH auth socket location so agent forwarding works with tmux
if test "$SSH_AUTH_SOCK" ; then
  ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi

# history {{
    # don't put duplicate lines or lines starting with space in the history.
    # See bash(1) for more options
    HISTCONTROL=ignoreboth

    # append to the history file, don't overwrite it
    shopt -s histappend

    # doing a “history -a” after each command (append command to history after each command)
    export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi; '"$PROMPT_COMMAND"
    export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
    # append to the history file, don't overwrite it 
    # (this might not necessary while we append each command)
    alias u='history -n'

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=100000000
    HISTFILESIZE=100000000
# }}}


# enhance command {{{
    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # If set, the pattern "**" used in a pathname expansion context will
    # match all files and zero or more directories and subdirectories.
    #shopt -s globstar

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
    
    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi

    # set grep ignore file/dir
    #export GREP_OPTIONS='--exclude=*.pyc --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.webassets-cache'
# }}}


# beautify {{{
    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color|*-256color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes
    
    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    	# We have color support; assume it's compliant with Ecma-48
    	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    	# a case would tend to support setf rather than setaf.)
    	color_prompt=yes
        else
    	color_prompt=
        fi
    fi

    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
    esac
# }}}


# aliases {{{
    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        # 	alias dir='dir --color=auto'
        # 	alias vdir='vdir --color=auto'

        # set grep ignore file/dir
        alias grep='grep --color=auto --exclude=*.pyc --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.webassets-cache'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi
    # colored GCC warnings and errors
    #export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    # Add an "alert" alias for long running commands.  Use like so:
    #   sleep 10; alert
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    
    # some more ls aliases
    alias ls='ls --color -h --group-directories-first'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
    alias sl='ls'
    alias tmux='tmux -2'
    alias tree_repo="tree --dirsfirst -I 'ipython|.git|node_modules' -a"
    alias treerepo="tree --dirsfirst -I 'ipython|.git|node_modules' -a"
    alias tree-repo="tree --dirsfirst -I 'ipython|.git|node_modules' -a"
    alias t='gnome-terminal --maximize'
    alias x='export DISPLAY=localhost:10.0'
    alias rdesktop='rdesktop -g 1280x752 -a 16 -D -u hikaru4 -5 -P -K -r clipboard:PRIMARYCLIPBOARD'
    # Open anythind in terminal (like in X). you can also try gnome-open or gvfs-open 
    alias o='xdg-open'
    # draw on screen app
    alias gromit-mpx='gromit-mpx --key F9'
    # git clean branch (merged branch, remote deleted branch)
    #   ref: 
    alias git-clean='git branch -d $(git branch --merged=master | grep -v master); git branch -d $(git branch --merged=develop | grep -v develop); git fetch --prune --all; git branch -a'

    # alias jenkins='java -jar ~/Downloads/jenkins-cli.jar -s http://192.168.65.138/'
    # alias jenkins-cli='java -jar /home/hikaru4/workspace/jenkins_manage/jenkins-cli.jar -s http://10.2.99.99:8080/'
    # A tool faster then `ack` which better then `grep` while doing code search
    # alias ag='ag --color --color-match=31 --color-path=35 --color-line-number=32 --ignore-dir=.webassets-cache'

    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi
# }}}


# tmux {{{
    # Open tmux at termial started, if tmux exist then open a new window.
    # for nautilus-open-terminal, remember to modify the default terminal setting.
    # if gnome-terminal is for sure that nautilus-terminal wont open tmux.
#    if [[ $COLORTERM == "gnome-terminal" ]]; then
#    if [[ $SESSIONTYPE == "gnome-session" ]]; then
    if [ $TERMINIX_ID ] || [ $VTE_VERSION ]; then
        tmux_count=`tmux ls | wc -l`
        if [[ "$tmux_count" == "0" ]]; then
            tmux -2 ; exit
#        else
#            if [[ -z "$TMUX" ]]; then
#                tmux new-window
#                tmux attach -d ; exit
#            fi
        fi
    fi
# }}}


# functions {{{
#    # rename tmux window title when ssh
#    ssh() {
#      if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
#        tmux rename-window "$*"
#        command ssh "$@"
#        tmux set-window-option automatic-rename "on" 1>/dev/null
#      else
#        command ssh "$@"
#      fi
#    }
# }}}

## develop envirment manager tools {{{
    # add user bin
    export PATH="/home/hikaru4/bin:$PATH"

    # android
    # export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
    
    # python: pyenv/virtualenv
#    export PYENV_ROOT="$HOME/.pyenv"
#    export PATH="$PYENV_ROOT/bin:$PATH"
#    eval "$(pyenv init --path)"
#    eval "$(pyenv init -)"
#    eval "$(pyenv virtualenv-init -)"

    # for python shell auto completion
#    export PYTHONSTARTUP=/home/hikaru4/rcfiles/pystartup.py

    # node: nvm
#    export NVM_DIR="$HOME/.nvm"
#    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#    # yarn bin path
#    export PATH="$PATH:$(yarn global bin)"

    # auto load nvmrc.
    #   ref: https://stackoverflow.com/questions/23556330/run-nvm-use-automatically-every-time-theres-a-nvmrc-file-on-the-directory/39519460
#    enter_directory() {
#        if [[ $PWD == $PREV_PWD ]]; then
#            return
#        fi
#        if [[ "$PWD" =~ "$PREV_PWD" && ! -f ".nvmrc" ]]; then
#            return
#        fi
#        PREV_PWD=$PWD
#        if [[ -f ".nvmrc" ]]; then
#            nvm use
#            NVM_DIRTY=true
#        elif [[ $NVM_DIRTY = true ]]; then
#            nvm use default
#            NVM_DIRTY=false
#        fi
#    }
#    export PROMPT_COMMAND=enter_directory

    # golang: gvm
    # [[ -s "/home/hikaru4/.gvm/scripts/gvm" ]] && source "/home/hikaru4/.gvm/scripts/gvm"

    # ruby: rvm
#    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#    [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
## }}}


# The next line updates PATH for the Google Cloud SDK.
#source '/home/hikaru4/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
#source '/home/hikaru4/google-cloud-sdk/completion.bash.inc'

# enables shell command completion for git flow
# source '/home/hikaru4/opensource/git-flow-completion/git-flow-completion.bash'

killall xcape 2> /dev/null ; /home/hikarus/bin/xcape

