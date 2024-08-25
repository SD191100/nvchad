return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'jonarrien/telescope-cmdline.nvim',
  },
  keys = {
    { ':', '<cmd>Telescope cmdline<cr>', desc = 'Cmdline' }
  },
  opts = {
    extensions = {
      cmdline = {
        picker = {
        layout_config = {
          width  = 120,
          height = 25,
        }
      },
      mappings    = {
        complete      = '<Tab>',
        run_selection = '<C-CR>',
        run_input     = '<CR>',
      },
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension('cmdline')
  end,
}
