local Input = function(on_submit, prompt)
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  local input = Input({
    position = "50%",
    size = {width = 30},
    border = {style = "single", text = {top = "Find", top_align = "center"}},
    win_options = {winhighlight = "Normal:Normal,FloatBorder:Normal"}
  }, {
    prompt = ">",
    default_value = "",
    on_close = function() end,
    on_submit = on_submit
  })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function() input:unmount() end)
end

local FindReplace = function()
  Input(function(find_value)
    Input(function(replace_value)
      require("smart-replace").ReplaceFile(find_value, replace_value)
    end, "Replace")
  end, "Find")
end

local FindReplaceFile = function() end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}
    },
    config = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts, {
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {preview_height = 0.8}
          },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        }
      })
      require("telescope").setup {opts}
      require("telescope").load_extension("undo")
      require("telescope").load_extension("fzf")
    end,
    keys = {{"<leader>ut", "<cmd>Telescope undo", desc = "Open undo tree"}}
  },
  {
    "tanmayv/smart-replace",
    dependencies = {"MunifTanjim/nui.nvim"},
    keys = {{"<leader>rf", FindReplace, desc = "Smart find replace on file"}}
  },
  {'kevinhwang91/nvim-bqf', ft = 'qf'},
  {
    name = "nvim-lazy-editing",
    dir = "/dev/null",
    config = function() vim.cmd("packadd cfilter") end
  },
  {"numToStr/Comment.nvim", opts = {}},
  {"windwp/nvim-autopairs", opts = {}},
  {"tpope/vim-abolish"},
  {"tanmayv/harpoon", opts = {}}
}
