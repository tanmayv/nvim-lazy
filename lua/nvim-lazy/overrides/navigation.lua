return {
  "christoomey/vim-tmux-navigator",
  {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    opts = {patterns = {"BUILD"}}
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      {"-", "<cmd>Oil<cr>", desc = "Open current file's folder"},
      {"_", "40<c-w>v<cmd>Oil<cr>", desc = "Open current file's folder"},
    }
  }
}
