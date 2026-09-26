return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        -- import nvim-autopairs
        local autopairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")

        -- configure autopairs
        autopairs.setup({
            check_ts = true, -- enable treesitter
            ts_config = {
                lua = { "string" }, -- dont add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter node
                java = false, -- don't check treesitter on java
            },
        })

        -- add global $...$ rule
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*.md",
            callback = function()
                autopairs.add_rules({
                    Rule("$", "$"):with_pair(function(opts)
                        -- don't autopair if right before a word character
                        return opts.prev_char:match("%w") == nil
                    end),
                })
            end,
        })

        -- import nvim-autopairs completion functionally
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        -- import nvim-cmp plugin (completions plugin)
        local cmp = require("cmp")

        -- make autopairs and completion work together
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
