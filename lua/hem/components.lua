local Config = require "hem.config"

local M = {}

function M.fold()
  return vim.api.nvim_win_call(vim.g.statusline_winid, function()
    if vim.fn.foldclosed(vim.v.lnum) >= 0 then
      return Config.fold.close
    elseif tostring(vim.treesitter.foldexpr(vim.v.lnum)):sub(1, 1) == ">" then
      return Config.fold.open
    else
      return " "
    end
  end)
end

return M
