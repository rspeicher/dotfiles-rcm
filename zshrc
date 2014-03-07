setopt nobeep

# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh-completions $fpath)

# completion
autoload -U compinit
compinit

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt always_to_end
setopt auto_menu
setopt complete_in_word
setopt listpacked

# Case-insensitive and fuzzy-like matching for completion
# 'lic<TAB>' completes LICENSE; 'bundle<TAB>' completes 'vimrc.bundles'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''

for function in ~/.zsh/functions/*; do
  source $function
done

# history settings
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

HISTFILE=$HOME/.zsh_history
SAVEHIST=4096
HISTSIZE=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jk vi-cmd-mode

setopt noautomenu      # don't cycle completions
setopt pushdignoredups # and don't duplicate them
setopt recexact        # recognise exact, ambiguous matches
setopt nocorrect
setopt nullglob

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
