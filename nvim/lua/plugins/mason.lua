return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = {
        "codelldb",
        "cpptools",
        "js-debug-adapter",
        "pyright",
        "pylint",
        "black",
        "csharpier",
        "netcoredbg",
        "omnisharp",
        "rust-analyzer",
        "csharpier",
        "jdtls",
        "kotlin-language-server",
        "sqlls",
        "terraform-ls"
      }
    end,
  }
}
