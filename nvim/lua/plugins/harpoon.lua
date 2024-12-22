return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "telescope.nvim" },
    keys = {
        { "<leader>a", function() require("harpoon"):list():add() end },
        -- Disable this in favor of the telescope front end initialized below.
        -- { "<C-e>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },

        { "<C-h>",     function() require("harpoon"):list():select(1) end },
        { "<C-t>",     function() require("harpoon"):list():select(2) end },
        { "<C-n>",     function() require("harpoon"):list():select(3) end },
        { "<C-s>",     function() require("harpoon"):list():select(4) end },

        -- Toggle previous & next buffers stored within Harpoon list
        { "<C-S-P>",   function() require("harpoon"):list():prev() end },
        { "<C-S-N>",   function() require("harpoon"):list():next() end },
    },
    init = function()
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<C-e>", function() toggle_telescope(require("harpoon"):list()) end,
            { desc = "Open harpoon window" })
    end,
}
