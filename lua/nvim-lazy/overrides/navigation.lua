return {
  "christoomey/vim-tmux-navigator",
  {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    opts = {detection_methods = {"pattern", "lsp"}, dpatterns = {"BUILD"}, silent_chdir = false }
  },
  {
    "tanmayv/harpoon",
    keys = {
      {
        "mm",
        function() require("harpoon.mark").add_file() end,
        desc = "[Harpoon] Add file"
      },
      {
        "\\f",
        function() require("harpoon.ui").toggle_quick_menu() end,
        desc = "[Harpoon] File quick menu"
      },
      {
        "\\c",
        function() require("harpoon.cmd-ui").toggle_quick_menu() end,
        desc = "[Harpoon] Cmd quick menu"
      },
    }
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
