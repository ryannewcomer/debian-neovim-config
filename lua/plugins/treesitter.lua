return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
	    require'nvim-treesitter.configs'.setup{
		    ensure_install = { "lua", "markdown"}
	    }
    end
}
