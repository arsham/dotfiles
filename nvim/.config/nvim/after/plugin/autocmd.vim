" Make Sure that Vim returns to the same line when we reopen a file.
augroup LINE_RETURN
    autocmd! * <buffer>
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ execute 'normal! g`"zvzz' |
                \ endif
augroup END

augroup FILETYPE_COMMANDS
    autocmd! * <buffer>
    autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd Filetype make,automake setlocal noexpandtab
    autocmd Filetype markdown setlocal spell
    autocmd Filetype gitcommit setlocal spell textwidth=76 colorcolumn=77
    autocmd BufNewFile,BufRead .*aliases set ft=sh

    " Ensure tabs don't get converted to spaces in Makefiles.
    autocmd FileType make setlocal noexpandtab

    " highlight yanking
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()

    " resize Split When the window is resized
    autocmd VimResized * :wincmd =

    " fix escape in fzf popup.
    autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

    " browser setup.
    autocmd BufEnter github.com_*.txt set filetype=markdown
    autocmd BufEnter play.golang.org_*.txt set filetype=go
augroup END
