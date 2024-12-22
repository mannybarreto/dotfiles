return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

        -- Function to check if the current buffer is in a Git repository
        local function is_git_repo()
            local cwd = vim.fn.getcwd()
            local git_dir = vim.fn.finddir('.git', cwd .. ';')
            return git_dir ~= ''
        end

        -- Conditional keymap for Git actions
        vim.keymap.set('n', '<leader>fg', function()
            if is_git_repo() then
                builtin.git_files() -- Use git_files when in a Git repo
            else
                builtin.live_grep() -- Otherwise use live_grep
            end
        end, { desc = 'Telescope git files or live grep' })
    end,
}
