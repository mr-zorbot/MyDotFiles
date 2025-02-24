-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.relativenumber = true
lvim.colorscheme = "dracula"
vim.opt.wrap = true

lvim.plugins = {
    "Mofiqul/dracula.nvim", "p00f/clangd_extensions.nvim",
    "mfussenegger/nvim-jdtls", "olexsmir/gopher.nvim", "sbdchd/neoformat", {
        "kdheepak/lazygit.nvim",
        lazy = false,
        cmd = {
            "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter",
            "LazyGitFilterCurrentFile"
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end
    }
}

lvim.builtin.treesitter.ensure_installed = {
    "bash", "c", "cpp", "go", "javascript", "json", "lua", "python",
    "typescript", "tsx", "css", "rust", "java", "yaml"
}

lvim.lsp.installer.setup.ensure_installed = {
    "asm_lsp", -- Assembly
    "bashls", -- Bash
    "clangd", -- C/CPP
    "gopls", -- Go
    "jdtls", -- Java
    "eslint", -- Javascript
    "jsonls", -- Json
    "lua_ls", -- Lua
    "grammarly", -- Markdown
    "pyright", -- Python
    "lemminx", -- XML
    "yamlls" -- Yaml 
}

-- Habilitar o Neoformat 
vim.g.neoformat_enabled = {
    'bash', 'c', 'cpp', 'go', 'javascript', 'json', 'lua', 'python',
    'typescript', 'tsx', 'css', 'rust', 'java', 'yaml'
}

-- Configuração para formatar ao salvar automaticamente
vim.cmd [[autocmd BufWritePre * Neoformat]]

-- Keymap para mapear a tecla F1 para executar o comando :Neoformat
vim.api.nvim_set_keymap('n', '<F1>', ':Neoformat<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<F1>', ':Neoformat<CR>',
                        {noremap = true, silent = true})

-- Keymap para mapear a tecla F2 para executar o comando :LazyGit
vim.api.nvim_set_keymap('n', '<F2>', ':LazyGit<CR>',
                        {noremap = true, silent = true})

lvim.builtin.treesitter.ignore_install = {"haskell"}
lvim.builtin.treesitter.highlight.enabled = true
lvim.lsp.installer.setup.automatic_installation = true
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers,
                {"clangd", "jdtls", "gopls"})
