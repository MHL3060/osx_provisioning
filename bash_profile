export PROJECT_ROOT=~/Documents/projects
export PATH=$PATH:/opt/apache-maven/bin:/Library/Frameworks/Mono.framework/Versions/Current/bin
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="[\T|\u@l \W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]]\$ "
export MAVEN_OPTS="-Xms256M -Xmx2048M -noverify"

function liquibase {
	java -jar /Users/lijzu01/.m2/repository/org/liquibase/liquibase-core/3.5.1/liquibase-core-3.5.1.jar \
		--driver=org.mariadb.jdbc.Driver \
		--classpath=/Users/lijzu01/.m2/repository/org/mariadb/jdbc/mariadb-java-client/2.0.2/mariadb-java-client-2.0.2.jar \
		--url="jdbc:mariadb://127.0.0.1/portal" \
		--username=admin \
		--password=7layer \
		--changeLogFile=$1  migrate
}
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
echo "---------------   ----------------"
alias
echo "---------------   ----------------"
