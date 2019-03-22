# terminal
PS1="\t \h:\W \u\$ "

# for bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# for rbenv
eval "$(rbenv init -)"

eval "$(plenv init -)"

# for pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
  export PATH=${PYENV_ROOT}/bin:$PATH
  eval "$(pyenv init -)"
fi

# goenv
if which goenv > /dev/null; then
  eval "$(goenv init -)";
  export GOROOT=`go env GOROOT`
  export PATH="$GOROOT/bin:$PATH"
fi

# direnv
eval "$(direnv hook bash)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# brew
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# alias
alias ls='ls -CFG'
alias ll='ls -AlFGh'
alias la='ls -CFGal'
alias mkdir='mkdir -p'
alias reload='source ~/.bash_profile'

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

# ccache
export USE_CCACHE=1
export NDK_CCACHE=ccache
export CCACHE_CPP2=yes
export CCACHE_COMPILERCHECK=content

# android
export NDK_ROOT=/usr/local/opt/android-ndk-r10e
export PATH=$NDK_ROOT:$PATH

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/22.0.1

# ccache
export USE_CCACHE=1
export NDK_CCACHE=ccache
export CCACHE_CPP2=yes
export CCACHE_COMPILERCHECK=content

export EDITOR=vim

if [ "$TERM" == "xterm" ]; then
  # No it isn't, it's gnome-terminal
  export TERM=xterm-256color
fi

alias camel_to_snake="sed -r 's/([A-Z])/_\L\1/g' | sed 's/^_//'"
alias snake_to_camel="sed -r 's/_(.)/\U\1\E/g'"

function m3u8_to_mp4() {
ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$1" -movflags faststart -c copy "$2"
}