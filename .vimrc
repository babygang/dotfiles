set number
if has('vim_starting')
    set nocompatible               " be iMproved
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'rking/ag.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'slim-template/vim-slim'


"NeoBundle 'alpaca-tc/alpaca_tags'
"NeoBundle 'AndrewRadev/switch.vim'
"NeoBundle 'bbatsov/rubocop'
NeoBundle "kana/vim-smartinput"
NeoBundle "cohama/vim-smartinput-endwise"
NeoBundle "taglist.vim"
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/emmet-vim'

" colors
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/rdark'
NeoBundle 'posva/vim-vue'
NeoBundle 'digitaltoad/vim-pug'
NeoBundle 'dNitro/vim-pug-complete'
call neobundle#end()


filetype plugin indent on " required!

" for pbcopy
let s:is_mac = (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')
if s:is_mac
    vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
    nmap <Space><C-v> :call setreg("\"",system("pbpaste"))<CR>p
endif

" for NeoSnippet
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" for vim-smartinput-endwise
call smartinput_endwise#define_default_rules()

" for taglist.vim
set tags=~/.tags
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags" " ctagsのコマンド
let Tlist_Show_One_File = 1                  " 現在表示中のファイルのみのタグしか表示しない
let Tlist_Use_Right_Window = 1               " 右側にtag listのウインドうを表示する
let Tlist_Exit_OnlyWindow = 1                " taglistのウインドウだけならVimを閉じる
" map <silent> <leader>l :TlistToggle<CR>    " \lでtaglistウインドウを開いたり閉じたり出来るショートカット"

" Utility
map <S-w> <C-w>w
set tabstop=2
set shiftwidth=2
set expandtab

colorscheme torte
syntax enable

highlight SpecialKey term=underline ctermfg=red guifg=red
highlight Comment ctermfg=lightyellow
set list
set listchars=tab:^\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set directory=~/.vim/tmp

let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" for vim-vue
autocmd FileType vue syntax sync fromstart

"===========================================
"" quickrun settings
"===========================================
let g:quickrun_config = {}

" すべてのファイルタイプで vimproc をつかってコマンドを実行する
let g:quickrun_config._ = {'runner' : 'vimproc', "runner/vimproc/updatetime" : 10, "outputter/buffer/split" : ":botright 10sp"}

" ruby.rspec というファイルタイプのとき、下のようにコマンドを実行する
" " bundle exec rspec FILE_NAME
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec', 'exec': 'bundle exec %c', 'cmdopt': '-cfd', 'output_filetype': 'rspec-result'}

" 新規ファイル/開くファイルの名前が ~_spec.rb のとき、ファイルタイプをruby.rspec にする
augroup QRunRSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

nnoremap [quickrun] <Nop>
nmap <Space>. [quickrun]
nnoremap <silent> [quickrun] :call QRunRspecCurrentLine()<CR>
fun! QRunRspecCurrentLine()
  let line = line(".")
  exe ":QuickRun -exec 'bundle exec %c %s%o' -cmdopt ':" . line . " -cfd'"
endfun

" <C-[> でquickrunを停止
" normalModeでのdeleteできなくなるので一旦コメントアウト
" nnoremap <expr><silent> <C-[> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-[>"

" normal モードのとき ,t で QuickRun を実行（rspec の場合はテストを実行）
nnoremap <Space>t :<C-u>QuickRun<CR>

set backspace=indent,eol,start


" for .vimrc.local
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
