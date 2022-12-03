
START_TIME=0

VOICE_COMMAND=""
preexec() {
  VOICE_COMMAND=$1      
  START_TIME=$(date +%s)
}

precmd() {
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  if [ $DURATION -gt 10 ] && [ "x${VOICE_COMMAND}" != "x" ]
  then
          (say "command $VOICE_COMMAND done" &)
	  unset VOICE_COMMAND
  fi
}

