local Components = require "hem.components"
local Config = require "hem.config"

local M = {}

---@param opts? hem.Config
function M.setup(opts)
  require("hem.config").setup(opts)
end

---@return string
function M.get()
  return table.concat(
    vim.tbl_map(function(component)
      return component == "{fold}" and Components.fold() or component
    end, Config.components),
    " "
  )
end

return M
