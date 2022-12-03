
START_TIME=0

VOICE_COMMAND=""
preexec() {
  VOICE_COMMAND=$1      
  START_TIME=$(date +%s)
  echo "$START_TIME"
}

precmd() {
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  if [ $DURATION -gt 3 ] && [ "x${VOICE_COMMAND}" != "x" ]
  then
          (say "command $VOICE_COMMAND done" &)
	  unset VOICE_COMMAND
  fi
}

