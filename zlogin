# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt promptsubst

# Local config
[[ -f ~/.zlogin.local ]] && source ~/.zlogin.local
