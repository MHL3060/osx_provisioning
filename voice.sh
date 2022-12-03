START_TIME=0
function PreCommand() {
  if [ -z "$AT_PROMPT" ]; then
	  return
  fi
  unset AT_PROMPT
  START_TIME=$(date +%s)
  # Do stuff.
  #  echo "Running PreCommand"
}
trap "PreCommand" DEBUG

# This will run after the execution of the previous full command line.  We don't
# want it PostCommand to execute when first starting a bash session (i.e., at
# the first prompt).
FIRST_PROMPT=1
function PostCommand() {
  AT_PROMPT=1
  if [ -n "$FIRST_PROMPT" ]; then
    unset FIRST_PROMPT
    return
  fi

  # Do stuff.
  END_TIME=$(date +%s)
  DURATION=$(($END_TIME - $START_TIME))
  if [ $DURATION -gt 3 ]
  then
    bgTask;
  fi
}

function bgTask() {
  (say "command done bro" &)
}
PROMPT_COMMAND="PostCommand"

