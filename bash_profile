# vim: set ft=sh:

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "D=$DIR"
platform=`uname`
PS1=
export PATH=$PATH:/usr/libexec
# GIT_PROMPT_END="\n[\u@\h] \A \$ "
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi
if [ -f /usr/local/Cellar/git/2.17.0/etc/bash_completion.d/git-completion.bash ]; then
  . /usr/local/./Cellar/git/2.17.0/etc/bash_completion.d/git-completion.bash
fi
export MAVEN_OPTS="-Xms256M -Xmx2048M -noverify"
export EDITOR=nvim
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2049M"
export PROMPT_DIRTRIM=1
export PS1='\t[\u@l \w]$ '
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $DIR/functions.sh
. $DIR/alias.sh
LS_OPTS=""
complete -F p_list p

if [ "$platform" == "Darwin" ]; then
	# sh ~/.bash/osx_provisioning/osx_env_sync.sh
	source $(brew --prefix)/etc/bash_completion
fi
if [ -e /usr/share/bash-completion/completions/git ]; then
	source /usr/share/bash-completion/completions/git
fi
if [ -e /usr/local/opt/nvm/nvm.sh ]; then
	. /usr/local/opt/nvm/nvm.sh
fi
