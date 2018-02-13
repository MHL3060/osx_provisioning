# vim: set ft=sh:
export PROJECT_ROOT=~/Documents/projects
export PATH=$PATH:/usr/libexec
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi
export MAVEN_OPTS="-Xms256M -Xmx2048M -noverify"
export EDITOR=nvim
function p {
    if [ $# == 0 ] || [ "x$1" == "xls" ]; then
        ls -l $PROJECT_ROOT
    else
        cd $PROJECT_ROOT/$1
    fi
}
source $(brew --prefix)/etc/bash_completion
alias alert='terminal-notifier -message '
alias git_stash="git diff stash@{0}^1 stash@{0} "
alias docker_rmi="docker rmi -f \$(docker images -a -q)"
alias ls="exa"
alias vim="nvim"
alias vi="vim"
alias sl="ls"
alias ll="ls -l --git -h"
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
echo "---------------   ----------------"
alias
echo "---------------   ----------------"
