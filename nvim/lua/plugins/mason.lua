return {
  { "williamboman/mason.nvim", tag = "v1.11.0" },
  { "williamboman/mason-lspconfig.nvim", tag = "v1.32.0" },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = {
        "jdtls",
        "omnisharp",
        "pyright",
        "sqlls",
        "terraformls",
      }
    end,
  },
  "WhoIsSethDaniel/mason-tool-installer.nvim"
}
