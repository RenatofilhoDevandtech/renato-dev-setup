# SCRIPT: renato-dev-setup/dotfiles/install.sh

echo "Iniciando a configuração do ambiente de desenvolvimento no WSL..."

# --- 1. Atualizar e Instalar Pacotes Essenciais ---
echo "Atualizando listas de pacotes e instalando 'build-essential'..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential curl wget git zsh locales

# Configura o locale para evitar warnings
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8

# --- 2. Instalar Oh My Zsh e Definir como Shell Padrão ---
echo "Instalando Zsh e Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "Oh My Zsh instalado."
else
    echo "Oh My Zsh já está instalado."
fi

# Definir Zsh como o shell padrão
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s $(which zsh)
    echo "Zsh definido como shell padrão. Você precisará reiniciar seu terminal."
else
    echo "Zsh já é o shell padrão."
fi

# --- 3. Instalar NVM (Node Version Manager) e Node.js LTS ---
echo "Instalando NVM (Node Version Manager) e Node.js LTS..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    # Carregar NVM para uso imediato no script
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
    echo "Node.js LTS instalado via NVM."
else
    echo "NVM já está instalado. Verificando Node.js LTS..."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    if ! nvm list | grep "lts/\*" > /dev/null; then
        nvm install --lts
        nvm use --lts
        nvm alias default 'lts/*'
        echo "Node.js LTS instalado via NVM."
    else
        echo "Node.js LTS já está instalado."
    fi
fi

# --- 4. Instalar Pyenv e Python (Exemplo: 3.10) ---
echo "Instalando Pyenv e Python 3.10 (opcional, ajuste a versão)..."
if [ ! -d "$HOME/.pyenv" ]; then
    curl https://pyenv.run | bash
    # Carregar Pyenv para uso imediato no script
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"

    # Instalar uma versão específica do Python (você pode ajustar)
    pyenv install 3.10.12
    pyenv global 3.10.12
    echo "Pyenv e Python 3.10.12 instalados."
else
    echo "Pyenv já está instalado. Verificando Python 3.10.12..."
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
    if ! pyenv versions | grep "3.10.12" > /dev/null; then
        pyenv install 3.10.12
        pyenv global 3.10.12
        echo "Python 3.10.12 instalado."
    else
        echo "Python 3.10.12 já está instalado."
    fi
fi

# --- 5. Copiar Dotfiles ---
echo "Copiando dotfiles para o diretório HOME..."

# Certifica-se de que a pasta dotfiles está no diretório correto
DOTFILES_DIR="$(dirname "$(realpath "$0")")"

cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
cp "$DOTFILES_DIR/.aliases" "$HOME/.aliases"
cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

echo "Dotfiles copiados. Você pode querer revisar o conteúdo desses arquivos."

# --- 6. Instalar Plugins Oh My Zsh (opcional) ---
echo "Instalando plugins comuns para Oh My Zsh (zsh-autosuggestions, zsh-syntax-highlighting)..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || echo "zsh-autosuggestions já existe."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || echo "zsh-syntax-highlighting já existe."
echo "Lembre-se de adicionar 'zsh-autosuggestions zsh-syntax-highlighting' na sua lista de plugins no .zshrc."

echo "Configuração do WSL concluída! Por favor, feche e reabra o terminal para aplicar todas as mudanças."
echo "Para verificar, digite 'zsh' para garantir que seu shell mudou, ou 'node -v' e 'python -v'."