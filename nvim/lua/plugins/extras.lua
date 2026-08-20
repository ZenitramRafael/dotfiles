-- LazyVim's own language extras (Python, TypeScript, SQL, Markdown,
-- C#/.NET, JSON) are imported directly in config/lazy.lua, in the position
-- LazyVim expects extras to load. This file only holds custom additions
-- LazyVim doesn't ship a bundled extra for.

return {
  -- HTML and CSS: wire the LSP servers up directly -- same pattern
  -- LazyVim's own extras use internally.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        cssls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "html", "css" } },
  },

  -- debugpy: the actual debug-adapter binary nvim-dap-python needs.
  -- nvim-dap-python/dap.core are enabled via extras in config/lazy.lua,
  -- but they only wire up the *client* side -- Mason still has to install
  -- this separately so `debugpy-adapter` exists on PATH.
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "debugpy" } },
  },
}
