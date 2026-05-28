# setup-ai-env.ps1
# Script to set up the AI development environment in any project.

# Source template directory
$SourceDir = "$PSScriptRoot\project"
# Target destination directory
$DestDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(".\")

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "  Starting AI Development Env Setup" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Source: $SourceDir"
Write-Host "Destination: $DestDir"
Write-Host ""

# Check if source exists
if (-not (Test-Path $SourceDir)) {
    Write-Error "Error: Source directory '$SourceDir' not found. Please make sure this script is located inside the template repository."
    exit 1
}

# 1. Copy template files
Write-Host "1. Copying template files..." -ForegroundColor Yellow
$ItemsToCopy = @("AGENTS.md", ".agent", "docs")
foreach ($item in $ItemsToCopy) {
    $src = Join-Path $SourceDir $item
    $dest = Join-Path $DestDir $item
    if (Test-Path $src) {
        Write-Host "  Copying $item -> $dest"
        Copy-Item -Path $src -Destination $dest -Recurse -Force
    } else {
        Write-Warning "  Warning: Source item '$item' not found."
    }
}

# 2. Create external_repos directory
$extRepoDir = Join-Path $DestDir "external_repos"
if (-not (Test-Path $extRepoDir)) {
    Write-Host "2. Creating external_repos directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $extRepoDir | Out-Null
    Write-Host "  Created: $extRepoDir"
} else {
    Write-Host "2. Directory 'external_repos' already exists." -ForegroundColor DarkGray
}

# 3. Initialize Git if not already initialized
Write-Host "3. Checking Git repository status..." -ForegroundColor Yellow
$gitDir = Join-Path $DestDir ".git"
if (-not (Test-Path $gitDir)) {
    Write-Host "  Git is not initialized. Running 'git init'..." -ForegroundColor Cyan
    git init
} else {
    Write-Host "  Git repository is already initialized." -ForegroundColor DarkGray
}

# 4. Configure .gitignore
Write-Host "4. Configuring .gitignore..." -ForegroundColor Yellow
$gitignorePath = Join-Path $DestDir ".gitignore"
$ignorePatterns = @(
    "external_repos/",
    ".env",
    ".env.*",
    "*.key",
    "*.pem",
    "__pycache__/",
    "*.pyc"
)

# Load existing .gitignore content
$existingContent = @()
if (Test-Path $gitignorePath) {
    $existingContent = Get-Content $gitignorePath
    Write-Host "  Found existing .gitignore." -ForegroundColor DarkGray
} else {
    Write-Host "  Creating new .gitignore." -ForegroundColor DarkGray
    New-Item -ItemType File -Path $gitignorePath | Out-Null
}

# Append patterns if they do not exist
$addedAny = $false
foreach ($pattern in $ignorePatterns) {
    $trimmedPattern = $pattern.Trim()
    $found = $false
    foreach ($line in $existingContent) {
        if ($line.Trim() -eq $trimmedPattern) {
            $found = $true
            break
        }
    }
    if (-not $found) {
        Add-Content -Path $gitignorePath -Value $pattern
        Write-Host "  Added to .gitignore: $pattern"
        $addedAny = $true
    }
}

if (-not $addedAny) {
    Write-Host "  .gitignore is already up to date." -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "=============================================" -ForegroundColor Green
Write-Host "  Setup completed successfully!" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
Write-Host "Please reload your editor if needed to apply changes."
