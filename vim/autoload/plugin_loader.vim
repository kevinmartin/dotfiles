function! plugin_loader#Load()
  " Install vim-plug if not already.
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  " Begin loading plugins.
  call plug#begin('~/.vim/plugged')

  " Automatically install missing plugins on startup.
  " https://github.com/junegunn/vim-plug/issues/212#issuecomment-92159417
  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
    autocmd VimEnter * PlugInstall | q
  endif

  if !exists('g:bundles')
    call lib#SourceDirectory('~/.vim/plugins.d/')
    call lib#SourceIfExists('~/.vim/plugins.vim')
  else
    for fpath in g:bundles
      call lib#SourceIfExists(fpath)
    endfor
  endif

  call plug#end()
endfunction
