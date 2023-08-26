local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = {noremap = true, silent = true}

  buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
  buf_set_keymap('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
end

local on_attach_no_formatting = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = {noremap = true, silent = true}

  buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
  buf_set_keymap('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "creativenull/efmls-configs-nvim",
      {"folke/neoconf.nvim"},
      {"folke/neodev.nvim"}
    },
    event = {"BufReadPost", "BufNewFile"},
    config = function()
      -- Register linters and formatters per language
      local eslint = require('efmls-configs.linters.eslint')
      local prettier = require('efmls-configs.formatters.prettier')
      local lua_format = require('efmls-configs.formatters.lua_format')
      local languages = {
        typescript = {eslint, prettier},
        lua = {
          vim.tbl_extend("force", lua_format, {
            formatCommand = "lua-format -i --indent-width=2 --tab-width=2  --continuation-indent-width=2 --chop-down-table"
          })
        }
      }
      -- check doc/SUPPORTED_LIST.md for the supported languages

      local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {rootMarkers = {'.git/'}, languages = languages},
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true
        }
      }
      print("neoconf and dev init")
      require("neoconf").setup {}
      require("neodev").setup {}

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local lua_ls_opts = require('nvim-lazy.default.lsp-config.lua_ls')

      require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
        on_attach = on_attach,
        capabilities = capabilities
      }))
      require('lspconfig').lua_ls.setup(vim.tbl_extend('force', lua_ls_opts, {
        on_attach = on_attach_no_formatting,
        capabilities = capabilities
      }))
    end
  }, -- Add icons to diagnistic signs in gutter
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      local sign = function(hl, icon)
        vim.fn.sign_define(hl, {texthl = hl, text = icon, numhl = ''})
      end
      sign("DiagnosticSignError", "")
      sign("DiagnosticSignWarn", "")
      sign("DiagnosticSignHint", "")
      sign("DiagnosticSignInfo", "")
    end
  }, -- Nicer ui for LSP
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter"
    },
    event = "LspAttach",
    cmd = "Lspsaga",
    opts = {
      scroll_preview = {scroll_down = "<c-d>", scroll_up = "<c-u>"},
      ui = {border = "rounded"},
      code_action = {keys = {quit = {"q", "<esc>"}}},
      symbol_in_winbar = {respect_root = true}
    },
    keys = {
      {"gk", "<cmd>Lspsaga hover_doc<cr>", desc = "LSP hover"},
      {"gK", "<cmd>Lspsaga hover_doc ++keep<cr>", desc = "LSP hover (sticky)"},
      {
        "<leader>rn",
        "<cmd>Lspsaga rename ++project<cr>",
        desc = "Rename word under cursor"
      },
      {"<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code Actions"},
      {"gp", "<cmd>Lspsaga peek_definition<cr>", desc = "Peak definitions"},
      {"gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Peak definitions"},
      {
        "gy",
        "<cmd>Lspsaga peek_type_definition<cr>",
        desc = "Peek type definition"
      },
      {"gr", "<cmd>Lspsaga finder<cr>", desc = "Show references"},
      {"<leader>o", "<cmd>Lspsaga outline<cr>", desc = "Show outline"},
      {
        "[d",
        "<cmd>Lspsaga diagnostic_jump_prev<cr>",
        desc = "Goto previous diagnostic"
      },
      {
        "]d",
        "<cmd>Lspsaga diagnostic_jump_next<cr>",
        desc = "Goto next diagnostic"
      },
      {
        "[D",
        "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
        desc = "Goto previous diagnostic error"
      },
      {
        "]D",
        "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
        desc = "Goto next diagnostic error"
      },
      {
        "<leader>sl",
        "<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>",
        desc = "Show line diagnostics"
      }
    }
  }, -- Treesitter is needed by lspsaga for the hover action
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = "TSUpdate",
    lazy = true,
    opts = {
      -- markdown and markdown_inline are required by lspsaga
      ensure_installed = {"markdown", "markdown_inline"},
      sync_install = false,
      auto_install = true,
      highlight = {enable = false},
      indent = {enable = false}
    },
    main = "nvim-treesitter.configs"
  }, -- Keep track of diagnostics
  {
    "folke/trouble.nvim",
    cmd = {"TroubleToggle", "Trouble"},
    keys = {
      {"<leader>d", desc = "Diagnostics (Trouble)"},
      {
        "<leader>dw",
        "<cmd>Trouble workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics (Trouble)"
      },
      {
        "<leader>dd",
        "<cmd>Trouble document_diagnostics<cr>",
        desc = "Document Diagnostics (Trouble)"
      },
      {
        "<leader>dl",
        "<cmd>Trouble loclist<cr>",
        desc = "Location List (Trouble)"
      },
      {
        "<leader>dq",
        "<cmd>Trouble quickfix<cr>",
        desc = "Quickfix List (Trouble)"
      }
    }
  }
}
