return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		'neovim/nvim-lspconfig',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp'
	},
	lazy = false,
	config = function()
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			mapping = {

	   ['<CR>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
		    if luasnip.expandable() then
			luasnip.expand()
		    else
			cmp.confirm({
			    select = true,
			})
		    end
		else
		    fallback()
		end
	    end),

	    ["<Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
		cmp.select_next_item()
	      elseif luasnip.locally_jumpable(1) then
		luasnip.jump(1)
	      else
		fallback()
	      end
	    end, { "i", "s" }),

	    ["<S-Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
		cmp.select_prev_item()
	      elseif luasnip.locally_jumpable(-1) then
		luasnip.jump(-1)
	      else
		fallback()
	      end
	    end, { "i", "s" }),

  },
  sources = cmp.config.sources({
	  { name = 'nvim_lsp' },
	  { name = 'luasnip' },
  },{
	  {name = 'buffer'},
  })
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['lua_ls'].setup {
	  capabilities = capabilities
  }
	end
  }
