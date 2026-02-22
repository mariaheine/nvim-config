local vim = vim

-- __                                    
--/\ \                                   
--\ \ \         __     ____    __  __    
-- \ \ \  __  /'__`\  /\_ ,`\ /\ \/\ \   
--  \ \ \L\ \/\ \L\.\_\/_/  /_\ \ \_\ \  
--   \ \____/\ \__/.\_\ /\____\\/`____ \ 
--    \/___/  \/__/\/_/ \/____/ `/___/> \
--                                 /\___/
--                                 \/__/
-- this means it loads a config located at ./config/lazy.lua
-- that config on the other hand loads plugins from ./plugins/asd.lua etc.
-- theme is a package, it is being set in ./config/lazy.lua
require("config.lazy")

-- ________  ________  ________  ___  ________  ________      
--|\   __  \|\   __  \|\   ____\|\  \|\   ____\|\   ____\     
--\ \  \|\ /\ \  \|\  \ \  \___|\ \  \ \  \___|\ \  \___|_    
-- \ \   __  \ \   __  \ \_____  \ \  \ \  \    \ \_____  \   
--  \ \  \|\  \ \  \ \  \|____|\  \ \  \ \  \____\|____|\  \  
--   \ \_______\ \__\ \__\____\_\  \ \__\ \_______\____\_\  \ 
--    \|_______|\|__|\|__|\_________\|__|\|_______|\_________\
--                       \|_________|             \|_________|
vim.opt.number=true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.clipboard = unnamedplus

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- ________   ________  ___      ___ ___  ________  ________  _________  ___  ________  ________      
--|\   ___  \|\   __  \|\  \    /  /|\  \|\   ____\|\   __  \|\___   ___\\  \|\   __  \|\   ___  \    
--\ \  \\ \  \ \  \|\  \ \  \  /  / | \  \ \  \___|\ \  \|\  \|___ \  \_\ \  \ \  \|\  \ \  \\ \  \   
-- \ \  \\ \  \ \   __  \ \  \/  / / \ \  \ \  \  __\ \   __  \   \ \  \ \ \  \ \  \\\  \ \  \\ \  \  
--  \ \  \\ \  \ \  \ \  \ \    / /   \ \  \ \  \|\  \ \  \ \  \   \ \  \ \ \  \ \  \\\  \ \  \\ \  \ 
--   \ \__\\ \__\ \__\ \__\ \__/ /     \ \__\ \_______\ \__\ \__\   \ \__\ \ \__\ \_______\ \__\\ \__\
--    \|__| \|__|\|__|\|__|\|__|/       \|__|\|_______|\|__|\|__|    \|__|  \|__|\|_______|\|__| \|__|
-- Splits navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move right' })

-- Tab navigation
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tp', ':tabprev<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tf', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })

-- _________  _______   ________  _____ ______   ___  ________   ________  ___          
--|\___   ___\\  ___ \ |\   __  \|\   _ \  _   \|\  \|\   ___  \|\   __  \|\  \         
--\|___ \  \_\ \   __/|\ \  \|\  \ \  \\\__\ \  \ \  \ \  \\ \  \ \  \|\  \ \  \        
--     \ \  \ \ \  \_|/_\ \   _  _\ \  \\|__| \  \ \  \ \  \\ \  \ \   __  \ \  \       
--      \ \  \ \ \  \_|\ \ \  \\  \\ \  \    \ \  \ \  \ \  \\ \  \ \  \ \  \ \  \____  
--       \ \__\ \ \_______\ \__\\ _\\ \__\    \ \__\ \__\ \__\\ \__\ \__\ \__\ \_______\
--        \|__|  \|_______|\|__|\|__|\|__|     \|__|\|__|\|__| \|__|\|__|\|__|\|_______|
--
-- Track our terminal window
local terminal_win = nil

-- Toggle function
local function toggle_terminal()
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    -- Terminal is open → CLOSE it
    vim.api.nvim_win_close(terminal_win, true)
    terminal_win = nil
  else
    -- Terminal is closed → OPEN it
    vim.cmd('below 15split term://bash')
    terminal_win = vim.api.nvim_get_current_win()
    vim.cmd('startinsert')  -- Go into insert mode automatically
  end
end

-- Map Ctrl+` to toggle (works from both normal and terminal mode)
vim.keymap.set({'n', 't'}, '<leader>`', toggle_terminal, { desc = "Toggle terminal" })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" })
