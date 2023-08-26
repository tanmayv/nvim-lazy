return {
  {
    name = "nvim-lazy-options",
    dir = "/dev/null",
    config = function()
	vim.o.number = true
	vim.o.shiftwidth = 2
	vim.o.smarttab = true
    end
  }
}

