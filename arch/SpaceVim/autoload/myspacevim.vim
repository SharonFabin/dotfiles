function! myspacevim#before() abort
    let g:neomake_c_enabled_makers = ['clang']
    let g:spacevim_enable_statusline_display_mode = 1
    set clipboard=unnamedplus
    set paste 
    set ignorecase
    set incsearch     " do incremental searching
    set nojoinspaces
    set nu
    set rnu
    filetype plugin indent on
    nmap 0 ^
endfunction

function! myspacevim#after() abort
    " you can remove key binding in bootstrap_after function
    
endfunction

