-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.relativenumber = true
lvim.colorscheme = "dracula"
vim.opt.wrap = true

lvim.plugins = {
  "Mofiqul/dracula.nvim",
  "p00f/clangd_extensions.nvim",
  "mfussenegger/nvim-jdtls",
  "olexsmir/gopher.nvim",
  {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}

lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "cpp",
    "go",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
}

lvim.lsp.installer.setup.ensure_installed = {
    "asm_lsp", -- Assembly
    "bashls", -- Bash
    "clangd", -- C/CPP
    "gopls", -- Go
    "jdtls", -- Java
    "denols", -- Javascript
    "jsonls", -- Json
    "lua_ls", -- Lua
    "grammarly", -- Markdown
    "pyright", -- Python
    "lemminx", -- XML
  }

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.lsp.installer.setup.automatic_installation = true
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd", "jdtls", "gopls",})
