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
  }
}

