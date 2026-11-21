-- lua/config/keymaps.lua

local map = vim.keymap.set

-- AI (gen.nvim)
map({ "n", "v" }, "<leader>a", ":Gen<CR>", { desc = "Ollama Gemma AI", silent = true })
map({ "n", "v" }, "<leader>k", function()
  require("gen").toggle()
end, { desc = "Toggle/Show AI Float Window", silent = true })

-- ToggleTerm
map({ "n", "t" }, "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle Float Terminal", silent = true })

-- NvimTree
map("n", "<c-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree", silent = true })

