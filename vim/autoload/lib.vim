" Function to source only if file exists.
function! lib#SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' expand(a:file)
  endif
endfunction

" Function to source all .vim files in directory.
function! lib#SourceDirectory(file)
  for s:fpath in split(globpath(a:file, '*.vim'), '\n')
    exe 'source' s:fpath
  endfor
endfunction
