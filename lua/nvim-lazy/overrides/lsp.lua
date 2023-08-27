return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {"nvim-treesitter/nvim-treesitter"}
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      -- markdown and markdown_inline are required by lspsaga
      ensure_installed = {"markdown", "markdown_inline", "cpp", "lua", "python"},
      sync_install = false,
      auto_install = true,
      highlight = {enable = false}
    },
    main = "nvim-treesitter.configs"
  }
}

