grep "^export" $HOME/.bash_profile | while IFS=' =' read ignoreexport envvar ignorevalue; do
    echo "${envvar} ${!envvar}"
    if [ x$envvar != 'xPS1' ]; then
        launchctl setenv ${envvar} ${!envvar}
    fi
done
