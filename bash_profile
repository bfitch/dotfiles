############ Aliases ##############
alias ls="ls -FGh"
alias be='bundle exec'
alias rspec='be rspec'
alias cucumber='be cucumber'
alias guard="be guard"
alias cuc="be cucumber"
alias spec="be rspec"
alias bake="be rake"
alias staff="cd /Users/brian/src/icisstaff"
alias pat="cd /Users/brian/src/icispatients"
alias snow="cd /Users/brian/src/snowflake"
alias plog="cd /Users/brian/src/patient_log_service"
alias cronos="cd /Users/brian/src/cronos"
alias post="cd /Users/brian/src/postmaster"
alias chirp="cd /Users/brian/src/chirp"
alias devlog="tail -n 2000 -f ./log/development.log"
alias testlog="tail -n 2000 -f ./log/test.log"
alias psr="ps aux | grep ruby"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias pat="cd /Users/brian/src/icispatients"
alias hack="cd /Users/brian/projects"

############ Git ##################
alias g=git
alias gl='git pull --rebase --prune'
alias gbam='git fetch && git rebase origin/master'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gd='git diff'
alias gs='git status -sb'
alias gmerged='echo "Merged";git branch -a --merged;echo "Not Merged";git branch -a --no-merge'
alias sourcehitch='source ~/.hitch_export_authors'
alias unhitch='`which hitch` -u;echo "export GIT_AUTHOR_NAME=\"Brian Fitch\" GIT_AUTHOR_EMAIL=\"brianmfitch@gmail.com\"" > ~/.hitch_export_authors;source ~/.hitch_export_authors'


############# SOURCE ##############
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
#
# PROMPT_COMMAND='__git_ps1 "\[\033[1;36m\]\w" "\[\033[00m\] $ "'
#
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWSTASHSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1
# GIT_PS1_SHOWCOLORHINTS=1
# GIT_PS1_DESCRIBE_STYLE="branch"
# GIT_PS1_SHOWUPSTREAM="auto git"

function _update_ps1() {
   export PS1="$(powerline-shell-go bash $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"

ulimit -n 2560

############ DOCKER ##############
eval `boot2docker shellinit 2>/dev/null`

export EDITOR=vim
export BUNDLER_EDITOR=atom
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export OAUTHD_KEY=K-R83mS9ILV5IrYAC2A8scTaw1Q
export SNOWFLAKE_URI=http://snowflake.dev

export ICISSTAFF_DEVELOPMENT_SNOWFLAKE_KEY=38d039fa3e12ff7e788809b4221045043b3ba83f265abfb9352a4e6e5676e39d
export ICISSTAFF_DEVELOPMENT_SNOWFLAKE_SECRET=88c597a980027189981161b91848e88db3bd7e5823e54ac4ac3e215a933f97c9

function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$@"; }

PATH=$PATH:/usr/local/sbin:~/src/toolchest/bin:~/bin:opt/boxen/homebrew/opt/go/libexec/bin:~/Library/Haskell/bin
