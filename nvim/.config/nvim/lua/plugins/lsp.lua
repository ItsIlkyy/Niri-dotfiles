return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "Saghen/blink.cmp" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.diagnostic.config({
          signs = {
              text = {
                  [vim.diagnostic.severity.ERROR] = "",
                  [vim.diagnostic.severity.WARN]  = "",
                  [vim.diagnostic.severity.HINT]  = "",
                  [vim.diagnostic.severity.INFO]  = "",
              },
          },
      })

      -- Keymaps khusus saat LSP aktif
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
          map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
        end,
      })

      -- Konfigurasi server dengan capabilities dari blink.cmp
      vim.lsp.config("clangd", { capabilities = capabilities })
      vim.lsp.config("pyright", { capabilities = capabilities })
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Aktifkan server
      vim.lsp.enable("clangd")
      vim.lsp.enable("pyright")
      vim.lsp.enable("lua_ls")
    end,
  },
}
