# 🚀 Renato Dev Setup

Este repositório contém scripts e configurações para automatizar a instalação e configuração do meu ambiente de desenvolvimento fullstack no Windows, utilizando **WSL2 (Windows Subsystem for Linux)**, **Docker** e **dotfiles** personalizados. O objetivo é otimizar o tempo e garantir um ambiente de desenvolvimento consistente e profissional.

---

## 🎯 Objetivo

* Automatizar a instalação do WSL2 e uma distribuição Linux (Ubuntu 22.04 LTS).
* Instalar ferramentas essenciais como VS Code e Docker Desktop no Windows.
* Configurar o ambiente Linux com Zsh, Oh My Zsh, Node.js (via NVM), Python (via pyenv) e suas configurações personalizadas (dotfiles).
* Fornecer um template para ambientes Docker específicos de projeto.

---

## 📋 Pré-requisitos

* **Windows 10 (versão 2004 ou superior) ou Windows 11.**
* Conexão ativa com a internet.
* **Permissões de Administrador:** O script `install.ps1` deve ser executado com privilégios de administrador.

---

## 🚀 Como Usar

### 1. No Windows

1.  **Clone este repositório** para uma pasta de sua preferência no Windows (ex: `C:\Users\SeuUsuario\renato-dev-setup`).
    ```bash
    git clone [https://github.com/SeuUsuario/renato-dev-setup.git](https://github.com/SeuUsuario/renato-dev-setup.git) C:\Users\SeuUsuario\renato-dev-setup
    ```
    (Ajuste `SeuUsuario` e `https://github.com/SeuUsuario/renato-dev-setup.git` para o seu caso).
2.  **Abra o PowerShell como Administrador.**
3.  **Navegue até a pasta** onde você clonou o repositório:
    ```powershell
    cd C:\Users\SeuUsuario\renato-dev-setup
    ```
4.  **Execute o script de instalação:**
    ```powershell
    .\install.ps1
    ```
    Este script irá:
    * Habilitar os recursos do WSL e Plataforma de Máquina Virtual.
    * Definir WSL 2 como a versão padrão.
    * Baixar e instalar o Ubuntu 22.04 LTS (se já não estiver instalado).
    * Instalar o **VS Code** e **Docker Desktop** via Winget.
5.  **Reinicie seu computador** após a execução do script. Isso é crucial para que as alterações do WSL entrem em vigor.

### 2. No WSL (Ubuntu)

Após reiniciar o computador e o script do Windows ter sido executado:

1.  **Abra o aplicativo "Ubuntu 22.04 LTS"** no menu iniciar do Windows.
    * Na primeira execução, o Ubuntu pedirá para você criar um **nome de usuário** e **senha** para o ambiente Linux. Faça isso.
2.  **Navegue até a pasta `dotfiles`** dentro do seu repositório clonado (que estará acessível via `/mnt/c/` no WSL):
    ```bash
    cd /mnt/c/Users/SeuUsuario/renato-dev-setup/dotfiles
    ```
    (Ajuste `SeuUsuario` para o seu nome de usuário do Windows).
3.  **Torne o script `install.sh` executável** e execute-o:
    ```bash
    chmod +x install.sh
    ./install.sh
    ```
    Este script irá:
    * Atualizar os pacotes do sistema (apt).
    * Instalar Zsh e Oh My Zsh.
    * Instalar NVM (Node Version Manager) e a versão LTS do Node.js.
    * Instalar `build-essential` (para compilação de pacotes).
    * Copiar seus dotfiles (`.zshrc`, `.aliases`, `.gitconfig`) para seu diretório `$HOME`.
    * Definir Zsh como seu shell padrão.
4.  **Reinicie o terminal WSL** (feche e abra o aplicativo Ubuntu novamente) para que as mudanças no `.zshrc` e o shell padrão entrem em vigor.

---

## 📂 Estrutura do Projeto

* **`install.ps1`**: Script PowerShell executado no Windows para configurar o WSL e instalar ferramentas básicas.
* **`README.md`**: Esta documentação.
* **`dotfiles/`**: Contém as configurações personalizadas para o ambiente Linux.
    * **`install.sh`**: Script Bash executado dentro do WSL para instalar ferramentas e configurar dotfiles.
    * **`.zshrc`**: Configurações do shell Zsh.
    * **`.aliases`**: Atalhos de comando personalizados.
    * **`.gitconfig`**: Configurações globais do Git.
* **`docker/`**: Modelos para ambientes de desenvolvimento baseados em Docker.
    * **`Dockerfile`**: Exemplo de arquivo para construir uma imagem Docker de desenvolvimento.
    * **`docker-compose.yml`**: Exemplo de arquivo para orquestrar serviços Docker.
    * **`.dockerignore`**: Arquivos/pastas a serem ignorados na construção de imagens Docker.

---

## 🛠️ Pós-Instalação e Ajustes

* **VS Code:**
    * Instale extensões úteis para seu desenvolvimento (WSL, Docker, linguagens, etc.). A extensão "WSL" é crucial para uma integração perfeita.
    * Abra suas pastas de projeto no WSL diretamente do VS Code (`code .` dentro do WSL).
* **Docker Desktop:**
    * Certifique-se de que o Docker Desktop está rodando no Windows.
    * Nas configurações do Docker Desktop -> Resources -> WSL Integration, habilite a integração com sua distribuição Ubuntu 22.04.
* **Git:** Configure suas credenciais Git (se não estiverem no `.gitconfig`) e/ou use o `git-credential-manager` no WSL para cache de credenciais.

---

## 🐛 Solução de Problemas

* **"O WSL não está habilitado"**: Certifique-se de executar `install.ps1` como **administrador** e que seu Windows está atualizado.
* **"wsl --set-default-version 2 falhou"**: Pode ser que o componente do kernel do WSL não esteja atualizado. Tente executar `wsl --update` no PowerShell e depois reinicie.
* **Problemas de Conexão no WSL**: Verifique se sua máquina Windows tem acesso à internet.
* **Erro na instalação do Ubuntu**: Se o download ou a instalação falhar, tente novamente ou baixe e instale o Ubuntu manualmente pela Microsoft Store.
* **`command not found` no WSL**: Se você não vê `nvm` ou `node` após `install.sh`, feche e reabra o terminal WSL para recarregar as configurações do `.zshrc`. Verifique também se o `nvm` foi instalado corretamente (pode ser necessário rodar `source ~/.zshrc` ou `exec zsh`).

---