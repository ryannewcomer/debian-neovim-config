local M = {}

M.goto_package_config = function(opts)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  local packages = get_list_of_packages()

  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Plugin Config",
      finder = finders.new_table({
        results = packages,
        entry_maker = function(entry)
          return {
            filename = PLUGINS_CONFIG_PATH,
            display = entry.name,
            ordinal = entry.name,
            row = entry.row,
            col = 0,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

return M
