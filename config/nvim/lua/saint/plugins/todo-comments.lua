return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")
        -- adding IMPORTANT into the notes
        -- BUG: Important is not showing when comment!
        todo_comments.setup({
            keywords = {
                IMPORTANT = {
                    icon = "",
                    color = "important",
                    alt = { "CRITICAL", "PRIORITY" },
                },
            },
            colors = {
                important = { "fg", "#FF8800" },
            },
        })

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Next todo comment" })

        keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Previous todo comment" })

        todo_comments.setup()
    end,
}
