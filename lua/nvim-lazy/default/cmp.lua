return {
  -- Add icons to completion window
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    event = "InsertEnter",
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and
                 vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                            col)
                   :match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      return vim.tbl_deep_extend("force", opts, {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert({
          -- If nothing is selected, add a newline.
          -- If something is explicitly selected, select it.
          ["<cr>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false
                })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({select = true}),
            c = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false
            })
          }),
          -- Select with <down> and <up>, and if no entry is selected, will confirm the first item
          ["<down>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
            else
              fallback()
            end
          end),
          ["<up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
            else
              fallback()
            end
          end),
          ["<c-u>"] = cmp.mapping.scroll_docs(-4),
          ["<c-d>"] = cmp.mapping.scroll_docs(4),
          -- Navigate snippets with <tab> and <s-tab>
          ["<tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.jump(1)
            elseif cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {"i", "s"}),
          ["<s-tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {"i", "s"})
        }),
        sources = {
          {name = "nvim_lsp"},
          {name = "nvim_lsp_signature_help"},
          {name = "luasnip"},
          {name = "buffer"},
          {name = "path"}
        },
        formatting = {
          format = {
            menu = {
              nvim_lsp = "(LSP)",
              nvim_lsp_signature_help = "󰊕",
              luasnip = "(LuaSnip)",
              buffer = "(Buffer)",
              path = "(Path)"
            }
          }
        },
        experimental = {ghost_text = true}
      })
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      local format_menu = opts.formatting.format.menu
      cmp.setup(vim.tbl_deep_extend("force", opts, {
        sources = cmp.config.sources(opts.sources),
        formatting = {
          format = function(entry, item)
            item.menu = format_menu[entry.source.name]
            return item
          end
        }
      }))
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {"onsails/lspkind.nvim"},
    opts = function(_, opts)
      local cmp = require("cmp")
      return vim.tbl_deep_extend("force", opts, {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
        mapping = {
          -- Accept first option with <right>
          ["<right>"] = cmp.mapping.confirm({select = true})
        },
        formatting = {
          format = {mode = "symbol", maxwidth = 50, ellipsis_char = "…"}
        }
      })
    end,
    config = function(_, opts)
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      local format_menu = opts.formatting.format.menu
      cmp.setup(vim.tbl_deep_extend("force", opts, {
        sources = cmp.config.sources(opts.sources),
        formatting = {format = lspkind.cmp_format(opts.formatting.format)}
      }))
    end
  },

  -- Add completion for commands and search
  {
    "hrsh7th/cmp-cmdline",
    -- TODO: enable bugs are fixed
    -- * https://github.com/hrsh7th/cmp-cmdline/issues/52
    -- * https://github.com/hrsh7th/cmp-cmdline/issues/91
    -- * https://github.com/hrsh7th/cmp-cmdline/pull/83
    enabled = false,
    dependencies = {"hrsh7th/nvim-cmp"},
    keys = {"/", "?", ":"},
    config = function()
      local cmp = require("cmp")

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({"/", "?"}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {{name = "buffer"}}
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})
      })
    end
  }
}
