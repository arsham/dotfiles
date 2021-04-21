require('gitsigns').setup {
    signs = {
      add = {text = '▋'},
      change = {text= '▋'},
      delete = {text = '▋'},
      topdelete = {text = '▔'},
      changedelete = {text = '▎'},
    },
}

-- lualine
--

require("lualine").setup{
    options = {
      theme = 'papercolor_light',
      section_separators = {'', ''},
      component_separators = {'', ''},
      icons_enabled = true,
    },
    sections = {
      lualine_a = { {'mode', {upper = true,},}, },
      lualine_b = { {'branch', {icon= '',}, }, },
      lualine_c = { {'filename', {file_status= true,},}, },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' ,  {'diagnostics', {sources= {'nvim_lsp', 'ale'}, color_error= '#aa0000', color_warn= '#aa0000'}} },
    },
    inactive_sections = {
      lualine_a = {  },
      lualine_b = {  },
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {  },
      lualine_z = {  },
    },
    extensions = { 'fzf' },
}

-- lspconfig

local treesitter_configs = require('nvim-treesitter.configs')

treesitter_configs.setup {
  ensure_installed = "maintained",
  indent = {enable = true},
  fold = {enable = true},
  highlight = {
    enable = true,
  },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
}

treesitter_configs.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['am'] = '@call.outer',
        ['im'] = '@call.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]]"] = "@function.outer",
        ["]b"] = "@block.outer",
      },
      goto_next_end = {
        ["]["] = "@function.outer",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[b"] = "@block.outer",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
        ["[B"] = "@block.outer",
      },
    },
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["df"] = "@function.outer",
      },
    },
  },
}