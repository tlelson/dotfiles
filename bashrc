PS1="[\u@\h \W]# "

export CLICOLOR=1
export FIGNORE=CVS:\~:.svn
export SVN_EDITOR=vim
export HISTSIZE=10000
export HISTTIMEFORMAT="%d/%m/%y %T "

#set -o vi

# Conda build path
export CONDA_BLD_PATH=/tmp/

#alias h="head -n 5"
alias ll="ls -ltrh "
alias llt="ls -ltrh | tail"
alias lsh="ls -a | grep '^\.'"
alias llh="ls -lhta | grep ' \.'"
alias grep="grep --color=auto -E "
#alias ssh="ssh -o StrictHostKeyChecking=no "
alias pytags="ctags -R --language-force=python --python-kinds=-i"
alias speedtest="wget --report-speed=bits -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias speedtestlocal="wget --report-speed=bits -O /dev/null http://192.168.0.1/shares/Drop/test10.zip"
alias tree="tree -C "
alias activate="source activate "
alias deactivate="source deactivate "

# pip for conda (non upgrading packages installed with conda)
# pip() {
#     if [[ ${1} == "install" ]]; then
#         #echo "pip install ${@:2}"
# 	echo "Using custom 'install' function ... "
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
    else
        grep -Ir "$1" * | cut -d: -f1 | uniq | xargs -I {} sed -i 's/'"$1"'/'"$2"'/g' {}
    fi
}

source ~/.bashrc_local

## Automatically Appended Stuff below

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
