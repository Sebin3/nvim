local languages = { "c", "lua", "rust", "ruby", "vim", "html" }

local ok_configs, ts_configs = pcall(require, "nvim-treesitter.configs")
if ok_configs then
  ts_configs.setup({
    ensure_installed = languages,
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })
  return
end

local ok_ts, ts = pcall(require, "nvim-treesitter")
if not ok_ts then
  return
end

ts.setup({})

vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    pcall(vim.treesitter.start)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
