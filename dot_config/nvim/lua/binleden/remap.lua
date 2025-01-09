-- [[ bufferline ]]

vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "which_key_ignore" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "which_key_ignore" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "which_key_ignore" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "which_key_ignore" })

-- [[ cmp ]]

local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = { completeopt = "menu,menuone,noinsert" },

	mapping = cmp.mapping.preset.insert({
		-- Select the [n]ext item
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- Select the [p]revious item
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),

		-- Scroll the documentation window [b]ack / [f]orward
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Accept ([y]es) the completion.
		--  This will auto-import if your LSP supports it.
		--  This will expand snippets if the LSP sent a snippet.
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<Return>"] = cmp.mapping.confirm({ select = true }),

		-- Manually trigger a completion from nvim-cmp.
		--  Generally you don't need this, because nvim-cmp will display
		--  completions whenever it has completion options available.
		["<C-Space>"] = cmp.mapping.complete({}),

		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),
	sources = {
		{
			name = "lazydev",
			-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
			group_index = 0,
		},
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})

-- [[ conform ]]

-- stylua: ignore
vim.keymap.set("n", "<leader>cf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, { desc = "Format buffer" })


-- [[ flash ]]

-- stylua: ignore start 
vim.keymap.set({"n", "x", "o"}, "s", function() require('flash').jump() end, { desc = 'Flash' })
vim.keymap.set({"n", "x", "o"}, "S", function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
-- stylua: ignore end

-- [[ harpoon ]]

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- stylua: ignore start 
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon file" })
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon quick menu" })
-- stylua: ignore end

-- [[ neogit ]]

vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>", { desc = "Git status", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>", { desc = "Git commit", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gp", "<cmd>Neogit pull<CR>", { desc = "Git pull", silent = true, noremap = true })
vim.keymap.set("n", "<leader>gP", "<cmd>Neogit push<CR>", { desc = "Git push", silent = true, noremap = true })

-- [[ neo-tree ]]

-- stylua: ignore
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle<CR>", { desc = "Open file explorer", silent = true, noremap = true })

-- [[ snacks ]]

-- stylua: ignore start
vim.keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification history" })
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", function() Snacks.bufdelete.all() end, { desc = "Delete all buffers" })
vim.keymap.set("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git browse" })
vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git blame line" })
-- stylua: ignore end

-- [[ telescope ]]

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find word by grep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help guide" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find files/word resume" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "which_key_ignore" })
-- stylua: ignore
vim.keymap.set("n", "<leader>fc", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find neovim config" })

-- [[ vim tmux navigator ]]

vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "which_key_ignore" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "which_key_ignore" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "which_key_ignore" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "which_key_ignore" })
