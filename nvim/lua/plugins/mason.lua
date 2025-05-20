return {
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    init = function()
      local cmd = vim.api.nvim_create_user_command
      cmd(
        "MasonUpdateAll",
        function() require("utils.mason").update_all() end,
        { desc = "Update Mason Packages" }
      )
      cmd(
        "MasonUpdate",
        function(options) require("utils.mason").update(options.args) end,
        { nargs = 1, desc = "Update Mason Package" }
      )
    end,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      for _, plugin in ipairs { "mason-lspconfig", "mason-null-ls", "mason-nvim-dap" } do
        pcall(require, plugin)
      end
    end
  },
}
