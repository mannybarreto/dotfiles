-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--  System Clipboard
local function set_clipboard(text)
  local handle = io.popen("pbcopy", "w") -- Use 'pbcopy' for macOS
  handle:write(text)
  handle:close()
end

-- Yank to system clipboard
vim.api.nvim_set_keymap("n", "yy", '"+yy', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "y", '"+y', { noremap = true, silent = true })

-- Put from system clipboard
vim.api.nvim_set_keymap("n", "p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "p", '"+p', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local data = vim.fn.getreg('"')
    set_clipboard(data)
  end,
})
