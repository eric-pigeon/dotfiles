--- vim: foldmethod=marker

-- NeoTree {{{
vim.keymap.set("n", "<leader>nt", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
-- }}}

-- Telescope {{{
vim.keymap.set('n', '<space>f', function() require('telescope.builtin').find_files() end, { desc = "Find file" })
vim.keymap.set('n', '<space>l', function() require('telescope.builtin').current_buffer_fuzzy_find() end, { desc = "Find line" })
vim.keymap.set('n', '<space>b', function() require('telescope.builtin').buffers() end, { desc = "Find buffers", silent = true })
vim.keymap.set('n', '<space>s', function() require('telescope.builtin').live_grep() end, { desc = "Find words", silent = true})
vim.keymap.set('n', '<space><space>', function() require('telescope.builtin').resume() end, { desc = "Resume previou search", silent = true})

-- maps.n["<leader>f"] = sections.f
-- maps.n["<leader>g"] = sections.g
-- maps.n["<leader>gb"] = { function() require("telescope.builtin").git_branches() end, desc = "Git branches" }
-- maps.n["<leader>gc"] = { function() require("telescope.builtin").git_commits() end, desc = "Git commits" }
-- maps.n["<leader>gt"] = { function() require("telescope.builtin").git_status() end, desc = "Git status" }
-- maps.n["<leader>f<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
-- maps.n["<leader>f'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
-- maps.n["<leader>fa"] = {
--   function()
--     local cwd = vim.fn.stdpath "config" .. "/.."
--     local search_dirs = {}
--     for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
--       if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
--       if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
--     end
--     if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
--       utils.notify("No user configuration files found", "warn")
--     else
--       if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
--       require("telescope.builtin").find_files {
--         prompt_title = "Config Files",
--         search_dirs = search_dirs,
--         cwd = cwd,
--       } -- call telescope
--     end
--   end,
--   desc = "Find AstroNvim config files",
-- }
-- maps.n["<leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
-- maps.n["<leader>fc"] =
--   { function() require("telescope.builtin").grep_string() end, desc = "Find for word under cursor" }
-- maps.n["<leader>fC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
-- maps.n["<leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
-- maps.n["<leader>fF"] = {
--   function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
--   desc = "Find all files",
-- }
-- maps.n["<leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
-- maps.n["<leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
-- maps.n["<leader>fm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
-- if is_available "nvim-notify" then
--   maps.n["<leader>fn"] =
--     { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
-- end
-- maps.n["<leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
-- maps.n["<leader>fr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
-- maps.n["<leader>ft"] =
--   { function() require("telescope.builtin").colorscheme { enable_preview = true } end, desc = "Find themes" }
-- maps.n["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
-- maps.n["<leader>fW"] = {
--   function()
--     require("telescope.builtin").live_grep {
--       additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
--     }
--   end,
--   desc = "Find words in all files",
-- }
-- maps.n["<leader>l"] = sections.l
-- maps.n["<leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" }
-- maps.n["<leader>ls"] = {
--   function()
--     local aerial_avail, _ = pcall(require, "aerial")
--     if aerial_avail then
--       require("telescope").extensions.aerial.aerial()
--     else
--       require("telescope.builtin").lsp_document_symbols()
--     end
--   end,
--   desc = "Search symbols",
-- }
-- }}}

-- Folds {{{
-- tab to toggle foldes
vim.keymap.set('n', '<Tab>', [[@=(foldlevel('.')?'za':"]]..'<Tab>'..'")'..'<CR>')
-- " create fold with tab
vim.keymap.set('v', '<Tab>', 'zf')

-- Tabs {{{
vim.keymap.set('n', '<Leader>tt', ':tabnew'..'<cr>')
vim.keymap.set('n', '<Leader>te', ':tabedit')
vim.keymap.set('n', '<Leader>tc', ':tabclose'..'<cr>')
vim.keymap.set('n', '<Leader>to', ':tabonly'..'<cr>')
vim.keymap.set('n', '<Leader>tn', ':tabnext'..'<cr>')
vim.keymap.set('n', '<Leader>tp', ':tabprevious'..'<cr>')
vim.keymap.set('n', '<Leader>tf', ':tabfirst'..'<cr>')
vim.keymap.set('n', '<Leader>tl', ':tablast'..'<cr>')
vim.keymap.set('n', '<Leader>tm', ':tabmove')
-- }}}

-- Vim-Test {{{
vim.g['test#echo_command'] = 0
vim.keymap.set("n", "<Leader>rt", ":TestFile<CR>")
vim.keymap.set("n", "<Leader>rs", ":TestNearest<CR>")
vim.keymap.set("n", "<Leader>rl", ":TestLast<CR>")
vim.keymap.set("n", "<Leader>ra", ":TestSuite<CR>")
-- }}}

vim.keymap.set('n', '<leader>jt', '<Esc>:%!python3 -m json.tool<CR>')
