" filetype indent plugin on " determine the type of a file based on its name
" syntax enable             " depends on filetype

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set hidden                " allow unsaved buffer to stay until vim closed
set showcmd               " show currently typed commands on Vim's last line
set ignorecase smartcase  " use case insensitive search, except when using capital letters
set copyindent autoindent " copy the previous indentation on autoindenting
set nobackup noswapfile   " don't use backup files with ~ and .swp
set ruler                 " display the cursor position on the buffer
set cursorline            " highlight line where the current cursor is in
set confirm               " raise confirmation instead failing unsaved buffer
set cmdheight=2           " set the command window height to 2 lines
set scrolloff=10
"set relativenumber        " display line relative numbers on the left
set number relativenumber
set nu rnu
set guicursor&            " reset to default neovim value (somehow it was set to nothing by default on st)
set conceallevel=1        " conceal text with appropriate conceal characeter
set autowrite
set autoread
set shortmess+=c
set foldmethod=marker
set tagcase=followscs
"set list
"set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set completeopt+=noinsert,noselect
set completeopt-=preview
set shell=/usr/local/bin/zsh

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set mouse=nv
set termguicolors
set path=.

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" ------------------------
" Mapping: 
let mapleader = ','

" map space to run command fast
noremap <Space> :
nnoremap : ,

nnoremap <Leader>l :nohl<CR><C-l>

nnoremap <Leader>s :e $MYVIMRC<CR>
nnoremap <Leader>g :ls<CR>:b<Space>
nnoremap <Leader>r :source $MYVIMRC<CR>
" Delete characters inside "
nnoremap q ci"


nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap n nzzzv
nnoremap N Nzzzv

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

"noremap <silent> <F8> :Neomake! test<CR>
"noremap <silent> <F9> :Neomake! build<CR>
noremap <silent> <leader>b :Neomake build<CR>
noremap <silent> <leader>B :Neomake compile<CR>
noremap <silent> <leader>f :Neomake lint<CR> :e<CR>
"noremap <silent> <leader>r :! ./sane<CR>
noremap <silent> <leader>c :!cat % <bar> pbcopy<CR><CR>
noremap <silent> <leader>x :lclose<CR>
noremap <silent> <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

cnoremap w!! w !sudo tee % > /dev/null

command! Scratch vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile

" Autocommand: 
augroup focus_lost
    au!
    au FocusLost * :silent! wall
augroup END

augroup cursor_line
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

augroup close_quickfix_on_buffer_close
    autocmd!
    autocmd QuitPre * if &filetype !=# 'qf' | lclose | endif
augroup END

" Plugins Configurations: 
" ========================

" ------------------------
" vimplug 
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.cache/nvim-plugins')

Plug 'neomake/neomake'
" Plug 'sbdchd/neoformat'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/rainbow_parentheses.vim' " colorize parentheses
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', {'commit': '4145f53f3d343c389ff974b1f1a68eeb39fba18b'}
Plug 'tpope/vim-fugitive'
" Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
" Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'morhetz/gruvbox'
" Commenting/uncommenting stuff
Plug 'https://github.com/tpope/vim-commentary.git'
" Plug 'sheerun/vim-polyglot'
" Plug 'airblade/vim-rooter'
" "Plug 'fatih/vim-go'
" " themes
Plug 'itchyny/lightline.vim'

" Add plugins to &runtimepath
call plug#end()

" Plugins Configurations
" vim-plug
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pU :PlugUpgrade<CR>
nnoremap <Leader>pc :PlugClean<CR>
nnoremap <Leader>pi :PlugInstall<CR>

" ------------------------
" neoformat 
augroup neoformat
    autocmd!
augroup END
" ------------------------
"  Ruby
let g:loaded_ruby_provider = 0 
" ------------------------
"  python
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
" ------------------------
" neomake 
let g:neomake_open_list = 2
let g:neomake_error_sign = { 'text': '✗', 'texthl': 'NeomakeErrorSign' }
let g:neomake_warning_sign = { 'text': '‼', 'texthl': 'NeomakeWarningSign' }
func! Code(ops)
    execute "Neomake! " . a:ops
endfunc
" ------------------------
" neomake makers: competitive programming 
call neomake#configure#automake('w')
let g:neomake_cpp_enabled_makers = []
let s:neomake_cpp_maker_options = {
            \ 'common': [ '-DDEBUG', '-Wall', '-Wextra', '-pedantic', '-std=c++11', '-Wfloat-equal', '-Wconversion',
            \             '-Wlogical-op', '-Wshift-overflow=2', '-Wduplicated-cond', '-Wcast-qual', '-Wcast-align' ]
            \ }

let g:neomake_cpp_compile_maker = {
            \ 'exe': 'g++-10',
            \ 'args': s:neomake_cpp_maker_options.common + ['-D_GLIBCXX_DEBUG', '-D_GLIBCXX_DEBUG_PEDANTIC', '-D_FORTIFY_SOURCE=2',
            \          '-fsanitize=address', '-fsanitize=undefined', '-fno-sanitize-recover', '-fstack-protector',
            \          '-O2', '-o', 'sane' ],
            \ }
let g:neomake_cpp_build_maker = {
            \ 'exe': 'g++-10',
            \ 'args':  ['-std=c++11', '-o', 'sane' ],
            \ }
let g:neomake_cpp_lint_maker = {
            \ 'exe': 'clang-format',
            \ 'args': ['-i'],
            \ }

" ------------------------
" rainbow_parentheses 
augroup rainbow_parentheses
    autocmd FileType * RainbowParentheses
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [233, 234]

" ------------------------
" vim-easymotion 
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'hjklyuiopnm,qweasdzxcrtfgvb;r'
map <Leader><Leader> <Plug>(easymotion-prefix)
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)
map s <Plug>(easymotion-s2)
map ; <Plug>(easymotion-next)
map : <Plug>(easymotion-prev)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" Move to line
" map <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)
"
" " Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)

" ------------------------
" theme 
colorscheme gruvbox
hi link EasyMotionTarget EasyMotionTarget2FirstDefault

" ------------------------
" vim-lightline 
set noshowmode " use the one from lightline

function! LightlineNeomake()
    let bufnr = bufnr('%')
    let running_jobs = filter(copy(neomake#GetJobs()),
                \ "v:val.bufnr == bufnr  && !get(v:val, 'canceled', 0)")
    if empty(running_jobs)
        return '✓'
    else
        return '⟳ ' . join(map(running_jobs, 'v:val.name'), ', ')
    endif
endfunction

function! LightlineFugitive()
    return fugitive#head()
endfunction

function! LightlineGutentags()
    return gutentags#statusline()
endfunction

let g:lightline = {}
let g:lightline.enable = {
            \   'statusline': 1,
            \   'tabline':    0,
            \ }

let g:lightline.colorscheme = 'gruvbox'
let g:lightline.active = {
            \   'left':  [ [ 'mode', 'paste' ],
            \             [ 'filename', 'readonly', 'modified', ],
            \             [ 'fugitive',  'neomake' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ],
            \              [ 'gutentags' ] ]
            \ }

let g:lightline.component = {
            \   'readonly': '%{&filetype == "help" ? "" : &readonly ? "x" :""}',
            \   'modified': '%{&filetype == "help" ? "" : &modified ? "+" : &modifiable? "" : "-"}',
            \ }

let  g:lightline.component_expand = {
            \   'fugitive':  'LightlineFugitive',
            \   'neomake':   'LightlineNeomake',
            \   'gutentags': 'LightlineGutentags',
            \ }

let g:lightline.separator    = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

augroup lightline_update
    autocmd!
    autocmd User NeomakeJobStarted call lightline#update()
    autocmd User NeomakeJobFinished call lightline#update()
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

"---------nerdcommenter----
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

map <Leader>cc <Plug>NERDCommenterToggle


"----------FZF----------

let g:fzf_layout = { 'down': '~35%' }

"----------vim-terraform
"Allow vim-terraform to align settings automatically with Tabularize.

let g:terraform_align=1

"Allow vim-terraform to automatically fold (hide until unfolded) sections of terraform code. Defaults to 0 which is off.

let g:terraform_fold_sections=1

"Allow vim-terraform to automatically format *.tf and *.tfvars files with terraform fmt. You can also do this manually with the :TerraformFmt command.

let g:terraform_fmt_on_save=1


" ------------------------
