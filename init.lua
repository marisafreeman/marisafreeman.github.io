vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.mouse = 'a'

vim.cmd('syntax enable')

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.undofile = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({'n', 'v', 'i'}, '<Up>', '<Nop>')
vim.keymap.set({'n', 'v', 'i'}, '<Down>', '<Nop>')
vim.keymap.set({'n', 'v', 'i'}, '<Left>', '<Nop>')
vim.keymap.set({'n', 'v', 'i'}, '<Right>', '<Nop>')

vim.cmd('colorscheme vim')
