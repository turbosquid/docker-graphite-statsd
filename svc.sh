#!/bin/bash
#!/bin/bash

if [[ $1 == "help" ]] || [[ $1 == "" ]] ; then
          cat <<-EOM

Perform a command on this docker-based service..

Available commands include:
start  - start/restart the service
stop   - stop the service
logs   - tail the service logs
attach - attach to the postgres container. You may add a third, optional, command to execute. Otherwise you get a shell
pull   - pull latest docker image for this project
help   - this message

EOM
exit 1
fi


CMD=$1
cd $( dirname $0 )


COMPOSE_ARGS=""

case $CMD in
    start|run|restart|up)
        docker-compose $COMPOSE_ARGS down
        docker-compose $COMPOSE_ARGS  up -d
        ;;

    stop|down)
        docker-compose $COMPOSE_ARGS down
        ;;
    pull)
        docker-compose $COMPOSE_ARGS pull
        ;;
    log|logs)
        docker-compose $COMPOSE_ARGS logs -f --tail=20
        ;;
     "attach")
        if [[ $2 == "" ]]; then
            docker-compose $COMPOSE_ARGS exec graphite /bin/bash
        else
            docker-compose $COMPOSE_ARGS exec -T graphite /bin/bash -c "$2"
        fi
         ;;
    *)
        echo "Invalid command: $CMD"
        exit 1
        ;;
esac
