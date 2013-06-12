# Helpers {{{
# Test command exist
command_exists () {
    type "$1" &> /dev/null ;
}

# Load only if file exists
cond_source () {
    [[ -s "$1" ]] && source "$1"
}


platform=`uname`

# }}}
# General Shell {{{
# You know it is the 21th century
export TERM="xterm-256color"

# i18n
export LANG=en_US.UTF-8 # I prefer english over french, sorry
export XTERM_LOCALE=$LANG

# PyPy
PYTHONPATH="$HONE/code/pypy/:$PYTHONPATH"
PYTHONPATH="./:$PYTHONPATH"
export PYTHONPATH

RAILS_ENV="development"
# }}}
# Handy aliases {{{
alias mkdir='mkdir -p'
alias free='free -m'
alias grep='grep --color -i'
alias grepr='grep -rnH'
alias chmox='chmod +x'

# Look for files containing a certain pattern
# To look for every python file of the current dir containing DEBUG:
# findin code/*.py DEBUG
function findin {
    grep -lir "$@[-1]" "$@[1,-2]"
}

# Alias for findin: search every single file contained in the current directory
alias has="findin ./*"
# }}}
# Vim {{{
# Set macvim as the default editor if it is installed, just vim otherwise
if command_exists mvim ; then
    export EDITOR="mvim -f"
    alias vim='mvim -v'
else
    export EDITOR="vim"
fi
# }}}
# Emacs {{{
alias emacs='emacs -nw'
# }}}
# Python {{{
export PYTHONPATH="./:$PYTHONPATH"

export WORKON_HOME=~/.venvs
mkdir -p $WORKON_HOME
export PATH="$WORKON_HOME:$PATH"
#VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
cond_source "/usr/bin/virtualenvwrapper.sh"
cond_source "/usr/local/bin/virtualenvwrapper.sh"

alias nose='nosetests --with-doctest --rednose -s'
alias fab='fab -c .fabrc'
# }}}
# Ruby / Rails {{{
cond_source "$HOME/.rvm/scripts/rvm"
export RAILS_ENV="development"
alias r='rails'
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then
    eval "$(rbenv init -)";
    export PATH="$HOME/.rbenv/shims:$PATH"
fi
# }}}
# Go! {{{
export GOROOT=$HOME/code/go
export PATH=$GOROOT/bin:$PATH
export PATH=$HOME/code/google_appengine:$PATH

alias go!='export GOPATH=`pwd`'
# }}}
# Node {{{
export NODE_PATH="/usr/local/lib/node_modules:/Users/thomas/.npm/"
export PATH="./node_modules/.bin:$PATH"
export grunt='nocorrect grunt'
# }}}
# Git {{{
alias g='git'
alias gc='git commit -a'
alias ga='git add '
alias gs='git status'
alias gp='git pull'
if command_exists ksdiff; then
    alias gd='git difftool'
else
    alias gd='git diff'
fi
# }}}
# Mercurial {{{
alias hc='hg commit'
alias ha='hg addremove'
alias hs='hg status'
alias hp='hg pull'
alias hd='hg diff'
# }}}
# Valgrind {{{
alias valgrind='valgrind --tool=memcheck --leak-check=yes --show-reachable=yes'
# }}}
# Linux {{{
if [[ "$platform" == "Linux" ]]; then
    alias ll='\ls -lGhp --color'
    alias ls='\ls -Ali --color'
    alias l='\ls --color -1'
    PATH="/home/thomas/.gem/ruby/1.9.1/bin:$PATH"
    PATH="$HOME/bin/:$PATH"
    export PATH="/home/thomas/bin/:$PATH"
    export TERMINAL=xterm

    # Power control using DBus. (need to be in %wheel).
    alias shutdown='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop'
    alias reboot='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart'
    alias suspend='dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend'
    alias hibernate='dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate'
fi
# }}}
# FreeBSD {{{
if [[ "$platform" == "FreeBSD" ]];
then
    alias gdb='gdb --tui'
fi
# }}}}
# OS X {{{
if [[ "$platform" == "Darwin" ]]; then
    alias la='ls -ali'
    alias l='ls -1'
    alias ll='ls -C'

    # Because fuck you Apple
    alias java7="/Library/Java/JavaVirtualMachines/1.7.0.jdk/Contents/Home/bin/java"

    # For python and because of XCode 4
    export ARCHFLAGS="-arch x86_64"
    # Use Emacs GUI on OS X
    alias emacs='open -a Emacs.app'

    # Clojure with Homebrew
    export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure/1.2.0/clojure.jar:/Users/thomas/.vim/bundle/vimclojure/bin/server-2.2.0.jar:/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar

    # Some various binaries
    PATH="/Users/thomas/Bin:$PATH"
    # Python on OSX stuff
    PATH="/usr/local/sbin:$PATH"
    # Some Haskell
    PATH="$HOME/Library/Haskell/bin:$PATH"
    PATH="/Users/thomas/.cabal/bin:$PATH"
    # Google Chromium dev tools
    PATH="/Users/thomas/code/depot_tools:$PATH"
    # Decent Postgres version
    PATH="/Users/thomas/Bin/:/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
    # Self-built programs
    PATH="/usr/local/bin:$PATH"

    export PATH=$PATH
fi
# }}}
# EPITA {{{
alias soul='cd ~/netsoul && perl jogsoul.pl jogsoul.conf'

if [[ "$platform" == "Linux" ]];
then
    export TERMINAL=xterm
fi

alias valgrind='valgrind --tool=memcheck --leak-check=yes --show-reachable=yes'

if [[ "$platform" == "FreeBSD" ]];
then
    alias gdb='gdb --tui'
fi
alias z='zlock -immed'
export PATH=/home/pellet_t/local/bin:$PATH
# }}}
# Emscripten {{{
export PATH="$HOME/src/emscripten/:$PATH"
# }}}
