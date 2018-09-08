#PS1="[\u@\h \W]# "
LTGREEN="\[\033[40;1;32m\]"
LTBLUE="\[\033[40;1;34m\]"
CLEAR="\[\033[0m\]"
LIGHT_GRAY="\[\033[40;1;33m\]"
export PS1="$LTGREEN\u$LTBLUE@\h:$LIGHT_GRAY\W$CLEAR ❯ "

export CLICOLOR=1
export FIGNORE=CVS:\~:.svn
export SVN_EDITOR=vim
export HISTSIZE=10000
export HISTTIMEFORMAT="%d/%m/%y %T "

#set -o vi

export GOPATH=~/go                            # For installed binaries
# Can't get this shit to work
export PATH=$PATH:/usr/local/opt/go/libexec/bin:${GOPATH}/bin   # Suggestion from homebrew install delve

# Conda build path
export CONDA_BLD_PATH=/tmp/

#alias h="head -n 5"
alias ll="ls -ltrh "
alias llt="ls -ltrh | tail"
alias lsh="ls -a | grep '^\.'"
alias llh="ls -lhta | grep ' \.'"
alias grep="grep --color=auto -E "
#alias ssh="ssh -o StrictHostKeyChecking=no "
alias pytags="ctags -R --fields=+l --languages=python --python-kinds=-iv -f .tags ./"
alias speedtest="wget --report-speed=bits -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias speedtestlocal="wget --report-speed=bits -O /dev/null http://192.168.0.1/shares/Drop/test10.zip"
alias tree="tree -C -L 3 " # Limit depth to 3
alias activate="source activate "
alias deactivate="source deactivate "
alias curl="curl -sSL -D - " # Sick of not seeing any info

# pip for conda (non upgrading packages installed with conda)
# pip() {
#     if [[ ${1} == "install" ]]; then
#         #echo "pip install ${@:2}"
#       echo "Using custom 'install' function ... "
#         command pip install -U --no-deps "${@:2}"  # use all arguments from 2nd on ...
#     else
#         command pip "${@}"
#     fi
# }

# fast file filtering
lsg(){
        ls -a | grep -i "$1"
}
llg(){
        ll -ah | grep -i "$1"
}

# Progress copy
pcp(){
    if [ "$#" != 2 ]
    then
      echo "Usage:  pcp src/ target/"
    else
        rsync -avEP "${1}" "${2}"
    fi
}

# Convert from json to yaml
json_to_yaml(){
    if [ "$#" != 2 ]
    then
      echo "Usage:  json_to_yaml file.json file.yaml"
    else
        python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < "${1}" > "${2}"
    fi
}

refactor_recursive(){
    # Usage: refactor_recursive <word to replace> <new word>
    # Will recurse into any subdirectories
    # recomend doing a git commit first to allow easy reversion if it breaks
    if [ "$#" != 2 ]
    then
      echo "Usage:  refactor_recursive <old_word> <new_word>"
      echo "When matching on parenthesis '()' enclose in []"
    else
        grep -Ir "$1" * | cut -d: -f1 | uniq | xargs -I {} sed -i 's/'"$1"'/'"$2"'/g' {}
    fi
}

pyclean(){
    find . -name '*egg-info' | xargs rm -rf
    find . -name '__pycache__' | xargs rm -rf
    find . -name 'build' | xargs rm -rf
    find . -name 'dist' | xargs rm -rf
    find . -name '*.pyc' | xargs rm -f
}

# Get AWS Credentials
# Automatically load into existing session without copy/paste
gac(){ for i in "$( get-aws-creds "$@" --quiet)"; do eval "${i}"; done;}

latest-stack-events() {
    if [ "$#" != 1 ]
    then
      echo "Usage:  latest-stack-events <stack-name>"
    else
    aws cloudformation describe-stack-events --stack-name "$1" | jq -c '.StackEvents | select(.ResourceStatusReason!=null)|sort_by(.Timestamp)[] | [.Timestamp, .StackName, .LogicalResourceId, .ResourceType, .ResourceStatus, .ResourceStatusReason] ' | tail -n 10
    fi
}

if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

## Automatically Appended Stuff below

# added by travis gem
[ -f /Users/minmac/.travis/travis.sh ] && source /Users/minmac/.travis/travis.sh
