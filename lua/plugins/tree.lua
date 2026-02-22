return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup()
      -- disable netrw at the very start of your init.lua (strongly advised)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- optionally enable 24-bit colour
      vim.opt.termguicolors = true

      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      
      -- Toggle file explorer
      keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
      
      -- Focus file explorer (move cursor to it)
      keymap('n', '<Leader>E', ':NvimTreeFocus<CR>', { desc = 'Focus file explorer' })
      
      -- Find current file in tree
      keymap('n', '<Leader>fe', ':NvimTreeFindFile<CR>', { desc = 'Find file in explorer' })
  end,
}
