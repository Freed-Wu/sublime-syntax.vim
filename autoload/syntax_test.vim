""
" @section Introduction, intro
" @library
" <doc/@plugin(name).txt> is generated by <https://github.com/google/vimdoc>.
" See <README.md> for more information.

""
" Initial. Check 'filetype' and lazy load |syntax_test#main#init()|.
function! syntax_test#init() abort
  if split(&filetype, '\.')[0] ==# 'syntax-test'
    return
  endif
  if &filetype ==# ''
    filetype detect
    if &filetype ==# ''
      return
    endif
  endif
  call syntax_test#main#init()
endfunction