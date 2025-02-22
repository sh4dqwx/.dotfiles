return {
	{
		"jay-babu/mason-null-ls.nvim",
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua", -- Lua
					"prettier", -- JavaScript/TypeScript
					"eslint_d", -- JavaScript/TypeScript
					"rustfmt", -- Rust
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.completion.spell,
					null_ls.builtins.formatting.rustfmt,
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
