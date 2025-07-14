# FILE: renato-dev-setup/dotfiles/.zshrc

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Choose a random theme with: ZSH_THEME="random"
# ZSH_THEME="agnoster" # Um tema popular que precisa de fontes Powerline
ZSH_THEME="robbyrussell" # Um tema mais simples e leve

# Example plugins enabled by oh-my-zsh.
# ZSH_CUSTOM/plugins/ (recommended for custom plugins)
plugins=(
  git
  docker
  docker-compose
  npm
  node
  python
  zsh-autosuggestions # Adicione este plugin
  zsh-syntax-highlighting # Adicione este plugin
)

source $ZSH/oh-my-zsh.sh

# --- Personalizações ---

# Carrega seus aliases personalizados
if [ -f "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Configurações do NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Configurações do Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Configuração para VS Code
export EDITOR="code --wait"

# Funções ou variáveis adicionais podem ser colocadas aqui
# Exemplo: Prompt personalizado (se não usar tema Oh My Zsh)
# PROMPT="%{$fg[green]%}%n@%m%{$reset_color%} %{$fg[blue]%}%c%{$reset_color%}%# "

# Habilita o auto-complete para o Docker
autoload -Uz compinit
compinit