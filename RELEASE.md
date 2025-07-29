# Self-Contained Release System

This repository includes a GitHub Actions workflow that creates self-contained releases with all plugin dependencies vendored locally.

## How It Works

When you create a new GitHub release, the workflow automatically:

1. **Downloads all plugins** specified in `lazy-lock.json` at their exact commit hashes
2. **Vendors them locally** in a `vendor/plugins/` directory
3. **Creates modified configuration files** that use the local plugin copies instead of remote repositories
4. **Packages everything** into a self-contained archive
5. **Uploads the archive** as a release asset

## Creating a Release

1. **Tag your release:**
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. **Create the release on GitHub:**
   - Go to your repository's Releases page
   - Click "Create a new release"
   - Select your tag
   - Add release notes
   - Click "Publish release"

3. **Wait for the workflow:**
   - The GitHub Action will automatically run
   - It will upload a `nvim-config-v1.0.0.tar.gz` file to the release
   - The release description will be updated with installation instructions

## Testing Locally

Before creating a release, you can test the vendoring process locally:

```bash
./scripts/test-vendoring.sh
```

This will:
- Create a test directory with your configuration
- Run the vendoring process
- Verify all files are created correctly
- Show you which plugins were vendored

## What Gets Vendored

The system vendors all plugins from `lazy-lock.json`:
- Lazy.nvim itself
- All installed plugins at their exact commit hashes
- Creates local copies without `.git` directories

## Installation of Vendored Release

Users can install the self-contained release:

```bash
# Download and extract
wget https://github.com/yourusername/yourrepo/releases/download/v1.0.0/nvim-config-v1.0.0.tar.gz
tar -xzf nvim-config-v1.0.0.tar.gz

# Install
cd nvim-config-vendored
./install.sh
```

## Benefits

- **Offline Installation**: No internet required after download
- **Supply Chain Security**: All dependencies frozen at known-good commits
- **Reproducible**: Identical setup across machines
- **Resilient**: Works even if upstream repositories disappear

## File Structure

```
.github/workflows/release.yml    # GitHub Actions workflow
scripts/
├── vendor-plugins.sh           # Downloads and vendors all plugins
├── create-vendored-config.sh   # Creates modified configuration files
└── test-vendoring.sh           # Local testing script
.gitignore                      # Excludes vendor directory from repo
RELEASE.md                      # This documentation
```

## Maintenance

- The plugin URL mappings in `vendor-plugins.sh` need to be updated if you add new plugins
- Test the vendoring process locally before creating releases
- Consider updating the workflow if you change your plugin management approach