return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = {"MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim"},
    opts = {}
  },
  "christoomey/vim-tmux-navigator",
  {
    "ahmedkhalf/project.nvim",
    main = "project_nvim",
    opts = {
      detection_methods = {"pattern", "lsp"},
      dpatterns = {"BUILD"},
      silent_chdir = false
    }
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
      }
    }
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      {"-", "<cmd>Oil<cr>", desc = "Open current file's folder"},
      {"_", "40<c-w>v<cmd>Oil<cr>", desc = "Open current file's folder"}
    }
  },
  {
    "tabs_navigation",
    dir = "/dev/null",
    dependencies = {"ton/vim-bufsurf"},
    keys = {
      {"J", "gT", desc = "Go to previous tab"},
      {"K", "gt", desc = "Go to next tab"},
      {"H", "<cmd>BufSurfBack<cr>", desc = "Go to previous in buffer history"},
      {"L", "<cmd>BufSurfForward<cr>", desc = "Go to next in buffer history"},
    }
  }
}
