# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#PS1="\[\e[37m\][\u@\h \w]$\[\e[m\]"

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;35m\]@\[\033[00m\]\[\033[01;33m\]\h\[\033[00m\]\[\033[34m\]:\[\033[01;34m\]\w\[\033[32m\]\$\[\033[00m\]'

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

#if [ "$color_prompt" = yes ]; then
#    PS1='\[\033[01;37m\][${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\e[31;0m\]@\[\033[01;32m\]\h\[\033[01;37m\]]\[\033[01;34m\]\w\[\033[00m\]\[\033[01,37m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -lX -lA --group-directories-first'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lA --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

alias projects='cd ~/projects/'
alias rgosm='cd ~/projects/rgosm-build/'
alias code='cd ~/code/'

alias mvnbuild='mvn clean install -DskipTests -Dcheckstyle.skip --errors'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH=$PATH:/opt/toolschain/4.4.3/bin:/usr/local/mips-linux-uclibc/bin;
export TERM=xterm-color
export GREP_OPTIONS="--exclude-dir=\.svn"

GIT_PROMPT_ONLY_IN_REPO=1
source ~/code/private_projects/my_git_prompt/git_prompt.sh

#export LANG=en_US

export JAVA_HOME=/usr/lib/jvm/java
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib:${CLASSPATH}
export M2_HOME=/usr/lib/maven/maven
#export MAVEN_OPTS="$MAVEN_OPTS -Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"
#export JVM_OPTS="-Xms256m  -XX:PermSize=256m -XX:MaxPermSize=512m"
export PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin:${M2_HOME}/bin:$PATH


#export http_proxy=http://127.0.0.1:8087/ 
#export https_proxy=$http_proxy 
#export HTTP_PROXY=$http_proxy 
#export HTTPS_PROXY=$HTTP_PROXY
