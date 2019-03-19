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

function update_docker-compose {
    FILE=${1:-docker-compose.yml}
    yq d $FILE services.tomcat | \
    yq w - "services.activemq.ports[+]" "61616:61616" | \
    yq w - "services.activemq.ports[+]" "8161:8161" | \
    yq w - "services.activemq.ports[+]" "5672:5672" | \
    yq w - "services.activemq.ports[+]" "1883:1883" #> ~/docker_compose.yml
}

