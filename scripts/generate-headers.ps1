<#
.SYNOPSIS
Regenerates the profile's terminal SVG header.
.EXAMPLE
powershell -NoProfile -File .\scripts\generate-headers.ps1
.EXAMPLE
pwsh -NoProfile -File ./scripts/generate-headers.ps1 -OutputDirectory ./preview
#>
[CmdletBinding()]
param(
    [string]$OutputDirectory = (Join-Path (Split-Path -Parent $PSScriptRoot) 'assets')
)

$ErrorActionPreference = 'Stop'

# Edit the profile copy here. XML escaping below keeps punctuation safe.
# The character code preserves the accented name in Windows PowerShell 5.1.
$content = [ordered]@{
    Name        = ('Adri' + [char]0x00E1 + 'n Barrio')
    Keywords    = 'ENGINEERING / PEOPLE / COMMUNITY'
    Tagline     = 'Building software. Growing teams.'
    Location    = 'LA RIOJA, SPAIN'
    Description = 'Software engineering, team leadership, and community.'
}

$text = @{}
foreach ($entry in $content.GetEnumerator()) {
    $text[$entry.Key] = [System.Security.SecurityElement]::Escape($entry.Value)
}

$outputPath = [System.IO.Path]::GetFullPath($OutputDirectory)
[System.IO.Directory]::CreateDirectory($outputPath) | Out-Null
$encoding = New-Object System.Text.UTF8Encoding($false)

$terminalSvg = @"
<svg xmlns="http://www.w3.org/2000/svg" width="1120" height="300" viewBox="0 0 1120 300" fill="none" role="img" aria-labelledby="title description">
  <title id="title">$($text.Name)</title>
  <desc id="description">$($text.Description) A terminal window displaying the profile's name and focus.</desc>
  <rect x="0.5" y="0.5" width="1119" height="299" rx="12" fill="#0D1117" stroke="#30363D"/>
  <path d="M1 43H1119" stroke="#30363D"/>
  <circle cx="25" cy="22" r="5" fill="#D86B68"/>
  <circle cx="45" cy="22" r="5" fill="#D9B45C"/>
  <circle cx="65" cy="22" r="5" fill="#67B58B"/>
  <g font-family="Cascadia Code, Consolas, Liberation Mono, monospace">
    <text x="560" y="27" fill="#8B949E" font-size="13" text-anchor="middle">statickidz / profile.sh</text>
    <text x="40" y="87" fill="#8BC6B5" font-size="17">statickidz@github:~$ whoami</text>
    <text x="37" y="153" fill="#E6EDF3" font-size="58" font-weight="700" letter-spacing="-2">$($text.Name)</text>
    <text x="40" y="193" fill="#C9D1D9" font-size="22">$($text.Tagline)</text>
    <text x="40" y="235" fill="#8B949E" font-size="14" letter-spacing="1"># $($text.Keywords)</text>
    <text x="40" y="273" fill="#8BC6B5" font-size="17">$</text>
    <rect x="62" y="258" width="9" height="18" fill="#8BC6B5"/>
    <text x="1080" y="273" fill="#8B949E" font-size="12" letter-spacing="1" text-anchor="end">$($text.Location)</text>
  </g>
</svg>
"@
$terminalPath = Join-Path $outputPath 'header-terminal.svg'
[System.IO.File]::WriteAllText($terminalPath, ($terminalSvg.Replace("`r`n", "`n") + "`n"), $encoding)
Write-Output "Generated $terminalPath"
