local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("highlight-yank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("LspAttach", {
	group = augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")

		map("gr", require("telescope.builtin").lsp_references, "Goto References")

		map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")

		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")

		map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.

		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = augroup("lsp-highlight", { clear = false })
			autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			autocmd("LspDetach", {
				group = augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle Inlay Hints")
		end
	end,
})

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint = require("lint")
autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = augroup("lint", { clear = true }),
	callback = function()
		-- Only run the linter in buffers that you can modify in order to
		-- avoid superfluous noise, notably within the handy LSP pop-ups that
		-- describe the hovered symbol using Markdown.
		if vim.opt_local.modifiable:get() then
			lint.try_lint()
		end
	end,
})
