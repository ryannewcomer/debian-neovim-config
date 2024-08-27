local M = setmetatable({}, {
  __call = function(m, ...)
    return m.wrap(...)
  end,
})

function M.config_files()
  return M.wrap("files", { cwd = vim.fn.stdpath("config") })
end
