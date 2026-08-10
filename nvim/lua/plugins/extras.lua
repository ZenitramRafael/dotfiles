-- Language support: LSP (go-to-definition/references, diagnostics),
-- autocomplete, and better syntax highlighting than plain Treesitter gives
-- you alone. Each `{ import = ... }` line pulls in one of LazyVim's
-- pre-built "extras" -- a bundle of the right LSP server(s), Treesitter
-- parser(s), formatter, and linter for that language.
return {
  -- Python: pyright (types/completion/go-to-def) + ruff (fast linting)
  { import = "lazyvim.plugins.extras.lang.python" },

  -- TypeScript, JavaScript, and React (.tsx/.jsx) -- all handled by the
  -- same extra, vtsls covers all four filetypes automatically.
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- SQL: go-to-def/completion for tables & columns via vim-dadbod once you
  -- set up a connection (<leader>D to open DBUI), plus sqlfluff for lint
  -- and format. sqlfluff needs to know which SQL *dialect* you mean --
  -- MS SQL Server is "tsql", Databricks is "databricks" -- set this per
  -- project with a `.sqlfluff` file in the project root:
  --   [sqlfluff]
  --   dialect = tsql
  -- otherwise it defaults to generic ANSI SQL.
  { import = "lazyvim.plugins.extras.lang.sql" },

  -- Markdown: marksman LSP (go-to-def on links/headings) + prettier format
  { import = "lazyvim.plugins.extras.lang.markdown" },

  -- C# / .NET: omnisharp LSP + csharpier formatter + netcoredbg debugger.
  -- Needs the .NET SDK installed separately (not a Homebrew formula on
  -- macOS -- see README/Brewfile note).
  { import = "lazyvim.plugins.extras.lang.dotnet" },

  -- JSON, with schema validation/autocomplete via SchemaStore (knows the
  -- shape of package.json, tsconfig.json, etc. automatically)
  { import = "lazyvim.plugins.extras.lang.json" },

  -- HTML and CSS: LazyVim doesn't ship a bundled extra for these, so wire
  -- the LSP servers up directly -- same pattern LazyVim's own extras use.
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
}
