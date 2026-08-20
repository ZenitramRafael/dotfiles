return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dX",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Clear All Breakpoints",
      },
    },
  },
}
