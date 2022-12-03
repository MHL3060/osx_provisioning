
START_TIME=0

VOICE_COMMAND=""
preexec() {
  VOICE_COMMAND=$1      
  START_TIME=$(date +%s)
#  echo $START_TIME
}

precmd() {
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  if [ $DURATION -gt 10 ] && [ "x${VOICE_COMMAND}" != "x" ]
  then
	  COMM=`awk '{print $1}' <<< $VOICE_COMMAND`
#	  echo "COMM=$COMM"
	  (say "command $COMM done" &)
	  unset VOICE_COMMAND
  fi
}

