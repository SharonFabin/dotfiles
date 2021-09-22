set clipboard=unnamedplus
set nu
set rnu
set paste
set ignorecase
filetype plugin indent on

":augroup numbertoggle
":  autocmd!
":  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
":  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
":augroup END

nmap 0 ^
nnoremap <CR> :noh<CR><CR>
" set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set nojoinspaces
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

set laststatus=2
set noshowmode
colorscheme codedark
let g:lightline = {
      \ 'colorscheme': 'codedark',
      \ }

    
