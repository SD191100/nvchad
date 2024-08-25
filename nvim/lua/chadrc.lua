-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}
M.ui = {
  statusline = {
    theme = "vscode_colored",
    modules = {
      abc = function ()
        return "hiii"
      end
    },
    separator_style = "round"
  }
}
M.base46 = {
	theme = "onedark",
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

return M
