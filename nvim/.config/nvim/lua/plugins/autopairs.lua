return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Mengintegrasikan dengan Treesitter agar tidak auto-pair di dalam string/comment
      })
    end,
  },
}
