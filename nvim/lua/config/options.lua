local opts = {
    clipboard = 'unnamedplus', -- System clipboard

    number = true,
    relativenumber = true,

    -- 4 character tabs.
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
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

    colorcolumn = "80"
}

-- Set options from table
for opt, val in pairs(opts) do
    vim.o[opt] = val
end

local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)

-- Transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.opt.colorcolumn = ""
