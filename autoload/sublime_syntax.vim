""
" @section Introduction, intro
" @library
" <doc/@plugin(name).txt> is generated by <https://github.com/google/vimdoc>.
" See <README.md> for more information about installation and screenshots.
"
" Note: if you use |indentLine|, remember: >
"     let g:indentLine_fileTypeExclude = ['syntax_test']
" <
" If you use |coc-diagnostic|, remember: >
"     {
"       "diagnostic-languageserver": {
"         "filetypes": {
"           "syntax_test": "syntest"
"         }
"       }
"     }
" <
" If you use |coc-nvim|, remember: >
"     let g:coc_filetype_map = {
"           \ 'sublime_syntax': 'yaml',
"           \ }
" <

""
" Update cache.
function! sublime_syntax#update_cache() abort
  let l:cmd = 'python sys.argv = ' . string(['-c', s:cache])
  execute l:cmd
  silent execute 'pyfile' s:pyfile
endfunction

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let s:pyfile = s:path . '/rplugin/python3/sublime_syntax/__main__.py'
if exists('*stdpath')
  let s:cache_dir_home = stdpath('cache')
else
  let s:cache_dir_home = $HOME . '/.cache/nvim'
endif
let s:cache_dir = s:cache_dir_home . '/sublime-syntax.vim'
call mkdir(s:cache_dir, 'p')
let s:cache = s:cache_dir . '/sublime-syntax.json'
try
  let s:items = json_decode(readfile(s:cache)[0])
catch /\v^Vim%(\(\a+\))?:E(684|484|491):/
  call sublime_syntax#update_cache()
  let s:items = json_decode(readfile(s:cache)[0])
endtry

""
" @section Configuration, config

function! s:Flag(name, default) abort
  let l:scope = get(split(a:name, ':'), 0, 'g:')
  let l:name = get(split(a:name, ':'), -1)
  let g:{name} = get({l:scope}:, l:name, a:default)
endfunction

let s:plugin = {'Flag': funcref('s:Flag')}
""
" Completion cache path.
call s:plugin.Flag('g:sublime_syntax#cache', s:cache)
""
" Completion cache contents.
"
" www.sublimetext.com/docs/scope_naming.html
call s:plugin.Flag('g:sublime_syntax#items', s:items)