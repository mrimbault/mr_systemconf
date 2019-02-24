" File defining and configuring Vim color scheme to be sourced.
"
" Cleanup previous color scheme.
highlight clear
" FIXME when theme is switched, italics become disabled?

" papercolor color scheme
"----------------------
" Syntax highlighting color scheme plugin.
" Source: https://github.com/NLKNguyen/papercolor-theme
"
" Set background type.
set background=light
"
" Select color scheme.
colorscheme PaperColor

" Select airline statusbar theme.
let g:airline_theme = 'papercolor'

