#!/bin/bash

set -e

echo "Starting plugin vendoring process..."

# Check if lazy-lock.json exists
if [ ! -f "lazy-lock.json" ]; then
    echo "Error: lazy-lock.json not found!"
    exit 1
fi

# Create vendor directory
mkdir -p vendor/plugins

# Read the lazy-lock.json and download each plugin
echo "Reading lazy-lock.json..."

# Parse JSON and extract plugin information
jq -r 'to_entries[] | "\(.key) \(.value.commit) \(.value.branch // "main")"' lazy-lock.json | while read -r plugin_name commit branch; do
    echo "Processing plugin: $plugin_name"
    
    # Skip lazy.nvim itself as we'll handle it separately
    if [ "$plugin_name" = "lazy.nvim" ]; then
        echo "Skipping lazy.nvim (will be handled separately)"
        continue
    fi
    
    plugin_dir="vendor/plugins/$plugin_name"
    
    # Determine the repository URL
    # Most plugins follow the pattern: github.com/author/repo-name
    # We'll try to infer the URL, but this may need adjustment for some plugins
    case "$plugin_name" in
        "nvim-treesitter")
            repo_url="https://github.com/nvim-treesitter/nvim-treesitter.git"
            ;;
        "nvim-treesitter-textobjects")
            repo_url="https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git"
            ;;
        "nvim-lspconfig")
            repo_url="https://github.com/neovim/nvim-lspconfig.git"
            ;;
        "nvim-cmp")
            repo_url="https://github.com/hrsh7th/nvim-cmp.git"
            ;;
        "nvim-autopairs")
            repo_url="https://github.com/windwp/nvim-autopairs.git"
            ;;
        "nvim-web-devicons")
            repo_url="https://github.com/nvim-tree/nvim-web-devicons.git"
            ;;
        "nvim-ts-autotag")
            repo_url="https://github.com/windwp/nvim-ts-autotag.git"
            ;;
        "LuaSnip")
            repo_url="https://github.com/L3MON4D3/LuaSnip.git"
            ;;
        "Comment.nvim")
            repo_url="https://github.com/numToStr/Comment.nvim.git"
            ;;
        "mason.nvim")
            repo_url="https://github.com/williamboman/mason.nvim.git"
            ;;
        "mason-lspconfig.nvim")
            repo_url="https://github.com/williamboman/mason-lspconfig.nvim.git"
            ;;
        "mason-tool-installer.nvim")
            repo_url="https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim.git"
            ;;
        "conform.nvim")
            repo_url="https://github.com/stevearc/conform.nvim.git"
            ;;
        "fzf-lua")
            repo_url="https://github.com/ibhagwan/fzf-lua.git"
            ;;
        "lualine.nvim")
            repo_url="https://github.com/nvim-lualine/lualine.nvim.git"
            ;;
        "catppuccin")
            repo_url="https://github.com/catppuccin/nvim.git"
            ;;
        "schemastore.nvim")
            repo_url="https://github.com/b0o/schemastore.nvim.git"
            ;;
        "snacks.nvim")
            repo_url="https://github.com/folke/snacks.nvim.git"
            ;;
        "cmp-"*)
            # Handle nvim-cmp sources
            case "$plugin_name" in
                "cmp-nvim-lsp")
                    repo_url="https://github.com/hrsh7th/cmp-nvim-lsp.git"
                    ;;
                "cmp-buffer")
                    repo_url="https://github.com/hrsh7th/cmp-buffer.git"
                    ;;
                "cmp-path")
                    repo_url="https://github.com/hrsh7th/cmp-path.git"
                    ;;
                "cmp-cmdline")
                    repo_url="https://github.com/hrsh7th/cmp-cmdline.git"
                    ;;
                "cmp_luasnip")
                    repo_url="https://github.com/saadparwaiz1/cmp_luasnip.git"
                    ;;
                *)
                    echo "Warning: Unknown cmp plugin $plugin_name, skipping"
                    continue
                    ;;
            esac
            ;;
        *)
            echo "Warning: Unknown plugin $plugin_name, skipping"
            continue
            ;;
    esac
    
    echo "  Repository: $repo_url"
    echo "  Commit: $commit"
    echo "  Target: $plugin_dir"
    
    # Clone the repository
    if [ -d "$plugin_dir" ]; then
        echo "  Directory exists, removing..."
        rm -rf "$plugin_dir"
    fi
    
    echo "  Cloning repository..."
    git clone --quiet "$repo_url" "$plugin_dir"
    
    # Checkout the specific commit
    echo "  Checking out commit $commit..."
    cd "$plugin_dir"
    git checkout --quiet "$commit"
    
    # Remove .git directory to save space and avoid nested git repos
    rm -rf .git
    
    cd - > /dev/null
    
    echo "  ✓ Plugin $plugin_name vendored successfully"
done

# Also vendor lazy.nvim itself
echo "Vendoring lazy.nvim..."
lazy_commit=$(jq -r '.["lazy.nvim"].commit' lazy-lock.json)
lazy_dir="vendor/plugins/lazy.nvim"

if [ -d "$lazy_dir" ]; then
    rm -rf "$lazy_dir"
fi

git clone --quiet "https://github.com/folke/lazy.nvim.git" "$lazy_dir"
cd "$lazy_dir"
git checkout --quiet "$lazy_commit"
rm -rf .git
cd - > /dev/null

echo "✓ All plugins vendored successfully!"
echo "Vendored plugins are available in: vendor/plugins/"
