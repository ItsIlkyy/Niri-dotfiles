return {
  {
    "nvzone/showkeys",
    lazy = false,
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 3,
      show_count = false,
      position = "bottom-right", -- Pilihan: "top-right", "bottom-right", "top-left", dll.
    },
      vim.schedule(function()
        vim.cmd("ShowkeysToggle")
      end)
  },
}
