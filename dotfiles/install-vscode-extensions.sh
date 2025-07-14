#!/bin/bash

echo "📦 Instalando extensões do VS Code..."

# Lista de extensões do VS Code para instalar
EXTENSIONS=(
  # Temas e Ícones
  dracula-theme.theme-dracula             # Tema escuro popular
  vscode-icons-team.vscode-icons          # Ícones para arquivos e pastas

  # Produtividade Geral
  esbenp.prettier-vscode                  # Formatador de código
  dbaeumer.vscode-eslint                  # Análise de código JavaScript/TypeScript
  formulahendry.code-runner               # Executa snippets de código ou arquivos para várias linguagens
  ritwickdey.liveserver                   # Servidor de desenvolvimento local com live reload para HTML/CSS/JS
  glenn2223.live-sass                     # Compilador SASS/SCSS ao vivo
  bracketpaircolordlw.bracket-pair-color-dlw # Colore pares de colchetes

  # Ferramentas de IA (exigem conta e configuração)
  github.copilot                          # Seu assistente de codificação de IA
  github.copilot-chat                     # Chat com Copilot
  google.geminicodeassist                 # Assistente de código do Google (se disponível e configurado)

  # Suporte a Linguagens e Ferramentas (Fullstack)
  # JavaScript/TypeScript/Node.js/Deno
  denoland.vscode-deno                      # Suporte a Deno (se você usa)
  ms-vscode.js-debug-nightly              # Debugger JS/TS (geralmente já vem com o VS Code)

  # Python
  ms-python.python                        # Extensão oficial do Python (linguasense, depuração, etc.)
  ms-python.vscode-pylance                # Servidor de linguagem Pylance para Python
  ms-python.autopep8                      # Formatador de código Python
  ms-python.debugpy                       # Depurador Python

  # Docker e Containers
  ms-azuretools.vscode-containers         # Desenvolvimento em containers
  ms-vscode-remote.remote-containers      # Abrir pastas em containers

  # Banco de Dados
  cweijan.dbclient-jdbc                   # Cliente de banco de dados genérico (JDBC)
  cweijan.vscode-database-client2         # Cliente de banco de dados mais abrangente

  # API
  postman.postman-for-vscode              # Cliente Postman integrado no VS Code

  # WSL e Remoto (Essenciais para seu setup)
  ms-vscode-remote.remote-wsl             # Integração com WSL
  ms-vscode-remote.remote-ssh             # Conectar via SSH a máquinas remotas
  ms-vscode-remote.remote-ssh-edit        # Edição de configurações SSH
  ms-vscode-remote.remote-extensionpack   # Pacote de extensões de desenvolvimento remoto
  ms-vscode.remote-explorer               # Explorador de conexões remotas
  ms-vscode.remote-server                 # Componente de servidor remoto

  # Outras Utilidades
  mechatroner.rainbow-csv                 # Colore colunas CSV para facilitar leitura
  ms-vsliveshare.vsliveshare              # Compartilhamento de código e colaboração em tempo real
  ms-vscode.powershell                    # Suporte a PowerShell (se usar no Windows ou para scripts)
)

for extension in "${EXTENSIONS[@]}"; do
  echo "🔧 Instalando: $extension"
  # O "--force" garante que a instalação ocorra mesmo se já estiver instalada, útil para atualizações
  code --install-extension "$extension" --force
done

echo "✅ Todas as extensões foram instaladas!"
echo "Recomendado reiniciar o VS Code para que todas as extensões funcionem corretamente."