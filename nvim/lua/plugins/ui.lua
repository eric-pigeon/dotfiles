return {
  {
    "nvim-tree/nvim-web-devicons",
    enabled = vim.g.icons_enabled,
    opts = {
      deb = { icon = "", name = "Deb" },
      lock = { icon = "", name = "Lock" },
      mp3 = { icon = "", name = "Mp3" },
      mp4 = { icon = "", name = "Mp4" },
      out = { icon = "", name = "Out" },
      ["robots.txt"] = { icon = "ﮧ", name = "Robots" },
      ttf = { icon = "", name = "TrueTypeFont" },
      rpm = { icon = "", name = "Rpm" },
      woff = { icon = "", name = "WebOpenFontFormat" },
      woff2 = { icon = "", name = "WebOpenFontFormat2" },
      xz = { icon = "", name = "Xz" },
      zip = { icon = "", name = "Zip" },
    },
    config = require "plugins.configs.nvim-web-devicons",
  },
  {
    "rcarriga/nvim-notify",
    init = function() require("utils").load_plugin_with_func("nvim-notify", vim, "notify") end,
    opts = { on_open = function(win) vim.api.nvim_win_set_config(win, { zindex = 1000 }) end },
    config = require "plugins.configs.notify",
  },
  {
    "stevearc/dressing.nvim",
    init = function() require("utils").load_plugin_with_func("dressing.nvim", vim.ui, { "input", "select" }) end,
    opts = {
      input = {
        default_prompt = "➤ ",
        win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
      },
      select = {
        backend = { "telescope", "builtin" },
        builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
      },
    },
  },
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   event = "User AstroFile",
  --   cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
  --   opts = { user_default_options = { names = false } },
  -- },
}
