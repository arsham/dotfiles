local bufname = vim.fn.bufname()
if vim.fn.getbufvar(bufname, 'ftplugin_loaded') == true then return end
vim.fn.setbufvar(bufname, 'ftplugin_loaded', true)

local nvim = require('nvim')
vim.bo.expandtab   = true
vim.bo.tabstop     = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth  = 2

nvim.ex.abbreviate{'<buffer>', 'as',         'AS'}
nvim.ex.abbreviate{'<buffer>', 'by',         'BY'}
nvim.ex.abbreviate{'<buffer>', 'cascade',    'CASCADE'}
nvim.ex.abbreviate{'<buffer>', 'delete',     'DELETE'}
nvim.ex.abbreviate{'<buffer>', 'else',       'ELSE'}
nvim.ex.abbreviate{'<buffer>', 'end',        'END'}
nvim.ex.abbreviate{'<buffer>', 'foreign',    'FOREIGN'}
nvim.ex.abbreviate{'<buffer>', 'from',       'FROM'}
nvim.ex.abbreviate{'<buffer>', 'group',      'GROUP'}
nvim.ex.abbreviate{'<buffer>', 'having',     'HAVING'}
nvim.ex.abbreviate{'<buffer>', 'index',      'INDEX'}
nvim.ex.abbreviate{'<buffer>', 'insert',     'INSERT'}
nvim.ex.abbreviate{'<buffer>', 'into',       'INTO'}
nvim.ex.abbreviate{'<buffer>', 'join',       'JOIN'}
nvim.ex.abbreviate{'<buffer>', 'key',        'KEY'}
nvim.ex.abbreviate{'<buffer>', 'limit',      'LIMIT'}
nvim.ex.abbreviate{'<buffer>', 'offset',     'OFFSET'}
nvim.ex.abbreviate{'<buffer>', 'on',         'ON'}
nvim.ex.abbreviate{'<buffer>', 'order',      'ORDER'}
nvim.ex.abbreviate{'<buffer>', 'primary',    'PRIMARY'}
nvim.ex.abbreviate{'<buffer>', 'references', 'REFERENCES'}
nvim.ex.abbreviate{'<buffer>', 'select',     'SELECT'}
nvim.ex.abbreviate{'<buffer>', 'set',        'SET'}
nvim.ex.abbreviate{'<buffer>', 'then',       'THEN'}
nvim.ex.abbreviate{'<buffer>', 'union',      'UNION'}
nvim.ex.abbreviate{'<buffer>', 'unique',     'UNIQUE'}
nvim.ex.abbreviate{'<buffer>', 'update',     'UPDATE'}
nvim.ex.abbreviate{'<buffer>', 'values',     'VALUES'}
nvim.ex.abbreviate{'<buffer>', 'when',       'WHEN'}
nvim.ex.abbreviate{'<buffer>', 'where',      'WHERE'}
