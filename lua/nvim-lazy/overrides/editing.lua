return {
  {
    name = "nvim-lazy-editing",
    dir = "/dev/null",
    config = function() vim.cmd("packadd cfilter") end
  },
  {
    "numToStr/Comment.nvim", opts = {}
  },
  {"windwp/nvim-autopairs", opts = {}},
  {"tanmayv/harpoon", opts = {}}
}
