-- ================================
--  基本設定
-- ================================
vim.opt.number = true          -- 行番号表示
vim.opt.relativenumber = true  -- 相対行番号（移動が楽になる）
vim.opt.cursorline = true      -- カーソル行をハイライト
vim.opt.wrap = false           -- 折り返しなし
vim.opt.scrolloff = 8          -- カーソル上下に常に8行余白

-- インデント
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- 検索
vim.opt.hlsearch = true        -- 検索ハイライト
vim.opt.incsearch = true       -- インクリメンタル検索
vim.opt.ignorecase = true      -- 大文字小文字無視
vim.opt.smartcase = true       -- 大文字含む場合は区別

-- クリップボード（双方向コピー）
vim.opt.clipboard = "unnamedplus"

-- 見た目
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"     -- サイン列常時表示（git diffなど）
vim.opt.splitright = true      -- 縦分割は右に開く
vim.opt.splitbelow = true      -- 横分割は下に開く

-- その他
vim.opt.undofile = true        -- undo履歴をファイル保存（再起動後も戻れる）
vim.opt.updatetime = 250
vim.opt.swapfile = false

-- ================================
--  キーマップ
-- ================================
vim.g.mapleader = " "          -- Spaceをリーダーキーに

local map = vim.keymap.set

-- jj でノーマルモードへ
map("i", "jj", "<Esc>", { desc = "Escape" })

-- 検索ハイライトをEscでクリア
map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- ウィンドウ移動 (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- 行移動（折り返し考慮）
map("n", "j", "gj")
map("n", "k", "gk")

-- インデントを連続して使えるように
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ファイル保存
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- バッファ移動
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprev<CR>")

-- ================================
--  プラグイン (lazy.nvim)
-- ================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- カラースキーム
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function() vim.cmd("colorscheme tokyonight-night") end,
  },

  -- ステータスライン
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "tokyonight" } })
    end,
  },

  -- ファイルツリー
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "File tree" })
    end,
  },

  -- あいまいファイル検索 (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local t = require("telescope.builtin")
      map("n", "<leader>ff", t.find_files,  { desc = "Find files" })
      map("n", "<leader>fg", t.live_grep,   { desc = "Live grep" })
      map("n", "<leader>fb", t.buffers,     { desc = "Buffers" })
      map("n", "<leader>fh", t.help_tags,   { desc = "Help" })
    end,
  },

  -- シンタックスハイライト (Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua", "typescript", "javascript", "tsx",
        "python", "go", "java", "rust",
        "ruby", "json", "yaml", "markdown",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- Git 差分表示
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      map("n", "<leader>gd", ":Gitsigns diffthis<CR>",   { desc = "Git diff" })
      map("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame" })
    end,
  },

  -- 括弧の自動補完
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup() end,
  },

  -- コメントアウト (gcc / gc)
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },

  -- インデントのガイド線
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function() require("ibl").setup() end,
  },

  -- which-key (キーマップ一覧をポップアップ)
  {
    "folke/which-key.nvim",
    config = function() require("which-key").setup() end,
  },

  -- ================================
  --  LSP
  -- ================================

  -- LSPサーバー管理 (mason)
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",        -- TypeScript / JavaScript
          "jdtls",        -- Java
          "pyright",      -- Python
          "gopls",        -- Go
          "rust_analyzer",-- Rust
          "lua_ls",       -- Lua
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP本体
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()

      -- LSP共通キーマップ（LSPがアタッチされたバッファに設定）
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local o = { buffer = ev.buf, silent = true }
          map("n", "gd",         vim.lsp.buf.definition,     vim.tbl_extend("force", o, { desc = "Go to definition" }))
          map("n", "gD",         vim.lsp.buf.declaration,    vim.tbl_extend("force", o, { desc = "Go to declaration" }))
          map("n", "gr",         vim.lsp.buf.references,     vim.tbl_extend("force", o, { desc = "References" }))
          map("n", "gi",         vim.lsp.buf.implementation, vim.tbl_extend("force", o, { desc = "Implementation" }))
          map("n", "K",          vim.lsp.buf.hover,          vim.tbl_extend("force", o, { desc = "Hover doc" }))
          map("n", "<leader>rn", vim.lsp.buf.rename,         vim.tbl_extend("force", o, { desc = "Rename" }))
          map("n", "<leader>ca", vim.lsp.buf.code_action,    vim.tbl_extend("force", o, { desc = "Code action" }))
          map("n", "<leader>f",  function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", o, { desc = "Format" }))
          map("n", "[d",         vim.diagnostic.goto_prev,   vim.tbl_extend("force", o, { desc = "Prev diagnostic" }))
          map("n", "]d",         vim.diagnostic.goto_next,   vim.tbl_extend("force", o, { desc = "Next diagnostic" }))
        end,
      })

      -- 各LSPサーバーの設定
      vim.lsp.config("*", { capabilities = caps })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.lsp.enable({ "ts_ls", "pyright", "gopls", "rust_analyzer", "lua_ls" })

      -- Java は jdtls プラグインで管理するため別途設定
    end,
  },

  -- Java LSP (jdtls専用ラッパー)
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      local root = jdtls.setup.find_root({ "pom.xml", "build.gradle", ".git" })
      jdtls.start_or_attach({
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
        root_dir = root,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,
  },

  -- 補完エンジン
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSPソース
      "hrsh7th/cmp-buffer",    -- バッファ内の単語
      "hrsh7th/cmp-path",      -- ファイルパス
      "L3MON4D3/LuaSnip",      -- スニペット
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- エラー・診断をきれいに表示
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      map("n", "<leader>xx", ":TroubleToggle<CR>", { desc = "Diagnostics" })
    end,
  },

})
