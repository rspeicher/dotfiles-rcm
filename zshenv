# Python site-packages
export PYTHONPATH=/usr/local/lib/python2.7/site-packages

# Local bin folder
export PATH=$HOME/.bin:$PATH

# load rbenv if available
if which rbenv &>/dev/null ; then
  export RBENV_ROOT=/usr/local/var/rbenv
  eval "$(rbenv init -)"
fi

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
