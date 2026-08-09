return {
  "nvim-neo-tree/neo-tree.nvim",
  -- only load when actually invoked, so it doesn't start alongside Snacks
  -- explorer (bound to <leader>e) on every startup
  cmd = "Neotree",
  keys = {
    { "<leader>E", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree (toggle)" },
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false, -- show .gitignore, .env, etc.
        hide_gitignored = false, -- also show files git would normally ignore
      },
    },
  },
}
