-- || color constants || - shared background and accent colors
local bg = '#252830'
local purple = '#8a6fa8'
-- // end color constants

-- || completion || - nvim-cmp autocompletion with LSP source
vim.pack.add({ 'https://github.com/hrsh7th/nvim-cmp' })
vim.pack.add({ 'https://github.com/hrsh7th/cmp-nvim-lsp' })

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }
    })
})
-- // end completion

-- || lsp || - language server configs, keymaps, diagnostics
vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
})

vim.lsp.config('zls', {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir', 'zon' },
    root_markers = { 'build.zig', '.git' },
})

vim.lsp.config('pylsp', {
    cmd = { 'pylsp' },
    filetypes = { 'py', 'python' },
    root_markers = { '*.py', '.git' },
})

vim.lsp.config('c-sharp', {
    cmd = { 'omnisharp' },
    filetypes = { 'cs', "csharp" },
    root_markers = { '*.sln', '*.csproj', '.git'}
})

vim.lsp.config('jsonls', {
    cmd = { 'vscode-json-languageserver', '--stdio' },
    filetypes = { 'json', 'jsonc', 'config', 'bonfire', 'ember' },
    root_markers = { '.git' },
})

vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
})

vim.lsp.config('luals', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.git', '*.lua' },
})

vim.lsp.config('cmakels', {
    cmd = { 'cmake-language-server' },
    filetypes = { 'cmake' },
    root_markers = { 'CMakeLists.txt', '.git' },
})

vim.lsp.config('markdownls', {
    cmd = { 'marksman' },
    filetypes = { 'md' },
    root_markers = { '*.md', '.git' },
})

vim.lsp.config('bashls', {
    cmd = { 'bash-language-server' },
    filetypes = { '.sh' },
    root_markers = { '*.sh', '.git' },
})

vim.lsp.enable('zls')
vim.lsp.enable('pylsp')
vim.lsp.enable('c-sharp')
vim.lsp.enable('jsonls')
vim.lsp.enable('clangd')
vim.lsp.enable('luals')
vim.lsp.enable('cmakels')
vim.lsp.enable('markdownls')
vim.lsp.enable('bashls')

vim.keymap.set('n', '<leader>w', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>e', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.goto_prev)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>t', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>y', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>u', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-r>', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<C-e>', vim.lsp.buf.code_action, opts)
        vim.keymap.set('i', '<C-t>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<C-p>', function() vim.lsp.buf.format({ async = true }) end, opts)
        vim.keymap.set('n', '<C-h>', vim.lsp.buf.workspace_symbol, opts)
    end
})
-- // end lsp

-- || git || - fugitive commands bound to leader keys
vim.pack.add({ 'https://github.com/tpope/vim-fugitive' })

vim.keymap.set('n', '<leader>gs', ':Git<CR>')
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
vim.keymap.set('n', '<leader>gd', ':Git diff<CR>')
vim.keymap.set('n', '<leader>gl', ':Git log<CR>')
vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
vim.keymap.set('n', '<leader>gP', ':Git pull<CR>')
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
-- // end git

-- || gitsigns || - git change indicators in the sign column
vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

require('gitsigns').setup()

vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#39cc9b' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#6dacdb' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#c191ff' })
-- // end gitsigns

-- || inline diff || - character-level git diff shown inline
vim.pack.add({ 'https://github.com/YouSame2/inlinediff-nvim' })

require('inlinediff').setup()

vim.keymap.set('n', '<leader>gi', function() require('inlinediff').toggle() end)
-- // end inline diff

-- || commentary || - comment and uncomment lines with gc
vim.pack.add({ 'https://github.com/tpope/vim-commentary' })
-- // end commentary

-- || autopairs || - auto-close brackets and quotes
vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' })

require('nvim-autopairs').setup()
-- // end autopairs

-- || sandwich || - add, change, delete surrounding characters
vim.pack.add({ 'https://github.com/machakann/vim-sandwich' })
-- // end sandwich

-- || multicursor || - multiple cursor editing and keymaps
vim.pack.add({ 'https://github.com/jake-stewart/multicursor.nvim' })

local mc = require('multicursor-nvim')
mc.setup()

local set = vim.keymap.set
set({"n", "x"}, "<c-up>", function() mc.lineAddCursor(-1) end)
set({"n", "x"}, "<c-down>", function() mc.lineAddCursor(1) end)
set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
set("n", "<c-leftmouse>", mc.handleMouse)
set("n", "<c-leftdrag>", mc.handleMouseDrag)
set("n", "<c-leftrelease>", mc.handleMouseRelease)
set({"n", "x"}, "<c-q>", mc.toggleCursor)

mc.addKeymapLayer(function(layerSet)
    layerSet({"n", "x"}, "<c-left>", mc.prevCursor)
    layerSet({"n", "x"}, "<c-right>", mc.nextCursor)
    layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)
-- // end multicursor

-- || treesitter || - syntax parsing for highlighting and more
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

require('nvim-treesitter').setup()
-- // end treesitter

-- || render markdown || - improved markdown rendering in buffers
vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
-- // end render markdown

-- || asyncrun || - run shell commands asynchronously
vim.pack.add({ 'https://github.com/skywind3000/asyncrun.vim' })
-- // end asyncrun

-- || vista || - tag and symbol viewer sidebar
vim.pack.add({ 'https://github.com/liuchengxu/vista.vim' })
-- // end vista

-- || tmux || - tmux pane navigation integration
vim.pack.add({ 'https://github.com/aserowy/tmux.nvim' })
-- // end tmux

-- || mason || - installer for LSP servers and tools
vim.pack.add({ 'https://github.com/mason-org/mason.nvim' })

require("mason").setup()
-- // end mason

-- || file explorer || - neo-tree sidebar and its dependencies
vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons' })

vim.pack.add({ 'https://github.com/MunifTanjim/nui.nvim' })

vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' })

vim.pack.add({ 'https://github.com/nvim-neo-tree/neo-tree.nvim' })

require('neo-tree').setup({
    window = {
        width = 30
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false
        },
        window = {
            mappings = {
                ['<Right>'] = 'open',
                ['<Left>'] = 'close_node'
            }
        }
    }
})

vim.keymap.set('n', '<C-n>', '<cmd>Neotree toggle<CR>')
vim.keymap.set('n', '<M-n>', '<cmd>Neotree focus<CR>')
-- // end file explorer

-- || auto-session || - save and restore sessions per cwd
vim.pack.add({ 'https://github.com/rmagatti/auto-session' })

vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

require('auto-session').setup({
    suppressed_dirs = { '~/', '~/Downloads', '/' },
    pre_save_cmds = { 'Neotree close' },
    post_save_cmds = { 'Neotree show' },
    post_restore_cmds = { 'Neotree show' }
})
-- // end auto-session

-- || flutter tools || - flutter and dart dev commands over the native lsp
vim.pack.add({ 'https://github.com/nvim-flutter/flutter-tools.nvim' })

require('flutter-tools').setup({
    lsp = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        on_attach = function(_, bufnr)
            local o = { buffer = bufnr }
            vim.keymap.set('n', '<C-j>', '<cmd>FlutterRun<CR>', o)
            vim.keymap.set('n', '<C-l>', '<cmd>FlutterReload<CR>', o)
            vim.keymap.set('n', '<C-k>', '<cmd>FlutterRestart<CR>', o)
            vim.keymap.set('n', '<C-y>', '<cmd>FlutterQuit<CR>', o)
            vim.keymap.set('n', '<C-g>', '<cmd>FlutterDevices<CR>', o)
        end
    }
})
-- // end flutter tools

-- || lualine || - statusline with mode, branch, filename, filetype
vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

require('lualine').setup({
    options = {
        theme = {
            normal = {
                a = { bg = purple, fg = '#1c1e24', gui = 'bold' },
                b = { bg = bg, fg = '#bdbdbd' },
                c = { bg = bg, fg = '#bdbdbd' }
            },
            insert = {
                a = { bg = purple, fg = '#1c1e24', gui = 'bold' },
                b = { bg = bg, fg = '#bdbdbd' },
                c = { bg = bg, fg = '#bdbdbd' }
            },
            visual = {
                a = { bg = purple, fg = '#1c1e24', gui = 'bold' },
                b = { bg = bg, fg = '#bdbdbd' },
                c = { bg = bg, fg = '#bdbdbd' }
            },
            replace = {
                a = { bg = purple, fg = '#1c1e24', gui = 'bold' },
                b = { bg = bg, fg = '#bdbdbd' },
                c = { bg = bg, fg = '#bdbdbd' }
            },
            command = {
                a = { bg = purple, fg = '#1c1e24', gui = 'bold' },
                b = { bg = bg, fg = '#bdbdbd' },
                c = { bg = bg, fg = '#bdbdbd' }
            },
            inactive = {
                a = { bg = bg, fg = '#585858' },
                b = { bg = bg, fg = '#585858' },
                c = { bg = bg, fg = '#585858' }
            }
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = {},
        lualine_z = {}
    }
})
-- // end lualine

-- || bufferline || - buffer tabs across the top
vim.pack.add({ 'https://github.com/akinsho/bufferline.nvim' })

require('bufferline').setup({
    options = {
        max_name_length = 20
    }
})
-- // end bufferline

-- || clipboard history || - neoclip yank history via telescope
vim.pack.add({ 'https://github.com/nvim-telescope/telescope.nvim' })

vim.pack.add({ 'https://github.com/AckslD/nvim-neoclip.lua' })

require('neoclip').setup()
require('telescope').load_extension('neoclip')
-- // end clipboard history

-- || terminal || - toggleable terminal at nvim's cwd
vim.pack.add({ 'https://github.com/akinsho/toggleterm.nvim' })

require('toggleterm').setup({
    start_in_insert = true
})

local function toggle_terminal()
    local term = require('toggleterm.terminal').get(1)
    if term and term:is_open() then
        local pid = vim.fn.jobpid(term.job_id)
        local handle = io.popen('pgrep -P ' .. pid)
        local children = handle and handle:read('*a') or ''
        if handle then handle:close() end
        if children ~= '' then
            local choice = vim.fn.confirm('A process is running in the terminal. Kill it and close?', '&Yes\n&No', 2)
            if choice ~= 1 then
                return
            end
            for child_pid in children:gmatch('%d+') do
                vim.fn.system('kill ' .. child_pid)
            end
        end
    end
    vim.cmd('ToggleTerm')

    vim.schedule(function()
        term = require('toggleterm.terminal').get(1)
        if term and term:is_open() then
            vim.cmd('startinsert')
        end
    end)
end

vim.keymap.set({'n', 'i', 't'}, '<C-\\>', toggle_terminal)

vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.wo.winhighlight = 'Normal:TerminalNormal'
    end
})
-- // end terminal

-- || neoscroll || - smooth animated scrolling for jump commands
vim.pack.add({ 'https://github.com/karb94/neoscroll.nvim' })

require('neoscroll').setup()
-- // end neoscroll

-- || theme || - colorscheme and highlight group overrides
vim.pack.add({ 'https://github.com/sainnhe/gruvbox-material' })
vim.pack.add({ 'https://github.com/sainnhe/edge' })
vim.pack.add({ 'https://github.com/catppuccin/nvim' })
vim.pack.add({ 'https://github.com/NTBBloodbath/doom-one.nvim' })

vim.o.background = 'dark'
vim.g.edge_style = 'default'
vim.cmd.colorscheme('doom-one')

vim.api.nvim_set_hl(0, 'Number', { fg = '#ed94c0' })
vim.api.nvim_set_hl(0, 'Float', { fg = '#ed94c0' })
vim.api.nvim_set_hl(0, 'Special', { fg = '#ed94c0' })
vim.api.nvim_set_hl(0, 'SpecialChar', { fg = '#ed94c0' })

vim.api.nvim_set_hl(0, 'Comment', { fg = '#585858', italic = true })
vim.api.nvim_set_hl(0, 'String', { fg = '#6dacdb' })
vim.api.nvim_set_hl(0, 'Character', { fg = '#6dacdb' })
vim.api.nvim_set_hl(0, 'Boolean', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Conditional', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Repeat', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Exception', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Include', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Define', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Macro', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'PreProc', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'StorageClass', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Structure', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Statement', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, 'Type', { fg = '#ad99fc' })
vim.api.nvim_set_hl(0, 'Typedef', { fg = '#ad99fc' })
vim.api.nvim_set_hl(0, 'Function', { fg = '#39cc9b' })
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#bdbdbd' })
vim.api.nvim_set_hl(0, 'Constant', { fg = '#66c3cc', bold = true })
vim.api.nvim_set_hl(0, 'Operator', { fg = '#bdbdbd' })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#bdbdbd' })
vim.api.nvim_set_hl(0, 'Tag', { fg = '#ad99fc' })
vim.api.nvim_set_hl(0, 'Label', { fg = '#f0f0f0', bold = true })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#2a2d37' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#22242c' })

vim.api.nvim_set_hl(0, 'Normal', { bg = bg })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = bg })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = bg })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = bg })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = bg })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = purple, bg = bg })
vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = bg })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = bg })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#585858', bg = bg })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#f0f0f0', bg = bg })

vim.api.nvim_set_hl(0, '@comment', { fg = '#585858', italic = true })
vim.api.nvim_set_hl(0, '@string', { fg = '#6dacdb' })
vim.api.nvim_set_hl(0, '@number', { fg = '#ed94c0' })
vim.api.nvim_set_hl(0, '@boolean', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@keyword', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@keyword.function', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@keyword.return', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@keyword.operator', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@conditional', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@repeat', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@operator', { fg = '#bdbdbd' })
vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#bdbdbd' })
vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#bdbdbd' })
vim.api.nvim_set_hl(0, '@type', { fg = '#ad99fc' })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = '#ad99fc' })
vim.api.nvim_set_hl(0, '@storageclass', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@namespace', { fg = '#ad99fc' })
vim.api.nvim_set_hl(0, '@function', { fg = '#39cc9b' })
vim.api.nvim_set_hl(0, '@function.call', { fg = '#39cc9b' })
vim.api.nvim_set_hl(0, '@function.builtin', { fg = '#39cc9b' })
vim.api.nvim_set_hl(0, '@method', { fg = '#39cc9b' })
vim.api.nvim_set_hl(0, '@method.call', { fg = '#39cc9b' })
vim.api.nvim_set_hl(0, '@constructor', { fg = '#39cc9b' })
vim.api.nvim_set_hl(0, '@variable', { fg = '#bdbdbd' })
vim.api.nvim_set_hl(0, '@variable.builtin', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@parameter', { fg = '#bdbdbd' })
vim.api.nvim_set_hl(0, '@field', { fg = '#ad99fc' })
vim.api.nvim_set_hl(0, '@property', { fg = '#ad99fc' })
vim.api.nvim_set_hl(0, '@constant', { fg = '#66c3cc', bold = true })
vim.api.nvim_set_hl(0, '@constant.builtin', { fg = '#66c3cc', bold = true })
vim.api.nvim_set_hl(0, '@preproc', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@include', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@macro', { fg = '#6c95eb' })
vim.api.nvim_set_hl(0, '@label', { fg = '#f0f0f0', bold = true })
vim.api.nvim_set_hl(0, '@tag', { fg = '#ad99fc' })
-- // end theme

-- || terminal || - highlight override for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.wo.winhighlight = 'Normal:TerminalNormal'
    end
})
-- // end terminal

-- || general keymaps || - core remaps not tied to a plugin
vim.keymap.set('n', '<M-v>', '<C-v>')
vim.keymap.set('n', '<M-x>', '<C-x>')
vim.keymap.set('n', '<M-z>', '<C-z>')
vim.keymap.set('n', '<M-b>', '<C-b>')

vim.keymap.set({'n', 'v'}, '<C-s>', '<cmd>write<CR>')
vim.keymap.set('i', '<C-s>', '<Esc><cmd>write<CR>a')
vim.keymap.set('v', '<C-s>', '<Cmd>w<CR>')

vim.keymap.set({ 'v', 's' }, '<C-S-c>', '"+y')
vim.keymap.set('i', '<C-S-v>', '<C-r>+')
vim.keymap.set('n', '<C-S-v>', '"+p')
vim.keymap.set('v', '<C-S-v>', '"+p')

vim.keymap.set('v', '<C-x>', '"+d')

vim.keymap.set('n', '<C-z>', 'u')
vim.keymap.set('i', '<C-z>', function()
    vim.cmd('undo')
end)
vim.keymap.set('n', '<C-b>', '<C-r>')
vim.keymap.set('i', '<C-b>', function()
    vim.cmd('redo')
end)
-- // end general keymaps

-- || options || - core editor settings
local opt = vim.opt

opt.number = true
opt.signcolumn = "yes:1"
opt.termguicolors = true
opt.scrolloff = 4

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.ignorecase = true
opt.smartcase = true

opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 500
opt.autoread = true
-- // end options