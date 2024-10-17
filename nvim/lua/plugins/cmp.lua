-- Completion
return {
  {
    'hrsh7th/nvim-cmp',
    dependencies={
      { 'hrsh7th/cmp-nvim-lsp', lazy=true },
      { 'hrsh7th/cmp-buffer', lazy=true },
      { 'hrsh7th/cmp-path', lazy=true },
      { 'hrsh7th/cmp-cmdline', lazy=true },
    }
  }
}
