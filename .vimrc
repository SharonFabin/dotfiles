set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <Space> <Space><C-g>
nmap 0 ^
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set nojoinspaces
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif