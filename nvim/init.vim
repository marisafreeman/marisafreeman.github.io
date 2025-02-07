call plug#begin('~/.config/nvim/plugged')

" 在这里添加插件，例如：
Plug 'preservim/nerdtree'   " 文件树
Plug 'nvim-treesitter/nvim-treesitter'  " 更好的语法高亮

call plug#end()



" 显示行号
set number

" 开启语法高亮
syntax on

" 使用相对行号
set relativenumber

" 设定缩进
set tabstop=4       " 一个Tab显示为4个空格
set shiftwidth=4    " 自动缩进4个空格
set expandtab       " 用空格代替Tab

" 启用鼠标
set mouse=a

" 搜索高亮
set hlsearch
set incsearch

" 更好的文件编码
set encoding=utf-8
