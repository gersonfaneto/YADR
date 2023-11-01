local base = require("utils.base")

local props = {
  options = {
    silent = true,
    noremap = true,
  },
  prefix = "Harpoon: ",
}

local M = {}

base.mappings.bulk_register({
  {
    mode = { "n" },
    lhs = "<leader>hf",
    rhs = ":lua require('harpoon.mark').add_file()<CR>",
    options = props.options,
    description = props.prefix .. "Add current file to Harpoon.",
  },
  {
    mode = { "n" },
    lhs = "<leader>hm",
    rhs = ":lua require('harpoon.ui').toggle_quick_menu()<CR>",
    options = props.options,
    description = props.prefix .. "Open.",
  },
  {
    mode = { "n" },
    lhs = "<leader>1",
    rhs = ":lua require('harpoon.ui').nav_file(1)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 1.",
  },
  {
    mode = { "n" },
    lhs = "<leader>2",
    rhs = ":lua require('harpoon.ui').nav_file(2)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 2.",
  },
  {
    mode = { "n" },
    lhs = "<leader>3",
    rhs = ":lua require('harpoon.ui').nav_file(3)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 3.",
  },
  {
    mode = { "n" },
    lhs = "<leader>4",
    rhs = ":lua require('harpoon.ui').nav_file(4)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 4.",
  },
  {
    mode = { "n" },
    lhs = "<leader>5",
    rhs = ":lua require('harpoon.ui').nav_file(5)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 5.",
  },
  {
    mode = { "n" },
    lhs = "<leader>6",
    rhs = ":lua require('harpoon.ui').nav_file(6)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 6.",
  },
  {
    mode = { "n" },
    lhs = "<leader>7",
    rhs = ":lua require('harpoon.ui').nav_file(7)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 7.",
  },
  {
    mode = { "n" },
    lhs = "<leader>8",
    rhs = ":lua require('harpoon.ui').nav_file(8)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 8.",
  },
  {
    mode = { "n" },
    lhs = "<leader>9",
    rhs = ":lua require('harpoon.ui').nav_file(9)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 9.",
  },
  {
    mode = { "n" },
    lhs = "<leader>0",
    rhs = ":lua require('harpoon.ui').nav_file(10)<CR>",
    options = props.options,
    description = props.prefix .. "Go to file number 10.",
  },
})

return M
