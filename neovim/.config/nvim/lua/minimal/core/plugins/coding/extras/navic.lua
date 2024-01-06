return {
  "SmiteshP/nvim-navic",
  config = function()
    local navic = require("nvim-navic")

    local interface = require("minimal.utils.interface")

    local icons = interface.icons.get("ui", false)

    navic.setup({
      highlight = true,
      lsp = {
        auto_attach = true,
        preference = { "typescript-tools" },
      },
      click = true,
      separator = " " .. icons.ChevronRight .. " ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      },
    })
  end,
}
