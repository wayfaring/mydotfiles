"=========================================================="
"======             ~/.vimrc by Elmer Hsieh           ====="
"======             Last change:  2007 Mar 11         ====="
"=========================================================="
"
"--------------------------------------"
"-----     Encoding Setting       -----"
"--------------------------------------"
if has("multi_byte")"<<<
    " Set fileencoding priority
    if getfsize(expand("%")) > 0
        set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    else
        set fileencodings=cp936,big5,euc-jp,euc-kr,latin1
    endif

    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW""<<<
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    elseif v:lang =~ "^ko"">>>
        "Copied from someone's dotfile, untested
        set encoding=euc-kr
        set termencoding=euc-kr
        set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
        " Copied from someone's dotfile, unteste
        set encoding=euc-jp
        set termencoding=euc-jp
        set fileencoding=euc-jp
    endif

    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif">>>

"--------------------------------------"
"-----     Vim Settings           -----"
"--------------------------------------"
set nocompatible            " not compatible with vi, because this is Vim
set history=50              " keep 50 lines of command line history

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2
    syntax on
endif

colorscheme asmdev

set encoding=utf-8
set number

"***** file attributes
"set fileencoding=big5
set formatoptions=mtcql
set fileformats=unix,dos     " here setting 'dos' will not show  in the EOL
"set fileformat=unix         " dos(0x0D0A); unix(0x0A); mac(0x0D) to newline

set tags=cppcomplete.tags

" emulate 4 spaces to a tab, so press tab 2 times represents a real tabstop
set softtabstop=4
set tabstop=4

"set textwidth=40           " when in column 100, insert a NewLine(EOL)
set linebreak               " set warp on space or comma
set bs=2
set showmatch
set viminfo='20,\"50        " read/write a .viminfo file, don't store more
                            " than 50 lines of registers
                            "
" **** status line
set laststatus=2            " always show a status-bar.
set statusline=%<%t%h%m%r\ \ %a\ %{strftime(\"%c\")}%=0x%B\ 
                        \\ line:%l,\ \ col:%c%V\ %P

"set cmdheight=2
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

"set list
set listchars=eol:$,tab:>-,trail:- " setup shown characters when \set list\ in Vim

set showcmd                 " display incomplete commands


set grepprg=grep\ -nH\ $*   " grep options      

"set noscrollbind            " for vimdiff, not scroll up/down with the cursor

set showmode
"set nu                     " show line number

"set lbr "???
"set showbreak "???

filetype on
filetype plugin indent on

set completeopt=longest,menu

"***** vimdiff
set diffopt=iwhite,vertical

"***** split
set splitright

"set paste

"***** folding setting

" Don't use Ex mode, use Q for formatting
"map Q gq

"if has("vms")
"  set nobackup     " do not keep a backup file, use versions instead
"else
"  set backup       " keep a backup file
"endif

"******** text folding  ********
"set foldcolumn=2
set foldmethod=marker
set foldmarker=<<<,>>>
"*******************************

"******** C indentation ********
"
set cindent                 " enables automatic C program indenting
"set autoindent             " nice for writing code
"set smartindent
set shiftwidth  =4
"set expandtab               " expand TAB to SPACE, use "retab"
set cino        =:0g0t0(sus         " :0
"
"*******************************
"
"******** Vim interface ********
"
set ruler                   " show the cursor position all the time
"
"*******************************
"
"******** search setting *******
"
set ignorecase              " ignore uppercase/lowercase in searching
"set hlsearch               " highlight the search result
set incsearch               " do incremental searching
"
"*******************************
"
"
set previewheight   =8


"--------------------------------------"
"-----   abbreviation Settings    -----"
"space or CTRL-] to complete the action"
"--------------------------------------"
" for C/C++ Programming
iab #i #include
iab #d #define
iab re return
iab wh while
iab #b /***********************************************************
iab #e ***********************************************************/
iab #l /*--------------------------------------------------------*/
iab #c // ********************************************************@summary@param@return@retval@description@bug@history********************************************************
"iab @s @summary
"iab @p @param
"iab @r @return
"iab @r @retval
"iab @d @description
"iab @b @bug
"iab @h @history
"--------------------------------------"
"-----     Mouse Settings         -----"
"--------------------------------------"
"set mouse=a

"--------------------------------------"
"-----     Keyboard Settings      -----"
"--------------------------------------"
"*** Tabs management ***
"##go to next tab
map <C-n>l <ESC>:tabnext<CR>
"map <C-Right> <ESC>:tabnext<CR>
"map ^[[C :tabnext<CR> 
"##go to previous tab
map <C-n>h <ESC>:tabprev<CR>
"map <C-Left> <ESC>:tabprev<CR>
"map ^[[D :tabprev<CR>
"##open a new tab
map <C-n>t <ESC>:tabnew<cr>
"map <C-n>n <ESC>:tabnew<CR><ESC>:e
"##close the active tab
map <C-n>w <ESC>:tabclose<CR>
"##list opened tabs
"map <C-n>l <ESC>:tabs<CR>
"## save the file
map <C-n>s <ESC>:w<CR>

nnoremap ss :buffers <BAR> let i = input("Buffer number: ") <BAR> execute "buffer " . i <CR>

"*** Compiling and Executing ***
" setting makeprg could issue "make" in vim command mode
set makeprg=make

"this script use to excute make in vim and open quickfix window
"nmap B :call Do_make()<CR>
"nmap C :cclose<CR>
function Do_make()
"   let filename = bufname("%")
"   let suffix_pos = stridx(filename, ".c")
"   if suffix_pos == -1  
"       return 
"   else
"      let target = strpart(filename,0,suffix_pos)
"   endif
"   let target = "make " . target
" 
"   execute target
execute "make"
execute "copen"
endfunction 

function! Do_GDB()
execute "run macros/gdb_mappings.vim"
execute "set asm=0"
"execute "set gdbprg=/opt/montavista/pro/devkit/mips/mips2_fp_le/bin/mips2_fp_le-gdb"
execute "set gdbprg=gdb"
endfunction

function Do_make_t()
execute "make clean; make"
execute "copen"
endfunction

"map <F5> :copen<CR>:make<CR>
"imap <F5> <ESC>:copen<CR>:make<CR>
"map <C-F5><F5> :make clean; make<CR>
"imap <C-F5><F5> :make clean; make<CR>
"map <C-F5><F5> :copen<CR>:make clean; make<CR>
"imap <C-F5><F5> <ESC>:copen<CR>:make clean; make<CR>
"map <S-m> :cclose<CR>
"imap <S-m> <ESC>:cclose<CR>
"nmap <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR><CR>
"nmap <F2> <ESC> :w <CR> :set makeprg=make\ %<<CR> :make<CR> :copen<CR> 
nmap <F4> <ESC> :cclose <CR><CR>
nmap <F5> <ESC> :wa<CR> :echo "make all" <CR> :call Do_make()<CR><CR>
nmap <F6> <ESC> <CR> :call Do_GDB()<CR><CR>
nmap <C-m><F5> <ESC> :echo "make clean all <CR> :call Do_make_t()<CR><CR>

let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm <ESC> :WMToggle<CR>
"
"*******************************

"*** File Operations ***
"##Ctrl+w: close the file
"map <C-w> <ESC>:q<CR>
" f3: SHOw an underline to the active line
" map <F3> :set cursorline!<CR><Bar>:echo "Highlight active cursor line: " . strpart("OffOn", 3 * &cursorline, 3)<CR>
"nnoremap <silent> :set expandtab<CR> :retab<CR>
" F4
"map <F4> <ESC>:wq<CR>
" F5
"map <F5> <ESC>[[k"xy$``a :echo @x<CR>
" F7
map <F7> :if exists("syntax_on") <BAR>
    \   syntax off <BAR><CR>
    \ else <BAR>
    \   syntax enable <BAR>
    \ endif <CR>
" F8
map <F8> :set hls!<BAR>set hls?<CR>
" F10
nnoremap <silent><F10> :wincmd p<CR>


map <F10> <ESC>:read !date<CR>

" F11
map <F11> :%!xxd<CR>

map <F12> :%!xxd -r<CR>

"--------------------------------------"
"-----     Plugins Customerized   -----"
"--------------------------------------"
"*** Taglist customized ***
"let Tlist_Ctags_Cmd="/usr/bin/ctags"
"let Tlist_GainFocus_on_ToggleOpen=1
"let Tlist_Exit_OnlyWindow=0
"let Tlist_Auto_highlight_Tag= 1
""let Tlist_Ctags_Cmd="/usr/bin/ctags"
""let Tlist_Inc_Winwidth=0

" F9: Switch on/off TagList
nnoremap <silent><F9> :TlistToggle<CR>
" TagListTagName - Used for tag names
highlight MyTagListTagName gui=bold guifg=Black guibg=Orange
" TagListTagScope - Used for tag scope
highlight MyTagListTagScope gui=NONE guifg=Blue
" TagListTitle - Used for tag titles
highlight MyTagListTitle gui=bold guifg=DarkRed guibg=LightGray
" TagListComment - Used for comments
highlight MyTagListComment guifg=DarkGreen
" TagListFileName - Used for filenames
highlight MyTagListFileName gui=bold guifg=Black guibg=LightBlue
"let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Left_Window = 1 " split to the right side of the screen
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 0 " Close the taglist window when a file or tag is selected.
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 25
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber] 

"*** ctags.vim ***
":ctaGS starts the script
let g:ctags_path="/usr/bin/ctags"
let g:ctags_args='-I __declspec+'
let g:ctags_regenerate=0
let g:ctags_statusline=1

"*** minibufexpl.vim ***
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

"*** showmarks.vim   ***
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_enable = 1
" For marks a-z
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
" For marks A-Z
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
" For all other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
" For multiple marks on the same line.
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen 

"*** project.vim   ***
let g:proj_flags="imstvcg"


"*** autopreview.vim ***
let g:AutoPreview_enabled=0
let g:AutoPreview_allowed_filetypes=["c", "cpp", "java"]

set updatetime=1000

nnoremap <F3> <ESC>:AutoPreviewToggle<CR>
inoremap <F3> <ESC>:AutoPreviewToggle<CR> i
"***********************


"------------------------------------------------"
"-----     Auto Command           ---------------"
" autocmd [group] event pattern [nested] command "
"------------------------------------------------"
"autocmd BufEnter * cd %:p:h
augroup newFileDetection
autocmd CursorMovedI * call CheckFileType()
augroup END

autocmd newFileDetection

function CheckFileType()
    if exists("b:countCheck") == 0
        let b:countCheck = 0
    endif

    let b:countCheck += 1
    if &filetype == "" && b:countCheck > 20 && b:countCheck < 200
        filetype detect
    elseif b:countCheck >= 200 || &filetype != ""
        autocmd! newFileDetection
        augroup! newFileDetection
    endif
endfunction

autocmd BufWritePre,FileWritePre .vimrc mark s|call LastMod()|'s
function LastMod()
    let b:lastModline=line("$")

    execute "1," . b:lastModline . "g/^\" Last modified:/s/Last modified:.*/Last modified: " . strftime("%c")
endfunction

"autocmd BufEnter * lcd %:p:h
" always add the current file's directory to the path if not already there
"autocmd BufRead *
"      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
"      \ exec "set path-=".s:tempPath |
"      \ exec "set path+=".s:tempPath

"--------------------------------------"
"---   Syntax Color Settings      -----"
"--------------------------------------"

hi Comment      term=bold ctermfg=darkcyan
hi Constant     term=underline ctermfg=Red
hi Special      term=bold ctermfg=Magenta
hi SpecialKey   term=bold ctermfg=darkcyan
hi NonText      term=bold ctermfg=cyan
hi Identifier   term=underline ctermfg=cyan
hi Statement    term=bold ctermfg=Brown
hi PreProc      term=bold ctermfg=DarkYellow
hi Type         term=bold ctermfg=DarkGreen
hi Ignore       ctermfg=white
hi Error        term=reverse ctermbg=Red ctermfg=White
hi Todo         term=standout ctermbg=Yellow ctermfg=Red
hi Search       term=standout ctermbg=Yellow ctermfg=Black
hi ErrorMsg     term=reverse ctermbg=Red ctermfg=White
hi StatusLine   ctermfg=darkblue  ctermbg=gray
hi StatusLineNC ctermfg=brown   ctermbg=darkblue
hi TabLine      guifg=#90fff0 guibg=#2050d0     ctermfg=black ctermbg=white
hi TabLineSel   guifg=#90fff0 guibg=#2050d0     ctermfg=white ctermbg=LightMagenta
hi Function      term=bold ctermfg=Red

" Modeline  Customerized
" vim: set fdm=marker ts=4:
" Last modified: Thu 21 Apr 2011 03:17:41 PM CST
