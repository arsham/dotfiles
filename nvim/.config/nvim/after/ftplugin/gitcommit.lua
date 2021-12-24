-- see #14670
-- vim.bo.textwidth = 72
-- vim.wo.colorcolumn = "50,72"
-- vim.wo.spell = true
vim.cmd[[ setlocal spell ]]
vim.cmd[[ setlocal textwidth=72 ]]
vim.cmd[[ setlocal colorcolumn="50,72" ]]

vim.bo.formatoptions = vim.bo.formatoptions .. 'cn'
local formatlistpat = {'^\\s*'}                         -- Optional leading whitespace
table.insert(formatlistpat, '[')                        -- Start character class
table.insert(formatlistpat, '\\[({]\\?')                -- |  Optionally match opening punctuation
table.insert(formatlistpat, '\\(')                      -- |  Start group
table.insert(formatlistpat, '[0-9]\\+')                 -- |  |  Numbers
table.insert(formatlistpat, [[\\\|]])                   -- |  |  or
table.insert(formatlistpat, '[a-zA-Z]\\+')              -- |  |  Letters
table.insert(formatlistpat, '\\)')                      -- |  End group
table.insert(formatlistpat, '[\\]:.)}')                 -- |  Closing punctuation
table.insert(formatlistpat, ']')                        -- End character class
table.insert(formatlistpat, '\\s\\+')                   -- One or more spaces
table.insert(formatlistpat, [[\\\|]])                   -- or
table.insert(formatlistpat, '^\\s*[-+*]\\s\\+')         -- Bullet points
vim.bo.formatlistpat = table.concat(formatlistpat, '')
