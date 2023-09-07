return {
  {
    name = "nvim-lazy-options",
    dir = "/dev/null",
    config = function()
      vim.wo.number = true
      vim.wo.relativenumber = true
      vim.o.shiftwidth = 2
      vim.o.smarttab = true
    end
  },
  {
    name = "nvgoog-mappings",
    dir = "/dev/null",
    keys = {
      -- Remap ; tp ; for faster command access
      {";", ";", mode = {"n", "v"}}
    }
  }
}

