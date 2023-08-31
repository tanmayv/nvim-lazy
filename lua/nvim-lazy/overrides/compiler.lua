return {
  { -- This plugin
    "Zeioth/compiler.nvim",
    cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
    keys = {
      {"<F9>", "<cmd>CompilerOpen<cr>", desc = "Open compiler menu"},
      {"<S-F9>", "<cmd>CompilerStop<cr><cmd>CompilerRedo<cr>", desc = "Compiler redo last action"}
    },
    dependencies = {{
      "stevearc/overseer.nvim",
    commit = "3047ede61cc1308069ad1184c0d447ebee92d749",
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
        bindings = {["q"] = function() vim.cmd("OverseerClose") end}
      }
    }
    }},
    opts = {}
  },
  {
    "krady21/compiler-explorer.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
      "rcarriga/nvim-notify"
    },
    cmd = {
      "CECompile", "CECompileLive",
      "CEFormat", "CEAddLibrary",
      "CELoadExample", "CEOpenWebsite",
      "CEDeleteCache", "CEShowTooltip",
      "CEGoToLabel",
    }
  }
}
