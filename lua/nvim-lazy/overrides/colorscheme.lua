return {
  {
    name = "nvim-lazy-colorscheme",
    dir = "/dev/null",
    dependencies = {"EdenEast/nightfox.nvim"},
    priority = 1000,
    config = function(_, opts)
      local options = vim.tbl_deep_extend("force", {colorscheme = "nightfox"},
                                          opts)
      local colorscheme = options.colorscheme
      require(colorscheme)
      vim.cmd("colorscheme "..colorscheme)
    end
  }
}
