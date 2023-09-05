return function(_, opts)
  require("which-key").setup(opts)
  require("utils").which_key_register()
end
