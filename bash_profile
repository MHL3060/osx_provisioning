# vim: set ft=sh:
platform=`uname`
PS1=
export PATH=$PATH:/usr/libexec
GIT_PROMPT_END="\n[\u@\h] \A \$ "
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi
if [ -f /usr/local/Cellar/git/2.17.0/etc/bash_completion.d/git-completion.bash ]; then
  . /usr/local/./Cellar/git/2.17.0/etc/bash_completion.d/git-completion.bash
fi
export MAVEN_OPTS="-Xms256M -Xmx2048M -noverify"
export EDITOR=nvim
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2049M"
export PROMPT_DIRTRIM=3
export PS1='\t[\u@l \w]$ '
function p {
    if [ $# == 0 ] || [ "x$1" == "xls" ]; then
        ls -l $PROJECT_ROOT
    else
        cd $PROJECT_ROOT/$1
    fi
}
function p_list {
    COMPREPLY=($(compgen -W "$(\ls $PROJECT_ROOT)" -- "${COMP_WORDS[1]}"))
}
function debugJs {
    echo "./node_modules/.bin/karma start karma.config.js --debug --no-single-run -- --grep $1"
   node --max-old-space-size=8000 ./node_modules/.bin/karma start karma.config.js --debug --no-single-run -- --grep $1
}
function watchJs {
    p web
    npm run build.dev.watch:jit -- --nl
}
LS_OPTS=""
complete -F p_list p
alias git_web="git instaweb --httpd=webrick"
alias bash_profile="vim ~/.bash/osx_provisioning/bash_profile"
alias watchJs="npm run build.dev.watch:jit -- --nl"
alias buildClient="npm run test && npm run build.dev:aot-check"
alias alert='terminal-notifier -message '
alias git_stash="git diff stash@{0}^1 stash@{0} "
alias docker_rmi="docker rmi -f \$(docker images -a -q)"
if [ `which exa` ]; then
	alias ls="exa"
    LS_OPTS="--git -h"
fi
alias vim="nvim"
alias vi="vim"
alias sl="ls"
alias ll="ls -l $LS_OPTS"
alias ag="ag --ignore '*.js' --ignore '*.css'"
alias grep="ag"
alias project_root="cd $PROJECT_ROOT"
alias la="ls -a"
alias json_pretty="python -m json.tool $1"
alias docker_log="docker logs -f "
alias docker_exec="docker exec -it "
alias remove_download_warning="sudo xattr -d com.apple.quarantine "
alias search="csearch -n "
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
alias cs="search"
alias git_undo_delete="git checkout HEAD -- "
alias b="brew"
alias brewup="brew update; brew upgrade; brew prune; brew cleanup; brew doctor"
alias d="docker"
alias mdfind="mdfind -onlyin ."
alias csearch="mdfind"
alias build_aot="npm run build.dev:aot-check"
echo "---------------   ----------------"
alias
echo "Ctrl + y to paste"
echo "Ctrl + u to copy until cursor"
echo "Ctrl + k to copy after cursor"
echo "Ctrl + w to copy word before cursor"
echo "Ctrl + d delete char under cursor"
echo "Ctrl + h delete char before cursor" 
echo "---------------   ----------------"
export PATH="/usr/local/opt/node@8/bin:$PATH"
export NVM_DIR=$HOME/.nvm
GIT_PROMPT_END="\n\e[0;31m[\u@\h]\e[m \A \$ "
if [ "$platform" == "Darwin" ]; then
	sh ~/.bash/osx_provisioning/osx_env_sync.sh
	source $(brew --prefix)/etc/bash_completion
fi
if [ -e /usr/share/bash-completion/completions/git ]; then
	source /usr/share/bash-completion/completions/git
fi
if [ -e /usr/local/opt/nvm/nvm.sh ]; then
	. /usr/local/opt/nvm/nvm.sh
fi
. ~/.bash/.bash-git-prompt/gitprompt.sh
