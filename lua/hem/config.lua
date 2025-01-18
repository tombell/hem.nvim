---@class hem.Config.mod: hem.Config
local M = {}

---@class hem.Config
local defaults = {
  components = { "%l", "%s", "{fold}", " " },
  fold = {
    open = "",
    close = "",
  },
}

---@type hem.Config
local options

---@param opts? hem.Config
function M.setup(opts)
  ---@type hem.Config
  options = vim.tbl_deep_extend("force", {}, options or defaults, opts or {})

  return options
end

return setmetatable(M, {
  __index = function(_, key)
    options = options or M.setup()
    return options[key]
  end,
})
