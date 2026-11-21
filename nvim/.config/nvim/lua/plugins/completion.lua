return {
  {
    "Saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "none", -- Matikan preset bawaan agar tidak bentrok
        ["<CR>"] = { "accept", "fallback" }, -- Enter untuk konfirmasi/pilih saran
        ["<Tab>"] = { "select_next", "fallback" }, -- Tab untuk pindah ke saran berikutnya
        ["<S-Tab>"] = { "select_prev", "fallback" }, -- Shift+Tab untuk saran sebelumnya
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
