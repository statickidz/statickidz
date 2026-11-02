#!/usr/bin/env bash
set -euo pipefail

# Edit the profile copy here. XML escaping below keeps punctuation safe.
name='Adrián Barrio'
keywords='ENGINEERING / PEOPLE / COMMUNITY'
tagline='Building software. Growing teams.'
location='LA RIOJA, SPAIN'
description='Software engineering, team leadership, and community.'

usage() {
    printf 'Usage: bash %s [--output-directory DIRECTORY]\n' "${0##*/}"
}

script_directory=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
output_directory="$script_directory/../assets"

while (($#)); do
    case "$1" in
        --output-directory)
            if (($# < 2)) || [[ -z $2 ]]; then
                printf 'Error: --output-directory requires a directory.\n' >&2
                exit 1
            fi
            output_directory=$2
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            printf 'Error: unknown argument: %s\n' "$1" >&2
            usage >&2
            exit 1
            ;;
    esac
done

xml_escape() {
    local value=$1
    value=${value//&/\&amp;}
    value=${value//</\&lt;}
    value=${value//>/\&gt;}
    value=${value//\"/\&quot;}
    value=${value//\'/\&apos;}
    printf '%s' "$value"
}

name=$(xml_escape "$name")
keywords=$(xml_escape "$keywords")
tagline=$(xml_escape "$tagline")
location=$(xml_escape "$location")
description=$(xml_escape "$description")

mkdir -p -- "$output_directory"
output_directory=$(cd -- "$output_directory" && pwd)
terminal_path="$output_directory/header-terminal.svg"

cat > "$terminal_path" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="1120" height="300" viewBox="0 0 1120 300" fill="none" role="img" aria-labelledby="title description">
  <title id="title">${name}</title>
  <desc id="description">${description} A terminal window displaying the profile's name and focus.</desc>
  <rect x="0.5" y="0.5" width="1119" height="299" rx="12" fill="#0D1117" stroke="#30363D"/>
  <path d="M1 43H1119" stroke="#30363D"/>
  <circle cx="25" cy="22" r="5" fill="#D86B68"/>
  <circle cx="45" cy="22" r="5" fill="#D9B45C"/>
  <circle cx="65" cy="22" r="5" fill="#67B58B"/>
  <g font-family="Cascadia Code, Consolas, Liberation Mono, monospace">
    <text x="560" y="27" fill="#8B949E" font-size="13" text-anchor="middle">statickidz / profile.sh</text>
    <text x="40" y="87" fill="#8BC6B5" font-size="17">statickidz@github:~\$ whoami</text>
    <text x="37" y="153" fill="#E6EDF3" font-size="58" font-weight="700" letter-spacing="-2">${name}</text>
    <text x="40" y="193" fill="#C9D1D9" font-size="22">${tagline}</text>
    <text x="40" y="235" fill="#8B949E" font-size="14" letter-spacing="1"># ${keywords}</text>
    <text x="40" y="273" fill="#8BC6B5" font-size="17">\$</text>
    <rect x="62" y="258" width="9" height="18" fill="#8BC6B5"/>
    <text x="1080" y="273" fill="#8B949E" font-size="12" letter-spacing="1" text-anchor="end">${location}</text>
  </g>
</svg>
EOF

printf 'Generated %s\n' "$terminal_path"
