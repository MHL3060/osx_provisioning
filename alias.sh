alias git_web="git instaweb --httpd=webrick"
alias bash_profile="vim ~/.bash/osx_provisioning/bash_profile"
alias watchJs="p web &&npm run build.dev.watch:jit -- --nl"
alias buildClient="npm run test && npm run build.dev:aot-check"
alias alert='terminal-notifier -message '
alias git_stash="git diff stash@{0}^1 stash@{0} "
alias docker_rmi="docker rmi -f \$(docker images -a -q)"
if [ `which exa` ]; then
        alias ls="exa"
    LS_OPTS="--git -h"
fi
alias vim="nvim"
alias vi="vim"
alias sl="ls"
alias ll="ls -l $LS_OPTS"
alias ag="ag --ignore '*.js' --ignore '*.css'"
alias agg="ag"
alias project_root="cd $PROJECT_ROOT"
alias la="ls -a"
alias json_pretty="python -m json.tool $1"
alias docker_log="docker logs -f "
alias docker_exec="docker exec -it "
alias remove_download_warning="sudo xattr -d com.apple.quarantine "
alias search="csearch -n "
alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
alias cs="search"
alias git_undo_delete="git checkout HEAD -- "
alias b="brew"
alias brewup="brew update; brew upgrade; brew prune; brew cleanup; brew doctor"
alias d="docker"
alias mdfind="mdfind -onlyin ."
alias csearch="mdfind"
alias build_aot="npm run build.dev:aot-check"
alias cat="bat"
alias k8s_ls_pod="kubectl get pod"
alias k8s_rm_pod=" kubectl delete pod"
alias k8s_log="kubectl logs"
