#!/bin/bash

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# install vscode extensions ...
# python, ruff, isort, jupyter, gitlens, github copilot, even better TOML

# git settings
## Define colors for better output
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"  # No Color

echo -e "${YELLOW}Updating system and installing Git...${NC}"
## Install Git (for Debian/Ubuntu)
if ! command -v git &> /dev/null; then
    sudo apt update && sudo apt install -y git
    echo -e "${GREEN}Git installed successfully!${NC}"
else
    echo -e "${GREEN}Git is already installed.${NC}"
fi

# Prompt for GitHub username and email
read -p "Enter your GitHub username: " GITHUB_USER
read -p "Enter your GitHub email: " GITHUB_EMAIL

## Set Git global configuration
git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"

echo -e "${GREEN}Git username and email set successfully!${NC}"

# Check if SSH key already exists
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
    echo -e "${YELLOW}Generating a new SSH key...${NC}"
    ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f "$SSH_KEY" -N ""
    echo -e "${GREEN}SSH key generated successfully!${NC}"
else
    echo -e "${GREEN}SSH key already exists.${NC}"
fi

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# Show the public key
echo -e "${YELLOW}Copy the following SSH key and add it to your GitHub account:${NC}"
echo -e "${GREEN}================================${NC}"
cat "$SSH_KEY.pub"
echo -e "${GREEN}================================${NC}"

echo -e "${YELLOW}Follow these steps to add the key to GitHub:${NC}"
echo -e "1. Go to https://github.com/settings/keys"
echo -e "2. Click 'New SSH key'"
echo -e "3. Paste the above key and save it."
echo -e "4. Test the connection by running: ${GREEN}ssh -T git@github.com${NC}"