return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadpre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter")

        -- configure treesitter
        treesitter.setup({ -- enable syntax highlighting
            highlight = {
                enable = true,
                disable = { "latex" },
            },
            -- enable indentation
            indent = { enable = true },
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = {
                enable = true,
            },
            -- ensure these language parsers are installed
            ensure_installed = {
                -- Systems/backend
                "c",
                "cpp",
                "python",
                "lua",

                -- Web dev frontend
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",

                -- Web dev backend
                "json",
                "bash",
                "markdown",
                "markdown_inline",
                "yaml",

                -- Optional but useful
                "vim",
                "vimdoc",
                "query",
                "gitignore",
                -- don't forget that you can always add more!
                "latex",
                "bibtex",
                "matlab",
                -- LaTex!
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-s>",
                    node_incremental = "<C-s>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            additional_vim_regex_highlighting = false,
        })
    end,
}
