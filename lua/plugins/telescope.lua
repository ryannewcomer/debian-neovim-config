return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
	      { "<leader>f", "<cmd>Telescope find_file<cr>", desc = "find file"},
	      { "<leader>t", "<cmd>Telescope live_grep<cr>", desc = "find text"},
	      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "find buffers"},
	      { "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent"}
      }
    }
