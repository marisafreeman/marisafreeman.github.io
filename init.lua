local opts = { noremap = true, silent = true }

vim.keymap.set({'n', 'v', 'o'}, '<Up>', '<Nop>', opts)
vim.keymap.set({'n', 'v', 'o'}, '<Down>', '<Nop>', opts)
vim.keymap.set({'n', 'v', 'o'}, '<Left>', '<Nop>', opts)
vim.keymap.set({'n', 'v', 'o'}, '<Right>', '<Nop>', opts)

vim.keymap.set({'n', 'v', 'o'}, 'j', 'h', opts)
vim.keymap.set({'n', 'v', 'o'}, 'k', 'j', opts)
vim.keymap.set({'n', 'v', 'o'}, 'i', 'k', opts)
vim.keymap.set('n', 'h', 'i', opts)

vim.cmd('colorscheme vim')
