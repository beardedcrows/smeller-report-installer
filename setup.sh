#!/bin/bash

echo ""
echo "🔐 Smeller Report Generator Installer"
echo "--------------------------------------"
echo "Enter your access code:"
read -r ACCESS_CODE

# 🔒 Replace this with your secret
if [[ "$ACCESS_CODE" != "Smeller123" ]]; then
    echo "❌ Invalid access code. Please contact the admin."
    exit 1
fi

echo "✅ Access granted."

# Install Homebrew if missing
if ! command -v brew &> /dev/null; then
    echo "🛠️ Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew installation failed. Please install manually from https://brew.sh"
        exit 1
    fi
fi

# Tap your public Homebrew formula repo
echo "📦 Tapping Homebrew repo..."
brew tap beardedcrows/smeller-report https://github.com/beardedcrows/homebrew-smeller-report.git --force-auto-update

# Install the CLI tool
echo "⬇️ Installing Smeller Report Generator..."
brew install smeller-report-generator

echo ""
echo "🎉 Done! You can now run: Smeller-Report-Generator"
