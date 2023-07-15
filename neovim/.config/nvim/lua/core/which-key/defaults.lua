return {
  mode = { "n", "v" },
  m = { ":Alpha<CR>", "Dashboard" },
  c = { ":bd<CR>", "Close Buffer" },
  p = { ":Telescope treesitter<CR>", "List Symbols" },
  f = { ":lua require('utils').telescope_git_or_file()<CR>", "Find Files" },
  [";"] = {
    ":lua require('telescope.builtin').resume(require('telescope.themes').get_dropdown({}))<CR>",
    "Open last picker",
  },
  ["/"] = {
    function()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end,
    'Fuzzily search in current buffer',
  },
  b = {
    name = "Buffers",
    j = { ":BufferLinePick<CR>", "Jump" },
    f = { ":Telescope buffers previewer=false<CR>", "Find" },
    b = { ":BufferLineCyclePrev<CR>", "Previous" },
    n = { ":BufferLineCycleNext<CR>", "Next" },
    w = { ":noautocmd w<CR>", "Save without formatting (noautocmd)" },
    e = { ":BufferLinePickClose<CR>", "Pick which buffer to close" },
    h = { ":BufferLineCloseLeft<CR>", "Close all to the left" },
    l = { ":BufferLineCloseRight<CR>", "Close all to the right" },
    D = { ":BufferLineSortByDirectory<CR>", "Sort by directory" },
    L = { ":BufferLineSortByExtension<CR>", "Sort by language" },
    p = { ":BufferLineTogglePin<CR>", "Toggle pin" },
    P = { ":BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" },
  },
  g = {
    name = "+Git",
    k = { ":lua require('gitsigns').prev_hunk({navigation_message = false})<CR>", "Prev Hunk" },
    l = { ":lua require('gitsigns').blame_line()<CR>", "Blame" },
    p = { ":lua require('gitsigns').preview_hunk()<CR>", "Preview Hunk" },
    r = { ":lua require('gitsigns').reset_hunk()<CR>", "Reset Hunk" },
    R = { ":lua require('gitsigns').reset_buffer()<CR>", "Reset Buffer" },
    j = { ":lua require('gitsigns').next_hunk({navigation_message = false})<CR>", "Next Hunk" },
    s = { ":lua require('gitsigns').stage_hunk()<CR>", "Stage Hunk" },
    u = { ":lua require('gitsigns').undo_stage_hunk()<CR>", "Undo Stage Hunk" },
    o = { ":Telescope git_status<CR>", "Open changed file" },
    b = { ":Telescope git_branches<CR>", "Checkout branch" },
    c = { ":Telescope git_commits<CR>", "Checkout commit" },
    C = { ":Telescope git_bcommits<CR>", "Checkout commit(for current file)" },
    d = { ":Gitsigns diffthis HEAD<CR>", "Git Diff" },
  },
  l = {
    name = "+LSP",
    a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { ":lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { ":lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    i = { ":lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    o = { ":lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    R = { ":Telescope lsp_references<CR>", "References" },
    s = { ":lua vim.lsp.buf.signature_help()<CR>", "Display Signature Information" },
    r = { ":lua vim.lsp.buf.rename()<CR>", "Rename all references" },
    f = { ":lua vim.lsp.buf.format()<CR>", "Format" },
    K = { ":lua vim.lsp.buf.hover()<CR>", "Hover" },
    l = { ":TroubleToggle document_diagnostics<CR>", "Document Diagnostics (Trouble)" },
    L = { ":TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics (Trouble)" },
    w = { ":Telescope diagnostics<CR>", "Diagnostics" },
    t = { [[ <Esc>:lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
  },
  t = {
    name = "+Telescope",
    f = { ":Telescope find_files<CR>", "Find File" },
    h = { ":Telescope help_tags<CR>", "Find Help" },
    H = { ":Telescope highlights<CR>", "Find highlight groups" },
    M = { ":Telescope man_pages<CR>", "Man Pages" },
    r = { ":Telescope oldfiles<CR>", "Open Recent File" },
    R = { ":Telescope registers<CR>", "Registers" },
    t = { ":Telescope live_grep<CR>", "Text" },
    k = { ":Telescope keymaps<CR>", "Keymaps" },
    C = { ":Telescope commands<CR>", "Commands" },
    l = { ":Telescope resume<CR>", "Resume last search" },
    c = { ":Telescope git_commits<CR>", "Git commits" },
    B = { ":Telescope git_branches<CR>", "Git branches" },
    s = { ":Telescope git_status<CR>", "Git status" },
    S = { ":Telescope git_stash<CR>", "Git stash" },
    z = { ":Telescope zoxide list<CR>", "Zoxide" },
    b = { ":Telescope buffers<CR>", "Buffers" },
  },
  T = {
    name = "+Todo",
    t = { ":TodoTelescope<CR>", "Todo" },
    T = { ":TodoTelescope keywords=TODO,FIX,FIXME<CR>", "Todo/Fix/Fixme" },
    x = { ":TodoTrouble<CR>", "Todo (Trouble)" },
    X = { ":TodoTrouble keywords=TODO,FIX,FIXME<CR><CR>", "Todo/Fix/Fixme (Trouble)" },
  },
}
