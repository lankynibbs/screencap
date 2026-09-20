# Creates a Desktop shortcut that launches one-shot region capture.
# Run:  Right-click -> Run with PowerShell
#    or: powershell -ExecutionPolicy Bypass -File .\install-shortcut.ps1

$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$vbs  = Join-Path $here 'screencap.vbs'
if (-not (Test-Path $vbs)) {
    throw "screencap.vbs not found next to this script: $vbs"
}

$desktop = [Environment]::GetFolderPath('Desktop')
$lnkPath = Join-Path $desktop 'ScreenCap.lnk'

$wsh = New-Object -ComObject WScript.Shell
$lnk = $wsh.CreateShortcut($lnkPath)
$lnk.TargetPath = 'wscript.exe'
$lnk.Arguments  = '"' + $vbs + '"'
$lnk.WorkingDirectory = $here
$lnk.WindowStyle = 7  # minimized; wscript itself has no window
$lnk.Description = 'One-shot drag-to-select screen capture (clipboard)'

# Prefer Snipping Tool icon; fall back to shell32 camera-ish icon
$snip = Join-Path $env:WINDIR 'System32\SnippingTool.exe'
if (Test-Path $snip) {
    $lnk.IconLocation = $snip + ',0'
} else {
    $lnk.IconLocation = (Join-Path $env:WINDIR 'System32\shell32.dll') + ',14'
}

$lnk.Save()
Write-Host "Desktop shortcut created:" $lnkPath
Write-Host "Double-click it, then drag a rectangle. The snip is copied to the clipboard."
Write-Host "Paste with Ctrl+V. Esc cancels."
