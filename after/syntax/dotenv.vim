" Basic syntax for .env files by reusing sh syntax
if exists("b:current_syntax")
  finish
endif

" Reuse Vim's built-in shell syntax highlighting
runtime! syntax/sh.vim

" Mark this buffer as having dotenv syntax (after loading sh rules)
let b:current_syntax = "dotenv"

