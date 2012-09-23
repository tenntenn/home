#######################################
#一般的な設定
########################################

#補完
autoload -Uz compinit
compinit
. ~/.zsh/cdd/cdd
#最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
#cdを付けなくてもディレクトリ名で移動
setopt auto_cd
#移動したディレクトリを記録
setopt auto_pushd
#タブキーで補完候補を順に表示
setopt auto_menu
#補完候補一覧でファイルの種別を識別マーク表示
setopt list_types
#補完候補リストの日本語を正しく表示
#setopt print_eight_bit
#コマンド訂正
setopt correct
#補完候補を詰めて表示
setopt list_packed
#コマンド予測機能
#autoload predict-on
#predict-on
#ビープ音をならないように
setopt nolistbeep
#言語と文字コード
export LANG=ja_JP.UTF-8
# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst
# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 
# グロブ機能を拡張する
setopt extended_glob
# ファイルグロブで大文字小文字を区別しない
unsetopt caseglob
#エディタはvimだがさすがにターミナルでvimバインドはうざいのでemacsバインド
bindkey -e
########################################
#エイリアスの設定
########################################

#lsを色付き表示
alias ls='ls -G'
#詳細表示
alias ll='ls -alh'

alias pd='popd'

#cdした後に自動的にls
#cdd 記録
function chpwd() {
    ls
    _cdd_chpwd
}

alias -g L="| lv"
alias -g NL=">/dev/null"
alias -g NLL=">/dev/null 2>&1"

########################################
#文字コード変換
########################################

function utf8(){
    nkf -w --overwrite $1
}
function sjis(){
    nkf -s --overwrite $1
}
########################################
#gitの設定
########################################

#git completion
source ~/.zsh/git-completion.bash

#git ルートディレクトリのパスを表示
alias git-root="git rev-parse --show-toplevel"

#git ルートディレクトリに移動
function cd-git-root() {
    cd `git rev-parse --show-toplevel`
} 

########################################
#プロンプトの設定
########################################

#branch名を表示する
autoload -Uz add-zsh-hook
autoload -Uz colors
colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
zstyle ':vcs_info:git:*' formats '[%b] %c%u'
zstyle ':vcs_info:git:*' actionformats '[%b|%a] %c%u'

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"

case ${UID} in
0)
    PROMPT="%{[31m%}%n%%%{[m%} "
    RPROMPT="%1(v|%F{green}%1v%f|) [%~]"
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%n%%%{[m%} "
    RPROMPT="%1(v|%F{green}%1v%f|) [%~]"
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

#ターミナルのタイトルの設定
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

########################################
#履歴の設定
########################################
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
#履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

########################################
#tmuxの設定
########################################

#tmuxの自動起動
if [ -z "$PS1" ] ; then return ; fi

if [ -z $TMUX ] ; then
        if [ -z `tmux ls` ] ; then
                tmux
        else
                tmux attach
        fi
fi

#tmuxのプレフィックスを任意のキーに変更
function tmux-set-prefix(){
    tmux set-option -g prefix $1
}

#tmuxのプレフィックスをC-bに変更
function tmux-change-prefix(){
    tmux-set-prefix C-b
}

#tmuxのプレフィックスをC-tに戻す
function tmux-reset-prefix(){
    tmux-set-prefix C-t
}


########################################
# airportの設定
########################################
SSID=`airport -I | grep \ SSID| sed 's/ //g' | sed 's/SSID://'`
if [ $SSID = "Sys-wireless" ]; then
    export PROXY="http://proxy.sys.cs.tut.ac.jp:3128"
    export https_proxy=$PROXY
    export http_proxy=$PROXY
fi
