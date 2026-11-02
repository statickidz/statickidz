# Profile header

`generate-headers.sh` generates the terminal banner at `assets/header-terminal.svg` used by the profile README.

Requires Bash and standard Unix utilities. Run on Linux, macOS, or Git Bash on Windows:

```bash
bash scripts/generate-headers.sh
```

Edit the profile variables at the top of the script to change the name, tagline, location, or keywords. The terminal palette and SVG layout are in the same script.

The default output directory is resolved relative to the script. To generate previews elsewhere:

```bash
bash scripts/generate-headers.sh --output-directory ./preview
```

Relative preview paths are resolved from the current working directory. Commit the generated SVG alongside changes to the script.

The PowerShell version, `generate-headers.ps1`, is also available:

Requires Windows PowerShell 5.1 or PowerShell 7. No extra dependencies.

From the repository root on Windows:

```powershell
powershell -NoProfile -File .\scripts\generate-headers.ps1
```

With PowerShell 7 on Windows, macOS, or Linux:

```powershell
pwsh -NoProfile -File ./scripts/generate-headers.ps1
```

Edit `$content` in the PowerShell script to change its profile copy.

The default output directory is resolved relative to the script. To generate previews elsewhere, pass `-OutputDirectory ./preview`. Commit the generated SVG alongside changes to the script.
