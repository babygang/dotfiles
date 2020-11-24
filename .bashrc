# terminal
PS1="\t \h:\W \u\$ "

# for bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# for anyenv
eval "$(anyenv init -)"

# brew
PATH="/usr/local/sbin:/usr/local/bin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# alias
alias ls='ls -CFG'
alias ll='ls -AlFGh'
alias la='ls -CFGal'
alias mkdir='mkdir -p'
alias reload='exec $SHELL -l'

# git
alias gco="git checkout"
__git_complete gco _git_checkout
alias gcob="git checkout -b"
__git_complete gcob _git_checkout -b
alias gst="git status"
alias gad="git add"
__git_complete gad _git_add
alias gci="git commit"
alias gdi="git diff"
__git_complete gdi _git_diff
alias gdic="git diff --cached"
__git_complete gdic _git_diff --cached
alias gbr="git branch"
__git_complete gbr _git_branch
alias glog="git log --oneline --graph --decorate --all"
__git_complete glog _git_log --oneline --graph --decorate --all

alias diff="git diff --no-index --ignore-blank-lines -w"

# bundler
alias be="bundle exec"
alias bin="bundle install"

alias gip="curl https://ifconfig.io"
alias lip="ifconfig | grep 'inet ' | grep -v 127.0.0.1"

alias dsstore_remove="find . -name '.DS_Store' -type f -ls -delete"

# docker-compose
alias dcbuild="docker-compose build"
alias dcu="docker-compose up"
alias dcexec="docker-compose exec"
alias dcstop="docker-compose stop"

# ccache
export USE_CCACHE=1
export NDK_CCACHE=ccache
export CCACHE_CPP2=yes
export CCACHE_COMPILERCHECK=content

# android
export NDK_ROOT=/usr/local/opt/android-ndk-r10e
PATH=$NDK_ROOT:$PATH

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
PATH=$PATH:$ANDROID_SDK_ROOT/tools
PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/22.0.1

# ccache
export USE_CCACHE=1
export NDK_CCACHE=ccache
export CCACHE_CPP2=yes
export CCACHE_COMPILERCHECK=content

export EDITOR=vim

if [ "$TERM" = "xterm" ]; then
  # No it isn't, it's gnome-terminal
  export TERM=xterm-256color
fi

alias camel_to_snake="sed -r 's/([A-Z])/_\L\1/g' | sed 's/^_//'"
alias snake_to_camel="sed -r 's/_(.)/\U\1\E/g'"

function m3u8_to_mp4() {
  ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$1" -movflags faststart -c copy "$2"
}

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
# export COCOS_ROOT=/Applications/Cocos/Cocos2d-x/cocos2d-x-3.10
COCOS_ROOT=~/work/cocos/cocos2d-x-3.13.1
COCOS_CONSOLE_ROOT=$COCOS_ROOT/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
COCOS_X_ROOT=/Applications/Cocos/Cocos2d-x
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
COCOS_TEMPLATES_ROOT=$COCOS_ROOT/templates
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# uniq path
export PATH=`ruby -e "puts %x{ echo $PATH }.strip.split(':').uniq.join(':')"`

# PIPENV_VENV_IN_PROJECT
export PIPENV_VENV_IN_PROJECT=true

