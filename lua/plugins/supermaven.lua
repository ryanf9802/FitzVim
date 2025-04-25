return {
	"supermaven-inc/supermaven-nvim",
  enabled = false,
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},

			log_level = "info",
			disable_inline_completion = false,
			disable_keymaps = false,

			condition = function()
				-- This condition is used to check for stopping supermaven, return true when it should be stopped
				return false
			end,
		})
	end,
}
