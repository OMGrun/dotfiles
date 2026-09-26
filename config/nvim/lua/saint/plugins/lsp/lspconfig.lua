return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/lazydev.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- Setup capabilities first
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local keymap = vim.keymap

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

                opts.desc = "Signature help"
                keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            end,
        })

        -- Define sign icons for each severity
        local signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        }

        -- Set the diagnostic config with all icons
        vim.diagnostic.config({
            signs = {
                text = signs,
            },
            virtual_text = true,
            underline = true,
            update_in_insert = false,
        })

        -- Setup servers using lspconfig (with deprecation warning suppressed)
        local lspconfig = require("lspconfig")
        
        -- Helper function to safely check if server exists
        local function server_exists(name)
            local old_notify = vim.notify
            vim.notify = function() end -- Suppress deprecation warnings temporarily
            local ok, server = pcall(function() return lspconfig[name] end)
            vim.notify = old_notify -- Restore notify
            return ok and server ~= nil
        end

        -- Servers to auto-setup with default capabilities
        local auto_setup_servers = {
            "clangd", 
            "tinymist"
        }
        
        for _, server in ipairs(auto_setup_servers) do
            if server_exists(server) then
                lspconfig[server].setup({
                    capabilities = capabilities,
                })
            end
        end

        -- Config lua_ls with custom settings
        if server_exists("lua_ls") then
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })
        end

        -- Config eslint with custom settings
        if server_exists("eslint") then
            lspconfig.eslint.setup({
                root_dir = function(fname)
                    return vim.fs.dirname(vim.fs.find({
                        "eslint.config.js",
                        ".eslintrc",
                        ".eslintrc.json",
                        "package.json",
                        ".git",
                    }, { upward = true, path = fname })[1])
                end,
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                capabilities = capabilities,
                settings = {
                    workingDirectory = { mode = "auto" },
                },
            })
        end
    end,
}

--[[ emmet_ls
        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
            },
        })

        -- emmet_language_server
        lspconfig.emmet_language_server.setup({
            capabilities = capabilities,
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "pug",
                "typescriptreact",
            },
            init_options = {
                includeLanguages = {},
                excludeLanguages = {},
                extensionsPath = {},
                preferences = {},
                showAbbreviationSuggestions = true,
                showExpandedAbbreviation = "always",
                showSuggestionsAsSnippets = false,
                syntaxProfiles = {},
                variables = {},
            },
        })

        -- denols
        lspconfig.denols.setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        })

        -- ts_ls (replaces tsserver)
        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            root_dir = function(fname)
                local util = lspconfig.util
                return not util.root_pattern("deno.json", "deno.jsonc")(fname)
                    and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
            end,
            single_file_support = false,
            init_options = {
                preferences = {
                    includeCompletionsWithSnippetText = true,
                    includeCompletionsForImportStatements = true,
                },
            },
        })]]
