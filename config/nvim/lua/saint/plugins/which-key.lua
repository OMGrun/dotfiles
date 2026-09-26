return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- your config comes here
		-- you can also leave it empty and use the default settings.
		-- table of options that gets passed to the set up function 
	},
}
