return {
    "stevearc/conform.nvim",
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "black" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                javascript = { "prettier", stop_after_first = true },
                typescript = { "prettier", stop_after_first = true },
                javascriptreact = { "prettier", stop_after_first = true },
                typescriptreact = { "prettier", stop_after_first = true },
                svelte = { "prettier", stop_after_first = true },
                css = { "prettier", stop_after_first = true },
                html = { "prettier", stop_after_first = true },
                json = { "prettier", stop_after_first = true },
                markdown = { "prettier", stop_after_first = true },
                yaml = { "prettier", stop_after_first = true },
                -- add more later depending on what lsps you have!
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        })
        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
