# ==============================
# Project: OneDrive Symlink Sync
# ==============================
# This PowerShell project creates and manages a symbolic link
# from a local folder to OneDrive so files sync automatically.

# ------------------------------
# File: sync-onedrive.ps1
# ------------------------------
<#[
.SYNOPSIS
Creates a symbolic link inside OneDrive pointing to a local folder.

.DESCRIPTION
Ensures a local folder stays in sync with OneDrive using a symbolic link.
Checks prerequisites, validates paths, and creates the link safely.

.PARAMETER OneDrivePath
Local OneDrive directory where the symlink will be created.

.PARAMETER TargetPath
Local folder to be synced (real folder).

.EXAMPLE
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\onedrive-symlink.ps1 -OneDrivePath "C:\\Users\\Kobi-\\OneDrive\\Data" -TargetPath "D:\\Data"
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$OneDrivePath,

    [Parameter(Mandatory = $true)]
    [string]$TargetPath
)

Write-Host "Starting OneDrive symlink setup..." -ForegroundColor Cyan

# Validate target folder
if (!(Test-Path $TargetPath)) {
    Write-Error "Target path does not exist: $TargetPath"
    exit 1
}

# Prevent overwrite
if (Test-Path $OneDrivePath) {
    Write-Error "OneDrive path already exists: $OneDrivePath"
    exit 1
}

try {
    New-Item -ItemType SymbolicLink -Path $OneDrivePath -Target $TargetPath -ErrorAction Stop
    Write-Host "Symlink created successfully!" -ForegroundColor Green
    Write-Host "OneDrive folder: $OneDrivePath"
    Write-Host "Target folder:   $TargetPath"
}
catch {
    Write-Error "Failed to create symlink. Run PowerShell as Administrator."
    Write-Error $_
    exit 1
}

# ------------------------------
# File: README.md
# ------------------------------
<#[
# OneDrive Symlink Sync (PowerShell)

This project enables automatic synchronization between a local folder
and OneDrive using a symbolic link.

## Why use this?
- No manual copying
- OneDrive syncs files automatically
- Works with existing folder structures

## Requirements
- Windows 10/11
- PowerShell 5.1+
- OneDrive desktop app installed and running
- Administrator privileges

## Usage
1. Open PowerShell as Administrator
2. Run:

   .\\sync-onedrive.ps1 -OneDrivePath "C:\\Users\\<You>\\OneDrive\\MyFolder" -TargetPath "D:\\MyData"

## Notes
- Always place the symlink *inside* OneDrive
- The target folder should be outside OneDrive
- Avoid symlink loops

## Result
Any changes made in either location will stay synced automatically.
#>
