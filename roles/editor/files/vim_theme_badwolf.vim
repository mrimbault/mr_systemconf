" File defining and configuring Vim color scheme to be sourced.
"
" Cleanup previous color scheme.
highlight clear

" badwolf color scheme
"----------------------
" Syntax highlighting color scheme plugin.
" Dark mode only, also provides one monochrom high contrast scheme (goodwolf).
" Source: https://github.com/sjl/badwolf/
"
" Make the gutters darker than the background.
let g:badwolf_darkgutter = 1
"
" Set background type.
set background=dark
"
" Select color scheme.
colorscheme badwolf

" Select airline statusbar theme.
let g:airline_theme = 'badwolf'

" Explicitely specify colors not included on badwolf scheme.
hi! CursorLineNr term=bold ctermfg=214 gui=bold guifg=#ffa724
hi! WildMenu term=reverse cterm=bold ctermfg=16 ctermbg=221 gui=bold guifg=#000000 guibg=#fade3e

" FIXME the following are too bright when using badwolf airline theme ...
" change them?
"hi airline_z ctermfg=232 ctermbg=154 guifg=#141413 guibg=#aeee00
"hi airline_z_bold term=bold cterm=bold ctermfg=232 ctermbg=154 gui=bold guifg=#141413 guibg=#aeee00
"hi airline_z_red ctermfg=196 ctermbg=154 guifg=#ff2c4b guibg=#aeee00
"hi airline_a ctermfg=232 ctermbg=154 guifg=#141413 guibg=#aeee00
"hi airline_a_bold term=bold cterm=bold ctermfg=232 ctermbg=154 gui=bold guifg=#141413 guibg=#aeee00
"hi airline_a_red ctermfg=196 ctermbg=154 guifg=#ff2c4b guibg=#aeee00
"hi airline_tabsel ctermfg=232 ctermbg=154 guifg=#141413 guibg=#aeee00
"hi airline_z_to_airline_warning guifg=#df5f00 guibg=#aeee00
"hi airline_z_to_airline_warning_bold term=bold cterm=bold gui=bold guifg=#df5f00 guibg=#aeee00
"hi airline_z_to_airline_warning_red ctermfg=196 guifg=#ff2c4b guibg=#aeee00


