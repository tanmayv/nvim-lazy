return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim"},
    config = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts, {
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {preview_height = 0.8}
          }
        }
      })
      require("telescope").setup {opts}
      require("telescope").load_extension("undo")
    end,
    keys = {
      {"<leader>ut", "<cmd>Telescope undo", desc = "Open undo tree"}
    }
  },
  {
    name = "nvim-lazy-editing",
    dir = "/dev/null",
    config = function() vim.cmd("packadd cfilter") end
  },
  {"numToStr/Comment.nvim", opts = {}},
  {"windwp/nvim-autopairs", opts = {}},
  {"tanmayv/harpoon", opts = {}}
}
