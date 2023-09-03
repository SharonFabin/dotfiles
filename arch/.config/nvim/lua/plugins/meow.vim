
" GitHub Dark Default color scheme for Neovim

" Color Definitions
let s:fg = '#c9d1d9'
let s:bg = '#0d1117'
let s:fg_dark = '#8b949e'
let s:bg_dark = '#161b22'
let s:fg_light = '#f0f6fc'
let s:bg_light = '#0d1117'
let s:accent1 = '#6e7681'
let s:accent2 = '#58a6ff'
let s:accent3 = '#17a0ff'
let s:accent4 = '#9ecbff'
let s:accent5 = '#f9826c'
let s:accent6 = '#ffea7f'
let s:accent7 = '#a9a9a9'
let s:accent8 = '#b072d1'

" Vim editor colors
highlight Normal guifg=NONE guibg=s:bg
highlight NonText guifg=NONE guibg=s:bg
highlight LineNr guifg=s:fg_dark guibg=s:bg
highlight CursorLineNr guifg=s:fg_light guibg=s:bg
highlight VertSplit guifg=s:bg_dark guibg=s:bg
highlight StatusLine guifg=s:fg_light guibg=s:bg_dark gui=underline
highlight StatusLineNC guifg=s:fg_dark guibg=s:bg_dark gui=underline
highlight Pmenu guifg=s:fg guibg=s:bg_light
highlight PmenuSel guifg=s:fg_light guibg=s:accent2
highlight Visual guifg=NONE guibg=s:accent2

" Syntax highlighting
highlight Comment guifg=s:fg_dark gui=italic
highlight Constant guifg=s:accent5
highlight String guifg=s:accent4
highlight Identifier guifg=s:fg_light
highlight Function guifg=s:accent2
highlight Statement guifg=s:accent3
highlight PreProc guifg=s:accent6
highlight Type guifg=s:accent2
highlight Special guifg=s:accent7
highlight Keyword guifg=s:accent2
highlight Error guifg=s:accent5 guibg=s:bg

" Search highlighting
highlight Search guifg=NONE guibg=s:accent3 gui=bold

" Line numbers
highlight LineNr guifg=s:fg_dark
highlight CursorLineNr guifg=s:fg_light
highlight LineNr guifg=s:fg_dark
highlight CursorLineNr guifg=s:fg_light

" Tab line
highlight TabLineFill guifg=NONE guibg=s:bg_dark

" Cursor
highlight Cursor guifg=NONE guibg=s:accent2 gui=reverse
highlight iCursor guifg=NONE guibg=s:accent2 gui=reverse

" Status line
highlight StatusLineNC guifg=s:fg_dark guibg=s:bg_dark gui=underline
highlight StatusLine guifg=s:fg_light guibg=s:bg_dark gui=underline

" Completion menu
highlight PmenuSel guifg=s:fg_light guibg=s:accent2
highlight Pmenu guifg=s:fg guibg=s:bg_light

" Diff highlighting
highlight DiffAdd guifg=NONE guibg=s:accent6
highlight DiffChange guifg=NONE guibg=s:accent3
highlight DiffDelete guifg=NONE guibg=s:accent5
highlight DiffText guifg=NONE guibg=s:accent4

" GitGutter highlighting
highlight GitGutterAdd guifg=NONE guibg=s:accent6
highlight GitGutterChange guifg=NONE guibg=s:accent3
highlight GitGutterDelete guifg=NONE guibg=s:accent5

" GitSigns highlighting
highlight SignColumn guifg=NONE guibg=s:bg_dark
highlight GitSignsAdd guifg=NONE guibg=s:accent6
highlight GitSignsChange guifg=NONE guibg=s:accent3
highlight GitSignsDelete guifg=NONE guibg=s:accent5

" Markdown headings
highlight markdownHeadingDelimiter guifg=s:fg_light

" Rainbow parentheses
highlight RainbowCol1 guifg=s:accent2
highlight RainbowCol2 guifg=s:accent3
highlight RainbowCol3 guifg=s:accent4
highlight RainbowCol4 guifg=s:accent5
highlight RainbowCol5 guifg=s:accent6
highlight RainbowCol6 guifg=s:accent7
highlight RainbowCol7 guifg=s:accent8

" MatchParen
highlight MatchParen guifg=NONE guibg=s:accent2 gui=bold

" LSPDiagnostics
highlight LspDiagnosticsDefaultError guifg=s:accent5
highlight LspDiagnosticsDefaultWarning guifg=s:accent6
highlight LspDiagnosticsDefaultInformation guifg=s:accent3
highlight LspDiagnosticsDefaultHint guifg=s:accent4

" LSP SignatureHelp
highlight LspSignatureActiveParameter guifg=s:accent6 gui=bold

" Coc.nvim
highlight CocHintSign guifg=s:accent4 guibg=NONE
highlight CocErrorSign guifg=s:accent5 guibg=NONE
highlight CocWarningSign guifg=s:accent6 guibg=NONE

" NvimTree
highlight NvimTreeFolderIcon guifg=s:accent3
highlight NvimTreeGitDirty guifg=s:accent5
highlight NvimTreeGitStaged guifg=s:accent2
highlight NvimTreeGitMerge guifg=s:accent6
highlight NvimTreeIndentMarker guifg=s:bg_dark

" Telescope
highlight TelescopeSelection guifg=NONE guibg=s:accent2
highlight TelescopeSelectionCaret guifg=s:accent2
highlight TelescopeMultiSelection guifg=s:accent3 guibg=s:bg_dark

" WhichKey
highlight WhichKey guifg=s:accent2
highlight WhichKeySeperator guifg=s:accent5
highlight WhichKeyGroup guifg=s:accent4

" Startify
highlight StartifyBracket guifg=s:fg_dark
highlight StartifyFile guifg=s:accent2
highlight StartifyNumber guifg=s:accent3

" GitBlame
highlight GitBlame guifg=s:accent5 guibg=NONE

" Indent Blankline
highlight IndentBlanklineChar guifg=s:bg_dark

" NERDTree
highlight NERDTreeDir guifg=s:accent2
highlight NERDTreeFile guifg=s:fg_light

" Custom highlight groups (you can add more as needed)
highlight CustomGroup1 guifg=s:accent1
highlight CustomGroup2 guifg=s:accent2
