# SCRIPT: renato-dev-setup/install.ps1

Write-Host "Iniciando a instalação e configuração do ambiente de desenvolvimento no Windows..." -ForegroundColor Cyan

# --- 1. Habilitar Recursos do WSL ---
Write-Host "Verificando e habilitando os recursos do WSL e Plataforma de Máquina Virtual..." -ForegroundColor Green
try {
    # Habilita o Subsistema do Windows para Linux
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -ErrorAction Stop
    # Habilita a Plataforma de Máquina Virtual (necessário para WSL 2)
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -ErrorAction Stop
    Write-Host "Recursos do WSL habilitados com sucesso." -ForegroundColor Green
}
catch {
    Write-Host "Erro ao habilitar recursos do WSL: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Verifique se você está executando o PowerShell como administrador." -ForegroundColor Yellow
    Pause
    Exit
}

# --- 2. Definir WSL 2 como Versão Padrão ---
Write-Host "Definindo WSL 2 como a versão padrão..." -ForegroundColor Green
try {
    wsl --set-default-version 2
    Write-Host "WSL 2 definido como versão padrão." -ForegroundColor Green
}
catch {
    Write-Host "Erro ao definir WSL 2 como padrão: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Certifique-se de que o WSL foi atualizado. Execute 'wsl --update' no PowerShell se necessário." -ForegroundColor Yellow
}

# --- 3. Instalar Distribuição Ubuntu 22.04 LTS ---
Write-Host "Verificando e instalando Ubuntu 22.04 LTS..." -ForegroundColor Green
$ubuntuDistroName = "Ubuntu-22.04"
$ubuntuAppxUrl = "https://aka.ms/wslubuntu2204"
$ubuntuAppxFile = "Ubuntu.appx"

if (-not (wsl --list --quiet | Select-String $ubuntuDistroName)) {
    Write-Host "Baixando Ubuntu 22.04 LTS. Isso pode levar alguns minutos..." -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $ubuntuAppxUrl -OutFile $ubuntuAppxFile -UseBasicParsing
        Add-AppxPackage -Path $ubuntuAppxFile
        Remove-Item $ubuntuAppxFile # Limpa o arquivo de instalação
        Write-Host "Ubuntu 22.04 LTS instalado com sucesso. Pode ser necessário abrir o Ubuntu pela primeira vez para finalizar a configuração inicial (criar usuário/senha)." -ForegroundColor Green
        Start-Sleep -Seconds 5 # Pequena pausa para a distro se registrar
    }
    catch {
        Write-Host "Erro ao baixar ou instalar Ubuntu: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Tente instalar manualmente pela Microsoft Store ou verifique sua conexão com a internet." -ForegroundColor Yellow
        Pause
        Exit
    }
} else {
    Write-Host "Ubuntu 22.04 LTS já está instalado." -ForegroundColor Green
}

# --- 4. Instalar Ferramentas Essenciais no Windows (Winget) ---
Write-Host "Verificando e instalando VS Code e Docker Desktop via Winget..." -ForegroundColor Green
# Certifique-se de que o Winget está disponível. Geralmente vem com o Windows 10/11 atualizado.

$appsToInstall = @(
    @{ Id = "Microsoft.VisualStudioCode"; Name = "VS Code" },
    @{ Id = "Docker.DockerDesktop"; Name = "Docker Desktop" }
)

foreach ($app in $appsToInstall) {
    Write-Host "Instalando $($app.Name)..." -ForegroundColor DarkCyan
    try {
        winget install --id $($app.Id) -e --accept-package-agreements --accept-source-agreements
        Write-Host "$($app.Name) instalado/atualizado com sucesso." -ForegroundColor Green
    }
    catch {
        Write-Host "Aviso: Falha ao instalar $($app.Name) via Winget. Pode ser que já esteja instalado ou ocorreu um erro: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# --- 5. Executar o Script de Configuração dentro do WSL ---
Write-Host "Transferindo e executando o script de configuração de dotfiles no WSL..." -ForegroundColor Cyan

# Obter o caminho absoluto do diretório renato-dev-setup
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$wslSetupPath = "/mnt/c/Users/$env:UserName/renato-dev-setup" # Caminho onde o repo é clonado/colocado no WSL

Write-Host "Certifique-se de que o repositório 'renato-dev-setup' esteja em '$wslSetupPath' (ou ajuste o caminho)." -ForegroundColor Yellow

# Tenta criar um atalho para o dotfiles/install.sh para facilitar a execução
# ATENÇÃO: A execução direta do script WSL pode falhar se o usuário do WSL não estiver configurado ainda.
# É mais seguro instruir o usuário a executá-lo manualmente.

Write-Host "`n--- PRÓXIMOS PASSOS IMPORTANTES ---" -ForegroundColor Yellow
Write-Host "1. Abra o Ubuntu 22.04 LTS (ou sua distro WSL) para criar seu usuário e senha." -ForegroundColor Yellow
Write-Host "2. Após criar o usuário, navegue até a pasta onde este repositório está no WSL:" -ForegroundColor Yellow
Write-Host "   Exemplo: cd /mnt/c/Users/$env:UserName/renato-dev-setup/dotfiles" -ForegroundColor Yellow
Write-Host "3. Execute o script de configuração de dotfiles:" -ForegroundColor Yellow
Write-Host "   bash install.sh" -ForegroundColor Yellow
Write-Host "Isso instalará as ferramentas e configurará seu ambiente Linux." -ForegroundColor Yellow

Write-Host "`nSetup do Windows concluído. Por favor, reinicie seu computador para garantir que todas as mudanças do WSL entrem em vigor." -ForegroundColor Green
Write-Host "Após o reinício, siga os PRÓXIMOS PASSOS para finalizar a configuração dentro do WSL." -ForegroundColor Green