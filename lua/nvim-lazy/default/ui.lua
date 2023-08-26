return {
  {
    "echasnovski/mini.trailspace",
    main = "mini.trailspace",
    dependencies = {"echasnovski/mini.nvim"},
    event = "VeryLazy",
    config = true
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      -- A low `timeoutlen` is preferred so that which-key can show up quickly
      -- after pressing part of a mapping
      -- The default `timeoutlen` is 1000
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  }
}
