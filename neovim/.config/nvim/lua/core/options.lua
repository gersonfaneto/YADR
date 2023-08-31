---@diagnostic disable: undefined-global

local settings = require("core.settings")

local M = {}

M.g = {
  mapleader = " ",
  maplocalleader = " ",
  cmptoggle = true,
}

M.opt = {
  backup = false,
  undofile = true,
  swapfile = false,
  writebackup = false,
  fileencoding = "utf-8",

  spell = false,
  spelllang = { "en_us", "pt_br" },

  foldmethod = "manual",
  foldenable = false,

  mouse = "a",
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  colorcolumn = settings.show_color_column and settings.color_column or "",

  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,

  cmdheight = 1,
  pumheight = 10,
  conceallevel = 0,
  showmode = false,

  hlsearch = true,
  incsearch = true,
  ignorecase = true,

  completeopt = { "menu", "menuone", "noselect" },
  timeoutlen = 200,
  updatetime = 100,

  showtabline = 0,
  termguicolors = true,

  smartcase = true,
  smartindent = true,

  splitbelow = true,
  splitright = true,

  number = true,
  relativenumber = true,
  numberwidth = 4,
  signcolumn = "yes",
  fillchars = { eob = " " },
}

vim.opt.shortmess:append("sI")
vim.opt.whichwrap:append("<>[]hl")
vim.opt.diffopt:append("vertical")
vim.opt.clipboard:append("unnamedplus")

for prefix, tbl in pairs(M) do
  for key, value in pairs(tbl) do
    vim[prefix][key] = value
  end
end

return M
