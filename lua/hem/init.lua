local M = {}

---@class hem.Opts
---
--- The components for the status column.
---@field components? string[]
---
--- The configuration for the fold component.
---@field fold table<"open"|"close", string>

---@type hem.Opts
local defaults = {
  components = { "%l", "%s", "{fold}", " " },
  fold = {
    open = "",
    close = "",
  },
}

---@type hem.Opts|nil
vim.g.hem_opts = vim.g.hem_opts

M.opts = vim.tbl_deep_extend("force", vim.deepcopy(defaults), vim.g.hem_opts or {})

function M.fold()
  return vim.api.nvim_win_call(vim.g.statusline_winid, function()
    if vim.fn.foldclosed(vim.v.lnum) >= 0 then
      return M.opts.fold.close
    elseif tostring(vim.treesitter.foldexpr(vim.v.lnum)):sub(1, 1) == ">" then
      return M.opts.fold.open
    else
      return " "
    end
  end)
end

---@return string
function M.get()
  return table.concat(
    vim.tbl_map(function(component)
      return component == "{fold}" and M.fold() or component
    end, M.opts.components),
    " "
  )
end

return M
