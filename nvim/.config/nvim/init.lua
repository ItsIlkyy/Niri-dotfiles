vim.g.mapleader = " "
vim.opt.shortmess:append("I")
vim.opt.fillchars:append({ eob = " " })

require("configs.options")
require("configs.lazy")
require("configs.keymap")

