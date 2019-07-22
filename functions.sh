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
    echo "./node_modules/.bin/karma start karma.config.js --debug --no-single-run --testOnly *$1*"
    node --max-old-space-size=4000 ./node_modules/.bin/karma start karma.config.js --debug --no-single-run --testOnly *$1*
}
function watchJs {
    p web
    npm run build.dev.watch:jit -- --nl
}

function cd {
    builtin cd "$@" && ls;
}
function docker_compose_to_host {

    #
    # Extracts /etc/hosts file entries from a docker-compose.yml file.
    #
    # usage:
    # $0 [file] [indent]
    #   where file defailts to docker-compose.yml and indent defaults to 2 spaces

    FILE=${1:-docker-compose.yml}
    INDENT=${2:-'  '}
    cat $FILE | grep "^${INDENT}[A-za-z\-]\+\:$" | cut -d':' -f1 | sed "s/${INDENT}/127.0.0.1 /"
}

function delete_all_volume {
        volumes=$(docker volume ls |awk '{print $2}' |grep -v 'V')
        docker volume rm $volumes
}

function delete_all_container {
        containers=$(docker container ls --all |grep -v 'CONTAINER' |awk '{print $1}')
        docker container rm $containers
}

function config_git {
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.ci commit
	git config --global alias.st status
}

function update_docker-compose {
    FILE=${1:-docker-compose.yml}
    yq d $FILE services.tomcat | \
    yq w - "services.activemq.ports[+]" "61616:61616" | \
    yq w - "services.activemq.ports[+]" "8161:8161" | \
    yq w - "services.activemq.ports[+]" "5672:5672" | \
    yq w - "services.activemq.ports[+]" "1883:1883" #> ~/docker_compose.yml
}

function show_hints {
	echo ""
	echo "+++++++++++++++++++++++++++++++++++++++++++++++"
	echo "+++++++++++++++++++++++++++++++++++++++++++++++"
	alias
	echo "Ctrl + y to paste"
	echo "Ctrl + u to copy until cursor"
	echo "Ctrl + k to copy after cursor"
	echo "Ctrl + w to copy word before cursor"
	echo "Ctrl + d delete char under cursor"
	echo "Ctrl + h delete char before cursor" 
	echo "DCEVM -XXaltjvm=dcevm -javaagent:$HOME/hotswap-agent.jar"
	echo "pbcopy and pbpaste for copy and paste"
	export PATH="/usr/local/bin:$PATH"
	export NVM_DIR=$HOME/.nvm
	echo "+++++++++++++++++++++++++++++++++++++++++++++++"
}

function set_java_home {
	sdk d java $1
	if [ $? == 1 ]; then 
		sdk ls java
	fi
}

function extract_docker_compose_enviroment {
	path=$1
	yq r docker-compose.yml $path |sed -e 's/:\ /=/'
}

function retry {
  local retries=$1
  shift

  local count=0
  until "$@"; do
    exit=$?
    wait=$((2 ** $count))
    count=$(($count + 1))
    if [ $count -lt $retries ]; then
      echo "Retry $count/$retries exited $exit, retrying in $wait seconds..."
      sleep $wait
    else
      echo "Retry $count/$retries exited $exit, no more retries left."
      return $exit
    fi
  done
  return 0
}
