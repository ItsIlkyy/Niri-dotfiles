return {
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Opsi kustomisasi Nord (opsional)
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_italic = true

      -- Muat colorscheme
      vim.cmd("colorscheme nord")
    end,
  },
}
