return {
  {
    name = "nvim-lazy-editing",
    dir = "/dev/null",
    config = function() vim.cmd("packadd cfilter") end
  },
  {"windwp/nvim-autopairs", opts = {}}
}
