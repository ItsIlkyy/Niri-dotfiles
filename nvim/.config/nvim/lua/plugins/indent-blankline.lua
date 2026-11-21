return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "┆", -- You can change this character (e.g., "|", "┆", "┊")
    },
    scope = {
      enabled = true, -- Highlights or underlines the current code block context
      show_start = false,
      show_end = false,
    },
  },
}
