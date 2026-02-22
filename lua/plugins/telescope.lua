return {
  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 
		      'nvim-telescope/telescope-fzf-native.nvim',
		      build = 'make' 
	      },
    },
    config = function()

      local telescope = require('telescope')
      local actions = require("telescope.actions")

      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          defaults = {
            -- ignore noise
            file_ignore_patterns = { "node_modules", ".git/" },
            mappings = {
              i = {
                -- this was supposed to allow immediate close on esc key while in telescope insert mode
                -- ass following docs
                -- but it doesnt work for some reason
                ["<esc>"] = actions.close,
              },
            }
          },
          pickers = {
            find_files = {
              -- This is the key part: find hidden files and respect .gitignore
              hidden = true,
              find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
            },
          },
        }
      }
      
      -- Load the fzf extension
      telescope.load_extension('fzf')
      
      -- THEN add your keymaps (after telescope is loaded)
      -- pickers like find_files: https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#pickers
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<Leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<Leader>fg', builtin.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<Leader>fb', builtin.buffers, { desc = 'Find buffers' })
      vim.keymap.set('n', '<Leader>h', builtin.help_tags, { desc = 'Help tags' })
      -- you can use below pickers after
      -- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#pickers
    end,
  }
}
