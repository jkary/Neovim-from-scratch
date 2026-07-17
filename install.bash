#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config_home="${XDG_CONFIG_HOME:-"${HOME}/.config"}"
nvim_config="${config_home}/nvim"

mkdir -p "${config_home}"

if [ -e "${nvim_config}" ] && [ ! -L "${nvim_config}" ]; then
  backup="${nvim_config}.backup.$(date +%Y%m%d%H%M%S)"
  echo "Moving existing config to ${backup}"
  mv "${nvim_config}" "${backup}"
fi

if [ -L "${nvim_config}" ]; then
  rm "${nvim_config}"
fi

ln -s "${repo_dir}" "${nvim_config}"

echo "Installing plugins in headless mode."
nvim --headless "+Lazy! sync" +qa
