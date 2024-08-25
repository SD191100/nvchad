return {
  {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tailwindcss = {},
    },
  },
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function ()
      require("colorizer").setup({
        user_default_options = {
          tailwindcss = true,
        }
      })
      require("colorizer").attach_to_buffer(0, 
        { mode = "background", css = true}
      )
    end,
  },
}
