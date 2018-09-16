" File defining and configuring Vim color scheme to be sourced.

" Cleanup previous color scheme.
highlight clear

" gruvbox color scheme
"----------------------
" syntax highlighting color scheme plugin
" dark and light modes, configurable contrast, italic support
" requires termguicolors
" Source: https://github.com/morhetz/gruvbox
"
" enable 24-bit colors
if has("termguicolors")
  " note that terminal emulator and terminal multiplexing (like screen or tmux)
  " must have support for 24-bit color
  set termguicolors
  " this configuration is required for termguicolor to work inside tmux, see
  " |xterm-true-color|
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif
"
" Enable italic (for comments, etc.), will not work on all terminals
let g:gruvbox_italic=1
" Set contrast for dark and light modes
"let g:gruvbox_contrast_dark="soft"
let g:gruvbox_contrast_dark="medium"
"let g:gruvbox_contrast_dark="hard"
"let g:gruvbox_contrast_light="soft"
"let g:gruvbox_contrast_light="medium"
let g:gruvbox_contrast_light="hard"
"
" set background type
set background=dark
"
" select color scheme
colorscheme gruvbox

" Select airline statusbar theme.
let g:airline_theme = 'gruvbox'
