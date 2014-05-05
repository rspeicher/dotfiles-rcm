# Python site-packages
# export PYTHONPATH=/usr/local/lib/python2.7/site-packages

# http://golang.org/doc/code.html#GOPATH
export GOPATH=$HOME/Code/go

# Local bin folder
export PATH=$HOME/.bin:$GOPATH/bin:/usr/local/bin:$PATH

export PATH=$PATH:/usr/local/Cellar/go/1.2.1/libexec/bin

# load rbenv if available
if which rbenv &>/dev/null ; then
  export RBENV_ROOT=/usr/local/var/rbenv
  eval "$(rbenv init -)"
fi

# load pyenv if available
if which pyenv &>/dev/null ; then
  export PYENV_ROOT=/usr/local/opt/pyenv
  eval "$(pyenv init -)"
fi

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
