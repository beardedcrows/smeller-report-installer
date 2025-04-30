#!/bin/bash

echo ""
echo "🔐 Smeller Report Generator Installer"
echo "--------------------------------------"
echo "Enter your access code:"
read -r ACCESS_CODE


SECRET_ENCODED="U21lbGxlcjEyMw=="
DECODED_SECRET=$(echo "$SECRET_ENCODED" | base64 --decode)

if [[ "$ACCESS_CODE" != "$DECODED_SECRET" ]]; then
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

# Tap the public Homebrew formula repo
echo "📦 Tapping Homebrew repo..."
brew tap beardedcrows/smeller-report https://github.com/beardedcrows/homebrew-smeller-report.git --force-auto-update

# Install the CLI tool
echo "⬇️ Installing Smeller Report Generator..."
brew install smeller-report-generator

# Copy to /Applications for Finder visibility
INSTALL_PATH="$(which Smeller-Report-Generator)"
if [[ -f "$INSTALL_PATH" ]]; then
    echo "🖥️ Copying to /Applications..."
    cp "$INSTALL_PATH" /Applications/Smeller-Report-Generator
    chmod +x /Applications/Smeller-Report-Generator
    echo "✅ Smeller Report Generator is also available in /Applications"
else
    echo "⚠️ Could not find installed binary to copy to /Applications."
fi

echo ""
echo "🎉 Installation complete!"
echo "📦 Run it from Terminal with: Smeller-Report-Generator"
echo "🖥️ Or double-click it in Finder via /Applications (opens in Terminal)"
