[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# MacPorts Installer addition on 2010-07-07_at_13:58:18: adding an appropriate PATH variable for use with MacPorts.
# Finished adapting your PATH environment variable for use with MacPorts.

# little tool to fix recursively the permissions in the directory specified
# sets all files to 664 and directories to 2775
optisol_fix_permissions () {
    if [ -z "$1" ]; then
        echo "Usage: optisol_fix_permissions  DIRECTORY"
        return 1
    elif [ ! -d "$1" ]; then
        echo "${1} does not really seem to be a valid directoy ..."
        return 1
    else
        echo "fixing directory permissions ... "
        find "$1" -type d | xargs chmod 2775
        echo "fixing file permissions ... "
        find "$1" -type f | xargs chmod 664
        echo " done"
    fi
    return 0
}

shopt -s checkwinsize
TERMINAL_TITLE=''
HOSTNAME_FIRSTPART=${HOSTNAME%%\.*}
PROMPT_COMMAND='echo -ne "\033]0;$TERMINAL_TITLE${USER}@${HOSTNAME_FIRSTPART}{PWD}\007"'
title () {
   if [ "x$1" != "x" ]; then
      TERMINAL_TITLE="$1 --- "
   fi
   echo ${TERMINAL_TITLE:0{#TERMINAL_TITLE}-5}
}

if [ "x$YROOT_NAME" != "x" ]; then
   PS1="\n[\t \u@\h $YROOT_NAME \w] \\$ "
   title "${HOSTNAME_FIRSTPART} - $YROOT_NAME"
else
   PS1="\n[\t \u@\h \w] \\$ "
fi

export EDITOR=vi
export PATH=/usr/local/mongodb/bin:/opt/local/bin:$PATH:/Users/miker/optisol/utils/:/usr/local/PEAR/
export JAVA_HOME=/Library/Java/Home
alias osd_staus='ruby optisol_deploy.rb $PWD'
export PATH=/opt/subversion/bin:$PATH
alias svndiff="svn diff --diff-cmd kdiff3 -x ' -qall ' &> /dev/null"
alias brake='bundle exec rake'
alias brail='bundle exec rails'
alias br='bundle exec ruby'
alias resq='bundle exec rake resque:workers'
alias ec2='~/.rightscale/RightScale_SSH_Wrapper -o UserKnownHostsFile="/Users/miker/.rightscale/known_hosts" -i "/Users/miker/.rightscale/00-0DREKFI" -o HostKeyAlias="00-0DREKFI" root@50.16.224.106 ; logout'


alias hh='! history'
