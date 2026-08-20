return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        -- <leader>e explorer: keep dotfiles hidden by default (still
        -- toggleable with `H`), but never filter out gitignored files.
        explorer = {
          hidden = false,
          ignored = true,
        },
        -- <leader>ff files picker: show everything, no filtering at all.
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
