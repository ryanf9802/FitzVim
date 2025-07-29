#!/bin/bash

set -e

echo "Creating vendored configuration files..."

# Create a vendored version of lazy_setup.lua
echo "Creating vendored lazy_setup.lua..."

cat > lua/lazy_setup_vendored.lua << 'EOF'
-- Vendored version of lazy_setup.lua that uses local plugin copies
local lazypath = vim.fn.stdpath("config") .. "/vendor/plugins/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  error("Vendored lazy.nvim not found at " .. lazypath .. ". This appears to be a development version.")
end

vim.opt.rtp:prepend(lazypath)

-- Load plugins from the vendored configuration
local plugins = require("plugins")

-- Transform plugin specs to use local paths
local function transform_plugin_spec(spec)
  if type(spec) == "string" then
    -- Convert "author/repo" to local path
    local plugin_name = spec:match("([^/]+)$")
    return {
      name = plugin_name,
      dir = vim.fn.stdpath("config") .. "/vendor/plugins/" .. plugin_name,
    }
  elseif type(spec) == "table" then
    local new_spec = {}
    for k, v in pairs(spec) do
      new_spec[k] = v
    end
    
    -- If it has a string as first element, it's a plugin spec
    if new_spec[1] and type(new_spec[1]) == "string" then
      local plugin_name = new_spec[1]:match("([^/]+)$")
      new_spec.dir = vim.fn.stdpath("config") .. "/vendor/plugins/" .. plugin_name
      new_spec[1] = nil -- Remove the original repo reference
      new_spec.name = plugin_name
    end
    
    return new_spec
  end
  
  return spec
end

-- Transform all plugin specs
local vendored_plugins = {}
for i, plugin in ipairs(plugins) do
  vendored_plugins[i] = transform_plugin_spec(plugin)
end

require("lazy").setup(vendored_plugins, {
  install = {
    -- Disable installing from remote since we're using vendored copies
    missing = false,
  },
  checker = {
    -- Disable update checking for vendored plugins
    enabled = false,
  },
  change_detection = {
    -- Disable change detection since we're using fixed versions
    enabled = false,
  },
})
EOF

# Create a vendored version of init.lua
echo "Creating vendored init.lua..."

# Read the current init.lua and modify it
cp init.lua init_vendored.lua

# Replace the lazy_setup require with the vendored version
sed -i 's/require("lazy_setup")/require("lazy_setup_vendored")/' init_vendored.lua

# Create a simple installation script
echo "Creating installation script..."

cat > install.sh << 'EOF'
#!/bin/bash

echo "Installing self-contained Neovim configuration..."

# Default installation path
NVIM_CONFIG_DIR="${HOME}/.config/nvim"

# Check if custom path is provided
if [ ! -z "$1" ]; then
    NVIM_CONFIG_DIR="$1"
fi

echo "Installation directory: $NVIM_CONFIG_DIR"

# Backup existing configuration if it exists
if [ -d "$NVIM_CONFIG_DIR" ]; then
    BACKUP_DIR="${NVIM_CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backing up existing configuration to: $BACKUP_DIR"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
fi

# Create the directory
mkdir -p "$NVIM_CONFIG_DIR"

# Copy all files except the development versions
cp -r . "$NVIM_CONFIG_DIR"

# Use the vendored versions
cd "$NVIM_CONFIG_DIR"
mv init_vendored.lua init.lua
rm -f lazy_setup.lua  # Remove the original non-vendored version

echo "✓ Self-contained Neovim configuration installed successfully!"
echo "✓ All plugins are included locally - no internet connection required"
echo ""
echo "You can now start Neovim. The configuration will use the vendored plugins."
echo ""
echo "Installation location: $NVIM_CONFIG_DIR"
EOF

chmod +x install.sh

# Create a README for the vendored version
cat > README_VENDORED.md << 'EOF'
# Self-Contained Neovim Configuration

This is a self-contained version of the Neovim configuration with all plugin dependencies vendored locally.

## Installation

### Quick Install
```bash
./install.sh
```

### Manual Install
1. Backup your existing Neovim configuration (if any)
2. Copy this entire directory to `~/.config/nvim`
3. Replace `init.lua` with `init_vendored.lua`:
   ```bash
   cd ~/.config/nvim
   mv init_vendored.lua init.lua
   ```

## What's Included

This release includes:
- All Lazy.nvim plugins vendored in `vendor/plugins/`
- Modified configuration to use local plugin copies
- No external dependencies required

## Features

- **Offline Installation**: No internet connection required after download
- **Supply Chain Security**: All dependencies are frozen at specific commits
- **Reproducible**: Identical setup across different machines
- **Self-Contained**: No external package managers or downloads needed

## Structure

```
.
├── init.lua                 # Main configuration (vendored version)
├── lua/
│   ├── core/               # Core Neovim settings
│   ├── plugins/            # Plugin configurations
│   ├── utils/              # Utility functions
│   └── lazy_setup_vendored.lua  # Vendored plugin loader
├── vendor/
│   └── plugins/            # All plugin dependencies (local copies)
├── lazy-lock.json          # Plugin version lock file
└── install.sh              # Installation script
```

## Original Repository

This vendored version was generated from: [Your Repository URL]

For the latest development version, visit the original repository.
EOF

echo "✓ Vendored configuration created successfully!"
echo "Files created:"
echo "  - lua/lazy_setup_vendored.lua (vendored plugin loader)"
echo "  - init_vendored.lua (vendored main config)"
echo "  - install.sh (installation script)"
echo "  - README_VENDORED.md (vendored version documentation)"