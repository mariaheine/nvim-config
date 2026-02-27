return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")

    -- Map Ctrl+C in visual mode to copy to system clipboard
      vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
      
      -- Map Ctrl+X in visual mode to cut to system clipboard
      vim.keymap.set("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })

      wk.add({
        { "<leader>q", group = "Quit" },
        { "<leader>qq", "<cmd>wqa<CR>", desc = "Save all and quit" },
        { "<leader>qf", "<cmd>qa!<CR>", desc = "Force quit (no save)" },
        { "<leader>qs", "<cmd>wa<CR>", desc = "Save all files" },

        {}
      })
    end
}
