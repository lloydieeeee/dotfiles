return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		spec = {
			{ "<leader>f", group = "find/file" },
			{ "<leader>c", group = "code" },
			{ "<leader>g", group = "git" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>t", group = "toggle" },
			{ "<leader>h", group = "git hunk", mode = { "n", "v" } },
		},
	},
}
