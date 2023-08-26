return {
  {
    name = "nvgoog-autocmds",
    dir = "/dev/null",
    opts = {cursorline = false, highlight_yanks = true},
    config = function(_, opts)
      -- Highlight cursor line when window is active
      if opts.cursorline then
        local cursorline_group = vim.api.nvim_create_augroup("cursorline", {})
        vim.api.nvim_create_autocmd({"WinEnter", "BufWinEnter", "FocusGained"},
                                    {
          pattern = "*",
          command = "setlocal cursorline",
          group = cursorline_group
        })
        vim.api.nvim_create_autocmd({"WinLeave", "FocusLost"}, {
          pattern = "*",
          command = "setlocal nocursorline",
          group = cursorline_group
        })
      end

      -- Highlight yank
      if opts.highlight_yanks then
        vim.api.nvim_create_autocmd("TextYankPost", {
          pattern = "*",
          callback = function()
            require("vim.highlight").on_yank({timeout = 250})
          end,
          group = vim.api.nvim_create_augroup("highlight_yank", {})
        })
      end
    end
  },

  {
    name = "nvgoog-mappings",
    dir = "/dev/null",
    keys = {
      -- Remap ; tp ; for faster command access
      {";", ":", mode = {"n", "v"}},

      -- Clears search and removes highlighting
      {"<leader><space>", "<cmd>nohlsearch<cr>", desc = "Clear search"},

      -- Navigate quick list and location list
      {"[q", "<cmd>cprev<cr>", desc = "Goto previous quicklist item"},
      {"]q", "<cmd>cnext<cr>", desc = "Goto next quicklist item"},
      {"[Q", "<cmd>cfirst<cr>", desc = "Goto first quicklist item"},
      {"]Q", "<cmd>clast<cr>", desc = "Goto last quicklist item"},
      {"[l", "<cmd>lprev<cr>", desc = "Goto previous location list item"},
      {"]l", "<cmd>lnext<cr>", desc = "Goto next location list item"},
      {"[L", "<cmd>lfirst<cr>", desc = "Goto first location list item"},
      {"]L", "<cmd>llast<cr>", desc = "Goto next last list item"}
    }
  }
}
