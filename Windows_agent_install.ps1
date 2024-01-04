$wazuhAgentUri  = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.7.0-1.msi"
$wazuhAgentPath = "${env:tmp}\wazuh-agent.msi"

Invoke-WebRequest -Uri $wazuhAgentUri -OutFile $wazuhAgentPath

$installCommand = "msiexec.exe /i $wazuhAgentPath /q WAZUH_MANAGER='wazuh-agent.styl.solutions' WAZUH_REGISTRATION_SERVER='wazuh-agent.styl.solutions' WAZUH_AGENT_GROUP='default'"

Invoke-Expression $installCommand
Write-Host "Wazuh agent installed successfully."

Start-Sleep -Seconds 5

# This is the actual path of the ossec.conf for Wazuh agent
$defaultOssecConfPath = "C:\Program Files (x86)\ossec-agent\ossec.conf"

# This is the custom ossec.conf file we want to replace
$customConfPath = ".\windows_custom.conf"

if (-not (Test-Path $defaultOssecConfPath)) {
    Write-Host "ossec.conf not found. Please check the file path."
} elseif (-not (Test-Path $customConfPath)) {
    Write-Host "custom.conf not found. Please check the file path."
} else {
    # Replace ossec.conf with replace.conf
    
    $agentName = Read-Host "Enter your agent name"
    # $groupName = Read-Host "Enter your agent group name"
    $groupName = Read-Host "Enter your agent group name"
    
    $customConfContent = Get-Content -Path $customConfPath -Raw
    $customConfContent = $customConfContent -replace '<agent_name>AGENT_NAME</agent_name>', "<agent_name>$agentName</agent_name>"
    $customConfContent = $customConfContent -replace '<groups>GROUP_NAME</groups>', "<groups>$groupName</groups>"
    $customConfContent | Set-Content -Path $defaultOssecConfPath
    
    Write-Host "default ossec.conf has been replaced successfully."
}

Start-Service Wazuh

Write-Host "Wazuh agent service started successfully."

Set-ExecutionPolicy Default -Force
