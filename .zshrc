
### oh-my-zsh の設定 #####
 
export ZSH=$HOME/.oh-my-zsh
 
# oh-my-zsh themes
ZSH_THEME="candy"
 
# oh my zsh で利用するプラグインを指定
plugins=(git zsh-syntax-highlighting zsh-completions fzf )

# oh-my-zsh に変更を適用
source $ZSH/oh-my-zsh.sh

##### zsh の設定 #####
 
# My prompt
PROMPT='
[%F{magenta}%B%n%b%f@%F{blue}%B%d%b%f] %{$fg_bold[cyan]%}$(git_prompt_info)  
(｀・ω・´)/ # '

# zsh-completions の設定。コマンド補完機能
autoload -U compinit && compinit -u

# cd - after cd command, auto ls command 
function cd(){
      builtin cd $@ && ls;
}
# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
# fbr - checkout git branch (including remote branches)
fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
fadd() {
  local out q n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf-tmux --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}

 
# エイリアス
alias his='history'
alias ..= 'cd ../'
alias ...='cd ../..'
alias ....='cd ../../..'
alias v='vim'
alias vi='vim'
alias vimrc='vim ~/.vimrc'
alias dein='vi ~/.vim/dein.toml'
alias zshrc='vim ~/.zshrc'
alias update='source ~/.zshrc'
alias p3='python3'
alias mss='mysql.server start'
alias be='bundle exec'
alias ber='bundle exec ruby'
alias pip='pip3'
alias ssudo='sudo apt update && sudo apt upgrade'
alias c='clear'

# 色を使用出来るようにする
autoload -Uz colors
colors
 
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
 
# cd なしでもディレクトリ移動
setopt auto_cd
 
# ビープ音の停止
setopt no_beep
setopt nolistbeep
 
# cd [TAB] で以前移動したディレクトリを表示
setopt auto_pushd
 
# ヒストリ (履歴) を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
 
# 同時に起動した zsh の間でヒストリを共有する
setopt share_history
 
# 直前と同じコマンドの場合はヒストリに追加しない
setopt hist_ignore_dups
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
 
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
 
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# [TAB] でパス名の補完候補を表示したあと、
# 続けて [TAB] を押すと候補からパス名を選択できるようになる
# 候補を選ぶには [TAB] か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1
 
# cd した先のディレクトリをディレクトリスタックに追加する
# cd [TAB] でディレクトリのヒストリが表示されるので、選択して移動できる
# ※ ディレクトリスタック: 今までに行ったディレクトリのヒストリのこと
setopt auto_pushd
 
# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups
 
# 拡張 glob を有効にする
# 拡張 glob を有効にすると # ~ ^ もパターンとして扱われる
# glob: パス名にマッチするワイルドカードパターンのこと
# ※ たとえば mv hoge.* ~/dir というコマンドにおける * のこと
setopt extended_glob
 
# 単語の一部として扱われる文字のセットを指定する
# ここではデフォルトのセットから / を抜いたものにしている
# ※ たとえば Ctrl-W でカーソル前の1単語を削除したとき / までで削除が止まる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
