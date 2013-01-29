# Test command exist
command_exists () {
    type "$1" &> /dev/null ;
}

# Load only if file exists
cond_source () {
    [[ -s "$1" ]] && source "$1"
}

platform=`uname`

#i18n
export LANG=en_US.UTF-8 # I prefer english over french, sorry
export XTERM_LOCALE=$LANG

PYTHONPATH="./:$PYTHONPATH"
export PYTHONPATH

RAILS_ENV="development"


# Handful aliases
alias mkdir='mkdir -p'
alias free='free -m'
alias grep='grep --color -i'
alias grepr='grep -rnH'
alias proj='cd /Users/thomas/Documents/Projets/'
alias nose='nosetests --with-doctest --rednose -s'
alias r='rails'
alias chmox='chmod +x'
alias f='python ~/.fpaster.py'

# Git
alias gc='git commit -a'
alias ga='git add '
alias gs='git status'
alias gp='git pull'
if command_exists ksdiff ; then
    alias gd='git difftool'
else
    alias gd='git diff'
fi

# Mercurial
alias hc='hg commit'
alias ha='hg addremove'
alias hs='hg status'
alias hp='hg pull'
alias hd='hg diff'

# Ruby RVM
cond_source "$HOME/.rvm/scripts/rvm"

# Python venv-wrapper
export WORKON_HOME=~/.venvs
mkdir -p $WORKON_HOME
export PATH="$WORKON_HOME:$PATH"
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
cond_source "/usr/bin/virtualenvwrapper.sh"
cond_source "/usr/local/bin/virtualenvwrapper.sh"

# Go!
export GOROOT="/Users/thomas/code/go"
alias go!='export GOPATH=`pwd`'


# Forward to dev server
function devfw {
    ssh -L 6379:localhost:6379 -L 27017:localhost:27017 pelletier.im -N
}


# You know it is the 21th century
export TERM="xterm-256color"

# Set macvim as the default editor if it is installed, just vim otherwise
if command_exists mvim ; then
    export EDITOR="mvim -f"
    alias vim='mvim -v'
else
    export EDITOR="vim"
fi

# Source Wo (https://gist.github.com/833807)
# FIXME produces an eval error.
#source $DOTFILES/wo/wo.sh

if [[ "$platform" == "Linux" ]];
then
# Linux specific
    alias ls='ls -AlGhp --color'
    alias ll='ls --format=single-column "--ignore=.*"'
    PATH="/home/thomas/.gem/ruby/1.9.1/bin:$PATH"
    PATH="/home/thomas/bin/:$PATH"
    export PATH=$PATH

    # Power control using DBus. (need to be in %wheel).
    alias shutdown='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop'
    alias reboot='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart'
    alias suspend='dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend'
    alias hibernate='dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate'
# OS X specific
else
    alias la='ls -ali'
    alias l='ls -1'
    alias ll='ls -C'
    # Some various binaries
    PATH="/Users/thomas/Bin:$PATH"
    # Python on OSX stuff
    PATH="/usr/local/sbin:$PATH"
    # Some Haskell
    PATH="$HOME/Library/Haskell/bin:$PATH"
    PATH="/Users/thomas/.cabal/bin:$PATH"
    # Ruby
    PATH="/Users/thomas/.gem/ruby/1.8/bin:$PATH"
    # Google Chromium dev tools
    PATH="/Users/thomas/code/depot_tools:$PATH"
    # Math student => Maple
    alias maple='/Library/Frameworks/Maple.framework/Versions/Current/bin/maple'
    # For python and because of XCode 4
    export ARCHFLAGS="-arch x86_64"
    # Running XMonad on OS X
    export USERWM=`which xmonad`
    # Use Emacs GUI on OS X
    alias emacs='open -a Emacs.app'

    # Set the path
    export PATH="/Users/thomas/Bin/:/Applications/Postgres.app/Contents/MacOS/bin:/usr/local/bin:$PATH"

    alias java7="/Library/Java/JavaVirtualMachines/1.7.0.jdk/Contents/Home/bin/java"
fi

# Look for files containing a certain pattern
# To look for every python file of the current dir containing DEBUG:
# findin code/*.py DEBUG
function findin {
    grep -lir "$@[-1]" "$@[1,-2]"
}

# Alias for findin: search every single file contained in the current directory
alias has="findin ./*"

# NPM
export NODE_PATH="/usr/local/lib/node_modules:/Users/thomas/.npm/"

# Clojure (homebrew)
export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure/1.2.0/clojure.jar:/Users/thomas/.vim/bundle/vimclojure/bin/server-2.2.0.jar:/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export RPROMPT="$(parse_git_branch) "


# t
alias t='python ~/.t/t.py --task-dir ~/.tasks --list tasks'

alias fab='fab -c .fabrc'

# Now use virtual manager.
export VM_DIR="/Users/thomas/code/virtual-manager/"
if [ -e "$VM_DIR" ]
then source "$VM_DIR/vm.sh"
fi

export GOROOT=$HOME/code/go
export PATH=$GOROOT/bin:$PATH

alias emacs='emacs -nw'
alias soul='cd ~/netsoul && perl jogsoul.pl jogsoul.conf'

if [[ "$platform" == "Linux" ]];
then
    export TERMINAL=xterm
fi

alias valgrind='valgrind --tool=memcheck --leak-check=yes --show-reachable=yes'
