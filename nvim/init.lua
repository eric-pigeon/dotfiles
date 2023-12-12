for _, source in ipairs {
  "options",
  "lazyconfig",
  "autocmds",
  "mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

-- TODO
vim.fn['camelcasemotion#CreateMotionMappings']('<leader>')

-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- vim.cmd.colorscheme("onedark")
-- vim.cmd.colorscheme("tokyonight")
-- vim.cmd.colorscheme("astrodark")
vim.cmd.colorscheme "catppuccin"

-- vim.api.nvim_set_hl(0, "Normal", { ctermbg = "NONE" })
-- vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#1e222a" })
