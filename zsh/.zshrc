# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z fast-syntax-highlighting zsh-autosuggestions fzf rbenv dotenv)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
export XDG_CONFIG_HOME=$HOME/.config

alias zshconfig="nvim $ZDOTDIR/.zshrc"
alias ohmyzsh="nvim $ZDOTDIR/.oh-my-zsh"

ulimit -n 10240

alias gpp='GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa" git push'
alias gpw='GIT_SSH_COMMAND="ssh -i ~/.ssh/jiva_rsa" git push'

alias gfp='GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa" git pull -r'
alias gfw='GIT_SSH_COMMAND="ssh -i ~/.ssh/jiva_rsa" git pull -r'
eval "$($(brew --prefix rbenv)/bin/rbenv init - zsh)"
eval "$(pyenv init -)"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/Cellar/universal-ctags/p6.0.20230730.0/bin:$PATH"

source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(rbenv init - zsh)"

[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
eval "$(opam env)"

export PATH="$HOME/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PATH="$HOME/bin:$PATH"
export PATH="$XDG_CONFIG_HOME/scripts:$PATH"
export PIPENV_VENV_IN_PROJECT=1

# Created by `pipx` on 2023-12-19 17:04:35
export PATH="$PATH:/Users/gahan/.local/bin"
[[ ! -r /Users/gahan/.opam/opam-init/init.zsh ]] || source /Users/gahan/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

export HOMEBREW_NO_AUTO_UPDATE=1
alias k=kubectl
alias gitui='gitui -t catppuccin-$CATPPUCCIN_FLAVOR.ron'

srf() {
rg --color=always --line-number --no-heading --smart-case "${*:-}" |
  fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(nvim {1} +{2})'
}

export PYTHONBREAKPOINT="ipdb.set_trace"
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export GDAL_LIBRARY_PATH=/opt/homebrew/opt/gdal/lib/libgdal.dylib
export GEOS_LIBRARY_PATH=/opt/homebrew/opt/geos/lib/libgeos_c.dylib
export PATH="$HOME/.rd/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin/flutter/bin:$PATH"
export DENO_INSTALL="/Users/gahan/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export GIT_EDITOR=nvim
export EDITOR=nvim
export KUBECTL_EXTERNAL_DIFF="colordiff -N -u"
export PATH="/opt/homebrew/opt/mariadb@10.11/bin:$PATH"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"
