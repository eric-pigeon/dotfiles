for _, source in ipairs {
  "options",
  "lazyconfig",
  "autocmds",
  "mappings",
} do
  require(source)
end

vim.cmd.colorscheme "catppuccin"
