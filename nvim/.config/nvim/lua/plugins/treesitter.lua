return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',

    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "csv",
        "cpp",
        "c",
        "gitignore",
        "toml",
        "yaml",
        "java",
        "json",
        "markdown",
      },
    },
  },
}
