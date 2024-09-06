return {
	'nvimtools/none-ls.nvim',
	dependencies = 'nvim-lua/plenary.nvim',
	opts = function (_, opts)
		local nls = require('null-ls')

		 opts.sources = {
			nls.builtins.completion.luasnip,
			nls.builtins.diagnostics.fish,
			nls.builtins.formatting.fish_indent,
			nls.builtins.formatting.stylua
		}
	end
}
