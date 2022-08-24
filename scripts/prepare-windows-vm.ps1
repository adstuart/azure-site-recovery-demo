# Setup logging
Start-Transcript -path "C:\MachinePrep\logs\log.txt"

# Create directory to store installation files
New-Item -ItemType directory -Path C:\MachinePrep\files

try {
    # Install RSAT Tools
    Write-Host "Installing RSAT Tools..."
    Install-WindowsFeature -IncludeAllSubFeature RSAT
}
catch {
    Write-Host "Unable to install RSAT Tools"
}

try {

    # Install nuget package manager
    Write-Host "Installing nuget..."
    Install-PackageProvider -Name Nuget -Force 

    # Install Azure CLI
    Write-Host "Downloading Azure CLI..."
    $cliUri = "https://aka.ms/installazurecliwindows"
    Invoke-WebRequest -Uri $cliUri -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi

    # Install Azure PowerShell
    Write-Host "Installing Azure CLI..."
    Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
}

catch {
    Write-Host "Unable to install Azure CLI"
}

try {
    # Create test files
    Write-Host "Creating test files"

    New-Item 'F:\sample-files' -ItemType directory
    "This is sample file 1" | Out-File F:\sample-files\samplefile1.txt
    "This is sample file 2" | Out-File F:\sample-files\samplefile2.txt
    "This is sample file 3 and its original content" | Out-File F:\sample-files\samplefile3.txt
}   
catch {
    Write-Host "Unable to create test files"
}

try {
    # Download MARS agent
    $marsUri = "https://aka.ms/azurebackup_agent"
    $marsDest = "C:\MachinePrep\files\mars-agent.exe"
    Invoke-WebRequest -Uri $marsUri -OutFile $marsDest

    # Install MARS agent
    Start-Process $marsDest -ArgumentList '/q'

}

catch {
    Write-Host "Unable to install MARS agent"
}
Stop-Transcript 