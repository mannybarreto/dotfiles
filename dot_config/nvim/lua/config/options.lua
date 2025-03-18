function set_options_from_table(table)
  -- Set options from table
  for opt, val in pairs(table) do
    vim.o[opt] = val
  end
end

function set_local_options_from_table(table)
  -- Set options from table
  for opt, val in pairs(table) do
    vim.opt_local[opt] = val
  end
end

local opts = {
  clipboard = 'unnamedplus', -- System clipboard

  number = true,
  relativenumber = true,

  -- 4 character tabs.
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,

  smartindent = true, -- Indent on new lines

  wrap = false,

  -- Don't save backups and swap files, but undofiles are cool
  swapfile = false,
  backup = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir", -- Give undotree a history.
  undofile = true,

  -- Cleaner, incremental search search
  hlsearch = false,
  incsearch = true,

  -- 24 bit RGB.
  termguicolors = true,

  -- Show at least 8 lines at bottom if possible
  scrolloff = 8,
  signcolumn = "yes",

  -- Faster cursor hold event
  updatetime = 50,

  colorcolumn = "80",
}

set_options_from_table(opts)


vim.g.shell = "/usr/bin/fish"

local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)

-- Transparent background
--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--vim.opt.colorcolumn = ""

-- Markdown Specific
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    set_local_options_from_table({
      wrap = true,
      linebreak = true,
      -- Treat visual/logical lines together
      -- Scrolling through visual lines without leaving view
      smoothscroll = true,
      -- Indent wrapped lines visually
      breakindent = true,
      breakindentopt = "shift:2,min:40",
    });

    vim.keymap.set('n', 'j', function() return vim.v.count == 0 and 'gj' or '<Esc>' .. vim.v.count .. 'j' end,
      { expr = true, noremap = true, buffer = 0 })
    vim.keymap.set('n', 'k', function() return vim.v.count == 0 and 'gk' or '<Esc>' .. vim.v.count .. 'k' end,
      { expr = true, noremap = true, buffer = 0 })
  end,
})
