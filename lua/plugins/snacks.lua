return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { enabled = true },
    bigfile = { enabled = true },
    git = { enabled = true },
    gitbrowse = {
      enabled = true,
      notify = false,
    },
    quickfile = {
      enabled = true,
    },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["o"] = "confirm",
                ["<cr>"] = "explorer_cd",
              },
            },
          },
        },
      },
    },
  },
  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>gb", function() Snacks.gitbrowse() end, desc = "Git Browse" },
  },
}
