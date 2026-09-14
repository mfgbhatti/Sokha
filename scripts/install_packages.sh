#!/usr/bin/env bash

set -euo pipefail

command -v npm >/dev/null 2>&1 || {
  echo "Error: npm is not installed / in path."
  exit 1
}

packages=(
  '@olrtg/emmet-language-server'
  'basedpyright'
  'bash-language-server'
  'prettier'
  'typescript'
  'typescript-language-server'
  'vscode-langservers-extracted'
  'yaml-language-server'
)

echo
npm install --global "${packages[@]}"
echo
echo "Installed:"
npm list --global --depth=0
