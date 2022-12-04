
START_TIME=0

VOICE_COMMAND=""
preexec() {
  VOICE_COMMAND=$1      
  START_TIME=$(date +%s)
#  echo $START_TIME
}

precmd() {
  statusCode=$?
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  if [ $DURATION -gt 10 ] || [ $statusCode -eq 1 ]
  then
	  if [ "x${VOICE_COMMAND}" != "x" ]
	  then
	  	result="completed"
	  	if [ $statusCode -eq 1 ]
		  then
			result="failed"
	  	fi

	  	COMM=`awk '{print $1}' <<< $VOICE_COMMAND`
#	  	echo "COMM=$COMM statusCode=$statusCode"
	  	(say "command $COMM $result" &)
	  	unset VOICE_COMMAND
	  fi
  fi
}

