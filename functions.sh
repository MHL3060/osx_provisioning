function p {
	echo "$PROJECT_ROOT/$1"
    if [[ "$#" == "0" ]] || [[ "x$1" == "xls" ]]; then
        echo "no"
	    ls -l $PROJECT_ROOT
    elif [[ "x$1" == "x-" ]]; then
	echo "popd"
	    popd
    else
	    echo "pushed"
        pushd "$PROJECT_ROOT/$1"
    fi
}
function klog {
	echo "this method filters feature and datadog log"
	kubectl logs $* |grep -v 'datadog' |grep -v heartbeat |grep -v jvm |grep -v jmx |grep -v feature
}
function f_vim {
	vim $(find . -name $1)
}
function pk {
	if [[ "$1x" =~ ^- ]]; then
			if [ "$1x" == "-px" ]; then
					K8_CONTEXT="$PROD_K8_CONTEXT"
					echo "pods from prod environment"
			elif [ "$1x" == "-ox" ]; then
					K8_CONTEXT="$ORT_K8_CONTEXT"
					echo "list prods from ORT environment"
			else
					K8_CONTEXT="$TEST_K8_CONTEXT"
					echo "pods from test environment"
			fi
			
			shift
	else

			K8_CONTEXT="$TEST_K8_CONTEXT"
			echo "pods from test environment"

	fi
	pod=$1

	kubectl $* --context=$K8_CONTEXT -n $K8_NAME
}

function pk_details {
	if [[ "$1x" =~ ^- ]]; then
                        if [ "$1x" == "-px" ]; then
                                        K8_CONTEXT="$PROD_K8_CONTEXT"
                                        echo "pods from prod environment"
                        elif [ "$1x" == "-ox" ]; then
                                        K8_CONTEXT="$ORT_K8_CONTEXT"
                                        echo "list prods from ORT environment"
                        else
                                        K8_CONTEXT="$TEST_K8_CONTEXT"
                                        echo "pods from test environment"
                        fi

                        shift
        else

                        K8_CONTEXT="$TEST_K8_CONTEXT"
                        echo "pods from test environment"

        fi
	kubectl get -o json pod/$1  --context=$ORT_K8_CONTEXT -n $K8_NAME
}
function pk_exec {
	if [[ "$1x" =~ ^- ]]; then
                if [ "$1x" == "-px" ]; then
                        K8_CONTEXT="$PROD_K8_CONTEXT"
                        echo "pods from prod environment"
                elif [ "$1x" == "-ox" ]; then
                        K8_CONTEXT="$ORT_K8_CONTEXT"
                        echo "list prods from ORT environment"
                else
                        K8_CONTEXT="$TEST_K8_CONTEXT"
                        echo "pods from test environment"
                fi
		
                shift
        else

                K8_CONTEXT="$TEST_K8_CONTEXT"
                echo "pods from test environment"

        fi
	pod=$1
	executable=${2:-/bin/bash}
	kubectl exec -it $pod --context=$K8_CONTEXT -n $K8_NAME $executable
}


function pk_ls_pod {
	if [ "$1x" == "-px" ]; then
		K8_CONTEXT="$PROD_K8_CONTEXT"
		echo "pods from prod environment"
	elif [ "$1x" == "-ox" ]; then 
		K8_CONTEXT="$ORT_K8_CONTEXT"
		echo "list prods from ORT environment"
	else 
		K8_CONTEXT="$TEST_K8_CONTEXT"
		echo "pods from test environment"
	fi
	echo "kubectl get pods --context=$K8_CONTEXT -n $K8_NAME";
	kubectl get pods --context=$K8_CONTEXT -n $K8_NAME
}

function pk_log {
	if [[ "$1x" =~ ^- ]]; then 
		if [ "$1x" == "-px" ]; then
			K8_CONTEXT="$PROD_K8_CONTEXT"
			echo "pods from prod environment"
			shift
		elif [ "$1x" == "-ox" ]; then 
			K8_CONTEXT="$ORT_K8_CONTEXT"
			echo "list prods from ORT environment"
			shift
		elif [ "$1x" != "-fx" ]; then 
			K8_CONTEXT="$TEST_K8_CONTEXT"
			echo "pods from test environment"
		else 
			K8_CONTEXT="$TEST_K8_CONTEXT"
                        echo "pods from test environment"
		fi

	else

		K8_CONTEXT="$TEST_K8_CONTEXT"
		echo "pods from test environment"

	fi
	echo "kubectl logs $* --context=$K8_CONTEXT -n $K8_NAME --all-containers"
	kubectl logs $* --context=$K8_CONTEXT -n $K8_NAME --all-containers
}

function mvn_switch_profile {
	if [ -f ~/.m2/settings.xml ]; then
		mv ~/.m2/settings.xml ~/.m2/settings-$current_active_profile.xml
	fi
	if [ -f ~/.m2/settings-$1.xml ]; then
		cp ~/.m2/settings-$1.xml ~/.m2/settings.xml
	fi 
		
	export current_active_profile=$1
}

function branch {
	git co master
	git pull
	git co -b $1
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

function k8sh {
	kubectl exec -it $1 /bin/sh
}
function cd {
    builtin cd "$@" && ls -G;
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

function update_docker_compose {
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
	echo "Ctrl + - undo deletion"
	echo "Alt + f forward one word"
	echo "Alt + b backward one word"
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

function pk_log_parsed {
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	echo "D=$DIR"
	pk_log $* -f --tail=1 | ~/.bash/osx_provisioning/parse_log.py
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
