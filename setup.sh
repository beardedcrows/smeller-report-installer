#!/bin/bash

echo ""
echo "🔐 Smeller Report Generator Installer"
echo "--------------------------------------"
echo "Enter your access code:"
read -r ACCESS_CODE

# 🔒 Replace with your actual access code
if [[ "$ACCESS_CODE" != "Smeller123" ]]; then
    echo "❌ Invalid access code. Please contact the admin."
    exit 1
fi

echo "✅ Access granted."

# Install Homebrew if missing
if ! command -v brew &> /dev/null; then
    echo "🛠️ Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH (Apple Silicon fix)
    if [[ -d /opt/homebrew/bin ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zprofile
    fi

    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew installation failed. Please install it manually from https://brew.sh"
        exit 1
    fi
fi

# Install GitHub CLI if missing
if ! command -v gh &> /dev/null; then
    echo "📦 Installing GitHub CLI (gh)..."
    brew install gh
    if [[ $? -ne 0 ]]; then
        echo "❌ Failed to install GitHub CLI."
        exit 1
    fi
fi

# Authenticate GitHub if needed
gh auth status &> /dev/null
if [[ $? -ne 0 ]]; then
    echo "🔑 Logging in to GitHub..."
    gh auth login
fi

# Tap the private Homebrew repo
echo "📦 Tapping private Homebrew repo..."
brew tap beardedcrows/smeller-report git@github.com:beardedcrows/homebrew-smeller-report.git --force-auto-update

# Install the tool
echo "⬇️ Installing Smeller Report Generator..."
brew install smeller-report-generator

echo ""
echo "🎉 Installation complete! You can now run: Smeller-Report-Generator"
