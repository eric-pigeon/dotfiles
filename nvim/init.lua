for _, source in ipairs {
  "options",
  "lazyconfig",
  "autocmds",
  "mappings",
} do
  require(source)
end

vim.cmd.colorscheme "catppuccin"
vim.o.foldexpr = "v:lua.require'folding'.foldexpr()" -- set function for calculating folds
