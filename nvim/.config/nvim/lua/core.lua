vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.formatoptions:append("n") -- smart auto-indent numbered lists.
vim.opt.textwidth = 79
vim.opt.colorcolumn = "80,120"
vim.opt.smarttab = true
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.tabstop=4
vim.opt.expandtab = true
vim.opt.wrap = false

vim.opt.whichwrap:append("h,l")
vim.opt.linebreak = true  -- Wrap lines at convenient points

vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '.' }
vim.opt.clipboard:append("unnamed")
vim.opt.title = true
vim.opt.titlestring:append("%t")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.lazyredraw = true

vim.opt.backspace = "indent,eol,start" -- allow backspace in insert mode
vim.opt.history = 10000

vim.opt.shada = "!,'1000,<500,s10,h,f1,:100000,@100000,/100000"
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.autoread = true

-- vim.opt.shortmess = vim.opt.shortmess + "f"	   -- Use "(3 of 5)" instead of "(file 3 of 5)"
-- vim.opt.shortmess = vim.opt.shortmess + "i"	   -- Use "[noeol]" instead of "[Incomplete last line]"
-- vim.opt.shortmess = vim.opt.shortmess + "l"	   -- Use "999L, 888C" instead of "999 lines, 888 characters"
-- vim.opt.shortmess = vim.opt.shortmess + "m"       -- Use "[+]" instead of "[Modified]"
-- vim.opt.shortmess = vim.opt.shortmess + "n"	   -- Use "[New]" instead of "[New File]"
-- vim.opt.shortmess = vim.opt.shortmess + "r"	   -- Use "[RO]" instead of "[readonly]"
-- vim.opt.shortmess = vim.opt.shortmess + "x"	   -- Use "[dos]" instead of "[dos format]", "[unix]" instead of [unix format]" and "[mac]" instead of "[mac format]".
-- -- set shortmess+=a	   " All of the above abbreviations
-- vim.opt.shortmess = vim.opt.shortmess + "o"	   -- Overwrite message for writing a file with subsequent message for reading a file (useful for ":wn" or when 'autowrite' on)
-- vim.opt.shortmess = vim.opt.shortmess + "O"	   -- Message for reading a file overwrites any previous message.  Also for quickfix message (e.g., ":cn").
-- vim.opt.shortmess = vim.opt.shortmess + "t"       -- Truncate file message at the start if it is too long to fit on the command-line, "<" will appear in the left most column.  Ignored in Ex mode.
-- vim.opt.shortmess = vim.opt.shortmess + "T"	   -- Truncate other messages in the middle if they are too long to fit on the command line.  "..." will appear in the middle.  Ignored in Ex mode.
-- vim.opt.shortmess = vim.opt.shortmess + "A"	   -- Don't give the "ATTENTION" message when an existing swap file is found.
-- vim.opt.shortmess = vim.opt.shortmess + "I"	   -- Don't give the intro message when starting Vim |:intro|.
-- vim.opt.shortmess = vim.opt.shortmess + "c"       -- Avoid showing message extra message when using completion
vim.opt.shortmess:append("filmnrxoOtTAIc")

vim.opt.hidden = true
vim.opt.syntax = "on"

vim.opt.viewoptions:append("localoptions")
vim.opt.viewdir = vim.env.HOME .. "/.cache/vim/views"

-- better diff view. This will make sure the inserted part is separated, rather
-- than mangled in the previous blob.
vim.opt.diffopt:append("indent-heuristic")
vim.opt.suffixesadd:append(".go")
vim.opt.suffixesadd:append(".py")
vim.opt.suffixesadd:append(".lua")

-- enable ctrl-n and ctrl-p to scroll through matches
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignorecase = true

-- stuff to ignore when tab completing
vim.opt.wildignore = "*.o,*.obj,*~,*.so"
vim.opt.wildignore:append("*vim/backups*")
vim.opt.wildignore:append("*.git/**,**/.git/**")
vim.opt.wildignore:append("*sass-cache*")
vim.opt.wildignore:append("*DS_Store*")
vim.opt.wildignore:append("vendor/rails/**")
vim.opt.wildignore:append("vendor/cache/**")
vim.opt.wildignore:append("*.gem")
vim.opt.wildignore:append("*.pyc")
vim.opt.wildignore:append("log/**")
vim.opt.wildignore:append("*.png,*.jpg,*.gif")
vim.opt.wildignore:append("*.zip,*.bg2,*.gz")
vim.opt.wildignore:append("*.db")
vim.opt.wildignore:append("**/node_modules/**")
vim.opt.wildignore:append("**/bin/**")
vim.opt.wildignore:append("**/thesaurus/**")

vim.opt.omnifunc = "syntaxcomplete#Complete"
vim.opt.updatetime = 100

-- adds <> to % matchpairs
vim.opt.matchpairs:append("<:>")
vim.opt.complete = ".,w,b,u,t,i"
vim.opt.nrformats = "bin,hex,alpha"           -- can increment alphabetically too!
vim.opt.foldmethod = "manual"
vim.opt.foldnestmax = 3
vim.opt.foldenable = false                       -- dont fold by default

vim.opt.spelllang = "en_gb"
vim.opt.spell = false
vim.opt.thesaurus = vim.env.HOME .. "/.local/share/thesaurus/moby.txt"
-- install words-insane package
vim.opt.dictionary:append("/usr/share/dict/words-insane")

local spellfile = ".config/nvim/spell"
-- require('util').mkdir_home(spellfile)
vim.opt.spellfile = spellfile .. "/en.utf-8.add"

vim.opt.scrolloff = 3         -- keep 3 lines visible while scrolling
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1

vim.opt.incsearch = true
vim.opt.ignorecase = true
-- vim.opt.nohlsearch
vim.opt.inccommand = "nosplit"         -- allow for live substitution
vim.opt.smartcase = true
-- Searches current directory recursively.
vim.opt.path = ".,**,~/.config/nvim/**"
vim.opt.showmatch = true

local ok, is_exe = pcall(vim.fn.executable, "rg")
if ok and is_exe == 1 then
    vim.opt.grepprg = "rg --vimgrep --smart-case --follow --hidden"
    vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- let the visual block mode go over empty characters.
vim.opt.virtualedit = "block"
vim.opt.modelines = 0
vim.opt.modeline = false

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.fillchars:append("vert:│")

vim.opt.sessionoptions:append("tabpages,globals")

vim.opt.undofile = true
vim.opt.undolevels = 10000
local undodir = "/.cache/nvim/undodir"
local backdir = "/.cache/nvim/backdir"

-- require('util').mkdir_home(undodir)
-- require('util').mkdir_home(backdir)

vim.opt.undodir = vim.env.HOME .. undodir
vim.opt.backupdir = vim.env.HOME .. backdir
vim.opt.directory = vim.env.HOME .. backdir

vim.opt.termguicolors = true
-- if exists('+termguicolors')
--     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
--     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
--     set termguicolors
-- endif

vim.cmd('filetype indent plugin on')

vim.g.netrw_winsize = 20
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.python_host_prog = '/usr/bin/python2'

-- https://github.com/wincent/wincent/blob/main/aspects/nvim/files/.config/nvim/init.lua