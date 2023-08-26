return {
  "christoomey/vim-tmux-navigator",
  {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    opts = {detection_methods = {"pattern", "lsp"}, dpatterns = {"BUILD"}, silent_chdir = false }
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
