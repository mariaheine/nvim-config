return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "basedpyright",
      },
      automatic_installation = true,
    },
  },
  {
    "onsails/lspkind.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- LSP completion source (connects to basedpyright)
      "hrsh7th/cmp-nvim-lsp",
      -- Snippet engine (required for LSP snippets)
      "L3MON4D3/LuaSnip",
      -- Source for file system paths
      "hrsh7th/cmp-path",
      -- Source for buffer words
      "hrsh7th/cmp-buffer",
      -- VS Code-like snippets
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      -- Load VS Code snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Navigate between completion items
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          -- Scroll documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          -- Complete
          ['<C-Space>'] = cmp.mapping.complete(),
          -- Close completion window
          ['<C-e>'] = cmp.mapping.abort(),
          -- Tab to navigate snippets
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },      -- LSP (basedpyright)
          { name = 'path' },           -- File paths
        }, {
          { name = 'buffer' },         -- Words from current buffer
        }),
        -- Optional: Add icons for completion kinds
        formatting = {
          format = function(entry, vim_item)
            -- Add kind icons
            vim_item.kind = string.format('%s %s', 
              require('lspkind').symbolic(vim_item.kind), 
              vim_item.kind)
            return vim_item
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",  
    },
    config = function()

      -- see ":help lsp" for lots of interesting information

      local vim = vim
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Define server configurations
      vim.lsp.config["basedpyright"] = {
        cmd = { "basedpyright-langserver", "--stdio" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        filetypes = { "python" },
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              useLibraryCodeForTypes = true,
            },
          },
        },
        -- Enable inlay hints
        capabilities = capabilities, 
        -- Add keymaps when attaching
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        end,
      }
      
      -- Enable the server
      vim.lsp.enable("basedpyright")
    end,
  },
}
