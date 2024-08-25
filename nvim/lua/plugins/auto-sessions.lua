return {
  "rmagatti/auto-session",
  config = function ()
    local auto_session = require "auto-session"

    auto_session.setup({
      auto_restore_enable = false,
      auto_session_supress_dirs = {
        "~/",
        "~/Dev",
        "~/Documents/",
        "~/Downloads",
        "~/Desktop",
      }
    })

    local function map(mode, key, command, desc)
      vim.keymap.set(mode, key, command, { desc = desc })
    end

    map("n", "<leader>", "<cmd>SessionRestore<CR>", "Restore prev saved session")
    map("n", "<leader>", "<cmd>SessionSave<CR>", "Save session")
  end
}
