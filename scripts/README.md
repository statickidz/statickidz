# Profile header

`generate-headers.ps1` generates the terminal banner at `assets/header-terminal.svg` used by the profile README.

Requires Windows PowerShell 5.1 or PowerShell 7. No extra dependencies.

From the repository root on Windows:

```powershell
powershell -NoProfile -File .\scripts\generate-headers.ps1
```

With PowerShell 7 on Windows, macOS, or Linux:

```powershell
pwsh -NoProfile -File ./scripts/generate-headers.ps1
```

Edit `$content` to change the name, tagline, location, or keywords. The terminal palette and SVG layout are in the same script.

The default output directory is resolved relative to the script. To generate previews elsewhere, pass `-OutputDirectory ./preview`. Commit the generated SVG alongside changes to the script.
