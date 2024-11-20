-- (utils): merge arrays
function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end
function table.merge_list(t1, t2)
  for k,v in ipairs(t2) do
    table.insert(t1, v)
  end 
  
  return t1
end
function table.merge_list_unique(t1, t2)
  for k,v in ipairs(t2) do
    if not table.contains(t1, v) then
      table.insert(t1, v)
    end
  end 

  return t1
end

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
      }
    end,
  }
}
