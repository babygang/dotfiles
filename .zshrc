# see doc
# http://www.strcat.de/zsh/

# for ignore in bashrc
alias __git_complete=':'

# use .bash_profile
source ~/.bashrc

# for ignore in bashrc
unalias __git_complete

# terminal
PS1="%* %n@%m: %1~ $ "

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

# $PATH の重複排除
typeset -U path cdpath fpath manpath

# 補完設定
autoload -U compinit
compinit
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1

# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完でカラーを使用する
autoload colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# 何も入力されていないときのTABでTABが挿入されるのを抑制
zstyle ':completion:*' insert-tab false

# 履歴のインクリメンタル検索でワイルドカード利用可能
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# history conf
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HISTTIMEFORMAT="[%Y/%M/%D %H:%M:%S] "

# 補完リストが多いときに尋ねない
LISTMAX=1000

# "|,:"を単語の一部とみなさない
WORDCHARS="$WORDCHARS|:"

# 入力途中の履歴補完を有効化する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#character-searchをbashと同じ挙動にする
bindkey '^]'   vi-find-next-char
bindkey '^[^]' vi-find-prev-char

#zsh Git
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:*' formats '[%b] %m'  # hook_com[misc]を出力するため%mを追加
zstyle ':vcs_info:*' actionformats '[%b|%a] %m'
_vcs_precmd () { vcs_info }
add-zsh-hook precmd _vcs_precmd
RPROMPT='%F{green}${vcs_info_msg_0_}%f'

zstyle ':completion:*:*:git*:*' ignored-patterns '*ORIG_HEAD'

# gitリポジトリにいる場合、set-messageフックでgit-config-user関数が呼び出されるように登録
zstyle ':vcs_info:git+set-message:*' hooks git-config-user
function +vi-git-config-user(){
  hook_com[misc]+=%f%F{red}@`git config user.name`
}
