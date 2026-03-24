# Configuration Files Repository

This repository contains my personal configuration files for various development tools and applications.

## 📁 Repository Structure

```
.
├── nvim/                    # Neovim configuration
│   ├── init.lua            # Main entry point
│   ├── lazy-lock.json      # Plugin lock file
│   ├── lua/
│   │   ├── core/           # Core Neovim settings
│   │   │   ├── config.lua  # Basic editor settings
│   │   │   ├── mappings.lua # Key mappings
│   │   │   └── hooks.lua   # Custom hooks
│   │   ├── config/         # Plugin configurations
│   │   │   ├── lazy.lua    # Plugin manager setup
│   │   │   ├── mason.lua   # LSP installer
│   │   │   └── ...         # Other plugin configs
│   │   ├── plugins/        # Plugin definitions
│   │   └── lsp/            # Language server configurations
│   └── lsp/                # LSP overrides
├── kitty.conf              # Kitty terminal configuration
└── zsh/
    └── zshrc               # Zsh shell configuration
```

## 🔧 Configuration Files

### Neovim Configuration

A modern Neovim setup written in Lua with lazy.nvim as the plugin manager.

**Key Features:**
- **Plugin Manager**: Lazy.nvim for efficient plugin management
- **LSP Support**: Mason.nvim for automatic LSP installation
- **Theme**: Catppuccin color scheme
- **File Explorer**: None (using built-in netrw or telescope)
- **Fuzzy Finder**: Telescope for file search and navigation
- **Status Line**: Lualine
- **Treesitter**: Syntax highlighting and parsing
- **Debugging**: nvim-dap for debugging support
- **Code Comments**: nvim-comment for easy commenting
- **Indent Guides**: indent-blankline.nvim
- **TODO Comments**: todo-comments.nvim

**Setup:**
```bash
# Clone this repository and symlink the nvim directory
ln -s /path/to/dump/nvim ~/.config/nvim
```

### Kitty Terminal

Kitty terminal emulator configuration with Fira Code font.

**Configuration:**
- **Font**: Fira Code at 14px
- **Theme**: Built-in (can be customized)

**Setup:**
```bash
# Symlink kitty configuration
ln -s /path/to/dump/kitty.conf ~/.config/kitty/kitty.conf
```

### Zsh Shell

Zsh configuration with oh-my-zsh framework.

**Features:**
- **Theme**: Agnoster theme
- **Framework**: oh-my-zsh
- **Plugins**: Various oh-my-zsh plugins
- **Customization**: User-specific settings and aliases

**Setup:**
```bash
# Symlink zsh configuration
ln -s /path/to/dump/zsh/zshrc ~/.zshrc
```

## 🚀 Getting Started

1. Clone this repository:
   ```bash
   git clone <repository-url> ~/.dotfiles
   ```

2. Install and symlink configurations as needed:
   ```bash
   # For Neovim
   mkdir -p ~/.config
   ln -s ~/.dotfiles/nvim ~/.config/nvim
   
   # For Kitty
   mkdir -p ~/.config/kitty
   ln -s ~/.dotfiles/kitty.conf ~/.config/kitty/kitty.conf
   
   # For Zsh
   ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
   ```

3. Install Neovim plugins:
   ```bash
   nvim --headless "+Lazy! sync" +qa
   ```

## 📦 Dependencies

**Neovim:**
- Neovim 0.9+ with Lua support
- Git (for plugin management)
- Node.js/npm (for some LSP servers)
- Python (optional, for some plugins)

**Terminal:**
- Kitty terminal emulator

**Shell:**
- Zsh
- oh-my-zsh (optional but recommended)

## 🔄 Maintenance

- **Update plugins**: Run `:Lazy update` in Neovim
- **Add new LSP**: Add to `nvim/lua/config/mason.lua` in `ensure_installed`
- **Override LSP config**: Create file in `nvim/lua/lsp/` with LSP name (e.g., `lua_ls.lua`)
- **Add new plugin**: Add to `nvim/lua/plugins/` directory

## 📝 Notes

- This configuration is optimized for macOS but should work on Linux as well
- Font settings may need adjustment based on your system
- Some plugins may require additional system dependencies
- LSP configurations are automatically installed via Mason

## 🤝 Contributing

This is a personal configuration repository, but feel free to take inspiration or report issues.

## 📄 License

Personal use - feel free to adapt for your own needs.