return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = { "stylua", "isort", "black", "prettierd" },
			automatic_installation = false,
			handlers = {},
		})

		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {
			buffer = 0,
		})

		require("null-ls").setup({})
	end,
}
