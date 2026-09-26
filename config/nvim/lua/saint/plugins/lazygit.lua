return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- floating window border decordation! make it beautiful ✨
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for lazygit with keys recommended in order to load the plugin when command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open Lazy git" },
    },
}
