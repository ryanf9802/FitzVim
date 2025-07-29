#!/bin/bash

set -e

echo "Testing vendoring process locally..."

# Create a temporary directory for testing
TEST_DIR="/tmp/nvim-config-test"
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"

# Copy the current configuration
cp -r . "$TEST_DIR"
cd "$TEST_DIR"

echo "✓ Copied configuration to test directory: $TEST_DIR"

# Run the vendoring process
echo "Running vendor-plugins.sh..."
./scripts/vendor-plugins.sh

echo "Running create-vendored-config.sh..."
./scripts/create-vendored-config.sh

# Check if all expected files were created
echo "Checking vendored files..."

if [ ! -d "vendor/plugins" ]; then
    echo "❌ vendor/plugins directory not created"
    exit 1
fi

if [ ! -f "lua/lazy_setup_vendored.lua" ]; then
    echo "❌ lua/lazy_setup_vendored.lua not created"
    exit 1
fi

if [ ! -f "init_vendored.lua" ]; then
    echo "❌ init_vendored.lua not created"
    exit 1
fi

if [ ! -f "install.sh" ]; then
    echo "❌ install.sh not created"
    exit 1
fi

# Count vendored plugins
PLUGIN_COUNT=$(find vendor/plugins -maxdepth 1 -type d | wc -l)
PLUGIN_COUNT=$((PLUGIN_COUNT - 1))  # Subtract the vendor/plugins directory itself

echo "✓ Found $PLUGIN_COUNT vendored plugins in vendor/plugins/"

# List all vendored plugins
echo "Vendored plugins:"
find vendor/plugins -maxdepth 1 -type d -exec basename {} \; | grep -v "^plugins$" | sort

echo ""
echo "✓ Vendoring test completed successfully!"
echo "✓ Test directory: $TEST_DIR"
echo ""
echo "To clean up the test directory, run: rm -rf $TEST_DIR"