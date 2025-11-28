# Generate Claude Code permissions for namespace isolation
# Properly handles existing settings files and merges configurations

$rootPath = $PSScriptRoot
Write-Host "Generating Claude Code permissions for subdirectories in: $rootPath" -ForegroundColor Cyan

$subdirs = Get-ChildItem -Path $rootPath -Directory | Where-Object {
    $_.Name -notlike ".*"
}

foreach ($dir in $subdirs) {
    $claudeDir = Join-Path $dir.FullName ".claude"
    $settingsLocalFile = Join-Path $claudeDir "settings.local.json"
    $settingsFile = Join-Path $claudeDir "settings.json"

    # Create .claude directory if needed
    if (-not (Test-Path $claudeDir)) {
        New-Item -Path $claudeDir -ItemType Directory -Force | Out-Null
    }

    # Check for existing settings.local.json (takes precedence)
    if (Test-Path $settingsLocalFile) {
        $targetFile = $settingsLocalFile
        $existing = Get-Content $targetFile -Raw | ConvertFrom-Json

        # Add additionalDirectories if not present
        if (-not $existing.permissions.additionalDirectories) {
            $existing.permissions | Add-Member -MemberType NoteProperty -Name "additionalDirectories" -Value @("../") -Force
        } elseif ($existing.permissions.additionalDirectories -notcontains "../") {
            $existing.permissions.additionalDirectories += "../"
        }

        $json = $existing | ConvertTo-Json -Depth 10
    } else {
        # Create new settings.json
        $targetFile = $settingsFile
        $json = @"
{
  "permissions": {
    "additionalDirectories": [
      "../"
    ]
  }
}
"@
    }

    # Write without BOM
    [System.IO.File]::WriteAllText($targetFile, $json)
    Write-Host "  Updated: $targetFile" -ForegroundColor Green
    Write-Host "    Namespace: $($dir.Name)/ (full access)" -ForegroundColor Gray
}

Write-Host "`nPermissions generation complete!" -ForegroundColor Cyan
