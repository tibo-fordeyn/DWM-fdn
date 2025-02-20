" Voeg ~/.local/bin toe aan het PATH binnen Vim
let $PATH = expand("~/.local/bin") . ':' . $PATH

" Remappings
let mapleader = ","
nnoremap j jzz
nnoremap k kzz
noremap G Gzz
noremap <leader>q :AutoSaveToggle<cr> " Toggle AutoSave
noremap <leader>ou :source<Space> " General source command
noremap <leader>e <C-w><C-w>
noremap <leader>z [s1z=
noremap <leader>P "+P
noremap <leader>f :Files<cr>
noremap <leader><leader> :b#<cr>

noremap <leader>c :cd %:p:h<cr>:pwd<cr>
noremap <leader><cr> o<Esc>
noremap <leader>z :wq<CR>
noremap <leader>h "+p
noremap <leader>o :put _<CR>j
nnoremap <leader>r <C-r>
noremap <leader>p :put! _<CR>
noremap <space>h <C-w>h
noremap <space>j <C-w>j
noremap <space>k <C-w>k
noremap <space>l <C-w>l
noremap <down> :resize +2<Cr>
noremap <up> :resize -2<cr>
noremap <right> :vertical resize +2<CR>
noremap <left> :vertical resize -2<CR>
inoremap qj <Esc>
vnoremap <leader>f zf
vnoremap <leader>y "*y :let @+=@*<cr>
noremap <Leader>k :w !xclip -selection clipboard<CR>:silent! redraw! <CR>
nnoremap <silent> <Leader>l :call SetSpellLang()<CR>:normal! mz:silent! spell<CR>z
nmap <leader>1 :bn<cr>
nmap <leader>2 :bp<cr>
nmap <leader>5 :call SpellToggle()<cr>
map <leader>lo :VimtexView<CR>
map <leader>co :VimtexCompile<CR>
map <leader>pi :PlugInstall<CR>
map <leader>pu :PlugUpdate<CR>

" scripts
nnoremap <Leader>pg :call system('/home/dyntif/.local/bin/generate_presentation.sh ' . shellescape(expand('%:p')))<CR>:echo "Presentation generated successfully!"<CR>
nnoremap <Leader>rg :call system('/home/dyntif/.local/bin/generate_report.sh ' . shellescape(expand('%:p')))<CR><CR>


nnoremap <leader>su :call system('~/.local/bin/symlink.sh')<CR>

nnoremap <leader>mc :w<CR>:silent! call system('~/.local/bin/manage-chapters.sh ' . shellescape(expand('%:p')) . ' > /dev/null 2>&1')<CR>:e!<CR>

" inkscape watch
nnoremap <Leader>iw :silent! !~/.local/bin/inkwatch.sh &<CR>:redraw!<CR>


map <leader>wi :VimwikiIndex<CR>
inoremap ³ <left>
inoremap ² <right>

" Anki mappings!
" nnoremap <leader>aa :!python3 ~/.local/share/anki-gen/scripts/aa.py %<CR>
nnoremap <leader>aa :call system('~/.local/share/anki-gen/scripts/aa.py ' . shellescape(expand('%')))<CR>
nnoremap <leader>as :call system('~/.local/share/anki-gen/scripts/as.py ' . shellescape(expand('%')))<CR>
nnoremap <leader>ad :call system('~/.local/share/anki-gen/scripts/ad.py ' . shellescape(expand('%')))<CR>
nnoremap <leader>ae :call system('~/.local/share/anki-gen/scripts/ae.py ' . shellescape(expand('%')))<CR>

" Function to surround selected text with Anki commands
function! SurroundWithAnki(command)
    let first_line = line("'<")
    let last_line = line("'>")
    " Insert command at the end of the line before the first selected line
    if first_line > 1
        let before_line = first_line - 1
        let prev_line = getline(before_line)
        call setline(before_line, prev_line . '\' . a:command . '{')
    else
        " If at the first line, insert at the beginning
        let curr_line = getline(first_line)
        call setline(first_line, '\' . a:command . '{' . curr_line)
    endif
    " Insert closing brace at the beginning of the line after the last selected line
    if last_line < line('$')
        let after_line = last_line + 1
        let next_line = getline(after_line)
        call setline(after_line, '}' . next_line)
    else
        " If at the last line, append a new line with '}'
        call append(line('$'), '}')
    endif
endfunction

" Mappings for Anki commands in visual mode
vnoremap <leader>q :<C-U>call SurroundWithAnki('akq')<CR>
vnoremap <leader>a :<C-U>call SurroundWithAnki('akns')<CR>

" Function to delete Anki commands around selected text
function! DeleteAnkiWrapper() range
    let first_line = a:firstline
    let last_line = a:lastline
    let removed = 0
    " Check if line before the first selected line contains \akq{ or \akns{
    if first_line > 1
        let before_line_num = first_line - 1
        let before_line = getline(before_line_num)
        if before_line =~ '\\\(akq\|akns\){$'
            " Remove \akq{ or \akns{ from the end of the line
            let new_before_line = substitute(before_line, '\\\(akq\|akns\){$', '', '')
            call setline(before_line_num, new_before_line)
            let removed += 1
        endif
    endif
    " Check if line after the last selected line contains a closing }
    if last_line < line('$')
        let after_line_num = last_line + 1
        let after_line = getline(after_line_num)
        if after_line =~ '^}'
            " Remove the } from the beginning of the line
            let new_after_line = substitute(after_line, '^}', '', '')
            call setline(after_line_num, new_after_line)
            let removed += 1
        endif
    endif
    if removed == 0
        echo "No Anki wrapper found around selection."
    endif
endfunction
"  Mapping to delete Anki wrapper in visual mode
vnoremap <leader>d :<C-U>call DeleteAnkiWrapper()<CR>

" INKSCAPE
" Definieer de LaTeX-root directory handmatig voor gebruik in mappings
" let g:latex_root = '~/school/current-subject/nota'

" Ctrl+f in insert mode: Maak een nieuwe figuur in de LaTeX-root directory
" inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>

inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
