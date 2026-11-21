return {
  -- Customizations for Nvim Tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {"nvim-tree/nvim-web-devicons",},
    lazy = false,
    opts = {
      filters = {},
      hijack_unnamed_buffer_when_opening = true,
      renderer = {root_folder_label = ":~:s?$?/..?",},
    },
  },
}

