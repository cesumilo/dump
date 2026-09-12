# dotfiles

Personal configuration files for Neovim, Kitty, and Zsh. Optimized for macOS.

## Repository Structure

```
.
├── nvim/                          # Neovim configuration
│   ├── init.lua                   # Entry point: bootstraps lazy.nvim
│   ├── lazy-lock.json             # Locked plugin versions
│   ├── lsp/                       # LSP overrides (by LSP id)
│   │   └── lua_ls.lua             # lua-language-server override
│   └── lua/
│       ├── core/                  # Core editor settings
│       │   ├── config.lua         # Basic settings (indentation, theme, line numbers)
│       │   ├── mappings.lua       # Key mappings
│       │   └── hooks.lua          # Format-on-save + header autocmds
│       ├── config/                # Plugin configurations
│       │   ├── lazy.lua           # lazy.nvim bootstrap and setup
│       │   ├── mason.lua          # LSPs and tools installed via Mason
│       │   ├── dap.lua            # Debugging (Godot-Mono/C#, DAP UI, keymaps)
│       │   ├── header.lua         # File header generation
│       │   ├── incline.lua        # Bufferline-style status per buffer
│       │   ├── noice.lua          # UI overhaul (messages, cmdline, hover)
│       │   ├── nvim-comment.lua   # Comment toggling
│       │   ├── telescope-ui-select.lua
│       │   ├── treesitter-context.lua
│       │   └── markdown-preview.lua
│       ├── plugins/               # Plugin definitions
│       │   ├── blink.lua          # Completion (super-tab, ghost text)
│       │   ├── catppuccin.lua     # Color scheme
│       │   ├── dap.lua            # nvim-dap + dap-ui + netcoredbg
│       │   ├── dart.lua           # Dart syntax support
│       │   ├── header.lua
│       │   ├── incline.lua
│       │   ├── indent-blankline.lua
│       │   ├── lualine.lua        # Status line
│       │   ├── markdown-preview.lua
│       │   ├── neoformat.lua      # Formatting
│       │   ├── noice.lua
│       │   ├── nvim-comment.lua
│       │   ├── telescope.lua      # Fuzzy finder
│       │   ├── telescope-ui-select.lua
│       │   ├── todo-comments.lua
│       │   ├── treesitter.lua
│       │   ├── treesitter-context.lua
│       │   ├── which-key.lua
│       │   ├── lsp/
│       │   │   ├── mason.lua      # lspconfig + Omnisharp + GDScript LSP
│       │   │   └── flutter.lua    # flutter-tools + Dart debugger config
│       └── lsp/                   # Custom LSP client configs
│           ├── denols.lua         # Deno LSP (deno: virtual text documents)
│           ├── lua_ls.lua
│           └── ts_ls.lua          # TypeScript LSP (references, source actions)
├── kitty.conf                     # Kitty terminal configuration
└── zsh/
    └── zshrc                      # Zsh configuration (oh-my-zsh)
```

## Neovim

A modern Neovim setup written in Lua, managed with lazy.nvim.

**Key plugins:**
- **Plugin manager**: lazy.nvim with automatic update checks
- **Completion**: blink.cmp (super-tab keymap, ghost text, signature help)
- **LSP**: nvim-lspconfig + Mason; servers auto-installed via `mason-lspconfig` (lua_ls, denols, ts_ls, terraformls, pyright, rust_analyzer, omnisharp) and tools via `mason-tool-installer` (codelldb, cpptools, pylint, black, stylua, netcoredbg)
- **Custom LSP configs**: Deno (`deno:` virtual documents), TypeScript (references + source actions), OmniSharp (C#), GDScript (Godot editor on port 6005)
- **Theme**: Catppuccin
- **Fuzzy finder**: Telescope with ui-select extension
- **Status line**: Lualine + Incline (per-buffer status)
- **UI**: Noice (messages/cmdline/hover), which-key
- **Treesitter**: with treesitter-context
- **Formatting**: Neoformat (format-on-save for ts, rs, py, js, json, yaml, lua, sql, tf, dart)
- **Debugging**: nvim-dap with dap-ui; Godot-Mono launch (netcoredbg) and Dart/Flutter debugger via flutter-tools
- **Comments**: nvim-comment; **TODO comments**: todo-comments
- **Indent guides**: indent-blankline
- **File headers**: header.nvim (auto-updated `date_modified`)
- **Markdown**: markdown-preview.nvim
- **Dart/Flutter**: dart-vim-plugin + flutter-tools
- **File explorer**: none (netrw built-in)

**Setup:**
```bash
ln -s /path/to/dump/nvim ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

## Kitty

Minimal Kitty terminal configuration:

- **Font**: Fira Code at 14px

```bash
ln -s /path/to/dump/kitty.conf ~/.config/kitty/kitty.conf
```

## Zsh

oh-my-zsh-based configuration:

- **Theme**: Agnoster with a `prompt_end` override (prompt on a new line)
- **Plugins**: git
- **Aliases**: `gitcl` (prune merged branches), `dotenv` / `udotenv` (load/unload `.env`)
- **Path**: custom `~/.bin`, Neovim binary, `XDG_CONFIG_HOME`
- **nvim**: `vi` and `vim` aliased to `nvim`
- **Integration**: loads Fig's pre-script if present; `DEFAULT_USER` hides the hostname in the prompt

```bash
ln -s /path/to/dump/zsh/zshrc ~/.zshrc
```

## Getting Started

```bash
git clone git@github.com:cesumilo/dump.git ~/.dotfiles

mkdir -p ~/.config/nvim ~/.config/kitty
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc

nvim --headless "+Lazy! sync" +qa
```

## Dependencies

- Neovim 0.12+ with Lua support (uses `vim.lsp.config` / `vim.lsp.enable` APIs)
- Git (plugin management)
- Node.js/npm (some LSP servers; markdown-preview build)
- Deno (denols LSP)
- Rust (rust_analyzer)
- Godot Mono + netcoredbg (C#/Godot debugging)
- Flutter SDK (flutter-tools)
- Kitty, Zsh, oh-my-zsh

## Maintenance

- **Update plugins**: `:Lazy update` in Neovim
- **Add an LSP**: add it to `ensure_installed` in `nvim/lua/config/mason.lua`
- **Override LSP config**: create `nvim/lua/lsp/<lsp_id>.lua` and require it from `nvim/init.lua`
- **Add a plugin**: add a file to `nvim/lua/plugins/` (or `plugins/lsp/`)

## Notes

- Optimized for macOS; may require adjustments on Linux
- LSP servers and debuggers are installed automatically via Mason
- Font settings may need adjustment per system
