#!/bin/bash

echo ""
echo "🔐 Smeller Report Generator Installer"
echo "--------------------------------------"
echo "Enter your access code:"
read -r ACCESS_CODE

# 🔒 Replace ABC123 with your secret code
if [[ "$ACCESS_CODE" != "Smeller123" ]]; then
    echo "❌ Invalid access code. Please contact the admin."
    exit 1
fi

echo "✅ Access granted."

# Check for GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed. Please install it first:"
    echo "   https://cli.github.com"
    exit 1
fi

# Authenticate GitHub (if needed)
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
