local function get_list_of_packages()
  -- Create a new buffer in the background and load packages.lua file
  local bufnr = vim.api.nvim_create_buf(false, true)
  local file_contents = vim.fn.readfile(PLUGINS_CONFIG_PATH)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, file_contents)

  local root = vim.treesitter.get_parser(bufnr, "lua"):parse()[1]:root()

  -- There is an alternation in the query so we can capture both table_constructor and string
  local query = vim.treesitter.query.parse(
    "lua",
    [[
      (function_call
        name: (dot_index_expression) @require-name
        (#eq? @require-name "require(\"lazy\").setup")
        (arguments
         (table_constructor
           (field 
            [(table_constructor . (field (string) @package-name))
             (string) @package-name]))))
    ]]
  )

  -- Table of { name, row }
  local packages = {}

  for id, node, _ in query:iter_captures(root, bufnr) do
    local capture_name = query.captures[id]
    -- Filter out "require-name" capture
    if capture_name == "package-name" then
      local start_row, start_col, end_row, end_col = node:range()
      local package_name = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})[1]
      -- Remove quotes from string
      package_name = string.sub(package_name, 2, -2)
      table.insert(packages, { name = package_name, row = start_row + 1 })
    end
  end

  -- Delete temp buffer
  vim.api.nvim_buf_delete(bufnr, {})

  return packages
end
