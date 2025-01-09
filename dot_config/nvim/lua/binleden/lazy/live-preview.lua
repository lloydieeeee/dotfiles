return {
	"brianhuster/live-preview.nvim",
	dependencies = {
		-- "brianhuster/autosave.nvim", -- Not required, but recomended for autosaving and sync scrolling

		-- You can choose one of the following pickers
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("livepreview.config").set({
			port = 5500,
			autokill = false,
			browser = "default --private-window",
			dynamic_root = false,
			sync_scroll = false,
			picker = nil,
		})
	end,
}
