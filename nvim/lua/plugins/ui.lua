return {
  {
    "nvim-tree/nvim-web-devicons",
    enabled = vim.g.icons_enabled,
    opts = {
      override = {
        default_icon = { icon = require("utils").get_icon "DefaultFile" },
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
    },
  },
  {
    "onsails/lspkind.nvim",
    opts = {
      mode = "symbol",
      symbol_map = {
        Array = "󰅪",
        Boolean = "⊨",
        Class = "󰌗",
        Constructor = "",
        Key = "󰌆",
        Namespace = "󰅪",
        Null = "NULL",
        Number = "#",
        Object = "󰀚",
        Package = "󰏗",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "󰀬",
        TypeParameter = "󰊄",
        Unit = "",
      },
      menu = {},
    },
    config = require "plugins.configs.nvim-web-devicons",
  },
  {
    "rcarriga/nvim-notify",
    init = function() require("utils").load_plugin_with_func("nvim-notify", vim, "notify") end,
    opts = {
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 175 })
        if not vim.g.ui_notifications_enabled then vim.api.nvim_win_close(win, true) end
        if not package.loaded["nvim-treesitter"] then pcall(require, "nvim-treesitter") end
        vim.wo[win].conceallevel = 3
        local buf = vim.api.nvim_win_get_buf(win)
        if not pcall(vim.treesitter.start, buf, "markdown") then vim.bo[buf].syntax = "markdown" end
        vim.wo[win].spell = false
      end,
    },
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
