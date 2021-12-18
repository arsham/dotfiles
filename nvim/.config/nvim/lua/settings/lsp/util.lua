require('astronauta.keymap')
local util = require('util')

local M = {}

local function restart_lsp()
    vim.cmd[[LspStop]]
    vim.defer_fn(function() vim.cmd[[LspStart]] end, 1000)
end
util.command{"RestartLsp", buffer=true, restart_lsp}
vim.keymap.nnoremap{'<leader>dr', restart_lsp, silent=true}

local function lsp_organise_imports()
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "table", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local method = "textDocument/codeAction"
    local timeout = 1000 -- ms

    local resp = vim.lsp.buf_request_sync(0, method, params, timeout)
    if not resp then return end

    for _, client in ipairs(vim.lsp.get_active_clients()) do
        if resp[client.id] then
            local result = resp[client.id].result
            if not result or not result[1] then return end

            local edit = result[1].edit
            vim.lsp.util.apply_workspace_edit(edit)
        end
    end
end

-- Returns the name of the struct, method or function.
local function get_current_node_name()
    local ts_utils = require'nvim-treesitter.ts_utils'
    local cur_node = ts_utils.get_node_at_cursor()
    local type_patterns = {
        method_declaration = 2,
        function_declaration= 1,
        type_spec = 0,
    }
    local stop = false
    local index = 1
    while cur_node do
        for rgx, k in pairs(type_patterns) do
            if cur_node:type() == rgx then
                stop = true
                index = k
                break
            end
        end
        if stop then break end
        cur_node = cur_node:parent()
    end

    if not cur_node then
        vim.notify("Test not found", vim.lsp.log_levels.WARN, {
            title = "User Command",
            timeout = 1000,
        })
        return ""
    end
    return (ts_utils.get_node_text(cur_node:child(index)))[1]
end

-- Attaches commands, mappings and autocmds to current buffer based on the
-- client's capabilities.
local function attach_mappings_commands(client)
    -- Contains functions to be run before writing the buffer. The format
    -- function will format the while buffer, and the imports function will
    -- organise imports.
    local pre_save = {
        format = function() end,
        imports = function() end,
    }
    local caps = client.resolved_capabilities
    if caps.code_action then
        vim.cmd('command! -buffer -range CodeAction lua require("settings.lsp.util").code_action(<range> ~= 0, <line1>, <line2>)')
        vim.keymap.nnoremap{'<leader>ca', vim.lsp.buf.code_action, buffer=true, silent=true}
        vim.keymap.vnoremap{'<leader>ca', ":'<,'>CodeAction<CR>", buffer=true, silent=true}

        -- Either is it set to true, or there is a specified set of
        -- capabilities.
        if type(caps.code_action) == "table" and table.contains(caps.code_action.codeActionKinds, "source.organizeImports") then
            vim.keymap.nnoremap{'<leader>i', lsp_organise_imports, buffer=true, silent=true}
            pre_save.imports = lsp_organise_imports
        end
    end

    if caps.document_formatting and client.name ~= "sqls" then
        vim.keymap.nnoremap{"<leader>gq", vim.lsp.buf.formatting, buffer=true, silent=true}
        pre_save.format = function()
            vim.lsp.buf.formatting_sync(nil, 2000)
        end
    end

    util.augroup{"LSP_FORMAT_IMPORTS", {
        {"BufWritePre", buffer=true, docs="format and imports", run=function()
            pre_save.imports()
            pre_save.format()
        end},
    }}

    if caps.document_range_formatting then
        vim.cmd('command! -buffer -range -bang Format lua require("settings.lsp.util").format_command(<range> ~= 0, <line1>, <line2>, "<bang>" == "!")')
        vim.keymap.vnoremap{"gq", ':Format<CR>', buffer=true, silent=true}
        vim.bo.formatexpr = 'v:lua.vim.lsp.formatexpr()'
    end

    if caps.rename then
        util.command{'Rename', buffer=true, function() vim.lsp.buf.rename() end}
    end

    if caps.hover then
        vim.keymap.nnoremap{'H',     vim.lsp.buf.hover, buffer=true, silent=true}
        vim.keymap.inoremap{'<C-h>', vim.lsp.buf.hover, buffer=true, silent=true}
    end
    if caps.signature_help then
        vim.keymap.nnoremap{'K',     vim.lsp.buf.signature_help, buffer=true, silent=true}
        vim.keymap.inoremap{'<C-l>', vim.lsp.buf.signature_help, buffer=true, silent=true}
    end

    if caps.goto_definition then
        util.command{"Definition", buffer=true, function() vim.lsp.buf.definition() end}
        vim.keymap.nnoremap{'gd', vim.lsp.buf.definition, buffer=true, silent=true}
    end
    if caps.declaration then
        vim.keymap.nnoremap{'gD', vim.lsp.buf.declaration, buffer=true, silent=true}
    end
    if caps.type_definition then
        util.command{"TypeDefinition", buffer=true, function() vim.lsp.buf.type_definition() end}
    end
    if caps.implementation then
        util.command{"Implementation", buffer=true, function() vim.lsp.buf.implementation() end}
        vim.keymap.nnoremap{'<leader>gi', vim.lsp.buf.implementation, buffer=true, silent=true}
    end

    if caps.find_references then
        util.command{"References", buffer=true, function() vim.lsp.buf.references() end}
        vim.keymap.nnoremap{'gr', vim.lsp.buf.references, buffer=true, silent=true}
    end

    if caps.document_symbol then
        util.command{"DocumentSymbol", buffer=true, function() vim.lsp.buf.document_symbol() end}
        vim.keymap.nnoremap{'<leader>@', function()
            vim.lsp.buf.document_symbol()
        end, buffer=true, silent=true}
    end
    if caps.workspace_symbol then
        util.command{"WorkspaceSymbols", buffer=true, function() vim.lsp.buf.workspace_symbol() end}
    end

    if caps.call_hierarchy then
        util.command{"Callees", buffer=true, function() vim.lsp.buf.outgoing_calls() end}
        util.command{"Callers", buffer=true, function() vim.lsp.buf.incoming_calls() end}
        vim.keymap.nnoremap{'<leader>gc', vim.lsp.buf.incoming_calls, buffer=true, silent=true}
    end

    util.command{"ListWorkspace", buffer=true, function()
        vim.notify(vim.lsp.buf.list_workspace_folders(), vim.lsp.log_levels.INFO, {
            title = "Workspace Folders",
            timeout = 3000,
        })
    end}
    if caps.workspace_folder_properties.supported then
        vim.cmd('command! -buffer -nargs=? -complete=dir AddWorkspace lua vim.lsp.buf.add_workspace_folder(<q-args> ~= "" and vim.fn.fnamemodify(<q-args>, ":p"))')
        vim.cmd('command! -buffer -nargs=? -complete=customlist,v:lua.vim.lsp.buf.list_workspace_folders RemoveWorkspace lua vim.lsp.buf.remove_workspace_folder(<f-args>)')
    end

    util.command{"Log", buffer=true, "execute '<mods> pedit +$' v:lua.vim.lsp.get_log_path()"}

    util.command{"Test", docs="locate tests for a node", buffer=true, function()
        local name = get_current_node_name()
        if name == "" then return nil end

        local pattern = "test" .. name
        vim.lsp.buf.workspace_symbol(pattern)
    end}

    vim.keymap.inoremap{'<C-j>',   '<C-n>',  buffer=true, silent=true}
    vim.keymap.inoremap{'<C-k>',   '<C-p>',  buffer=true, silent=true}

    vim.keymap.nnoremap{'<leader>dd', vim.diagnostic.open_float, buffer=true, silent=true}
    vim.keymap.nnoremap{'<leader>dq', vim.diagnostic.setqflist,  buffer=true, silent=true}
    vim.keymap.nnoremap{'<leader>dw', vim.diagnostic.setloclist, buffer=true, silent=true}
    vim.keymap.nnoremap{']d', function()
        util.call_and_centre(vim.diagnostic.goto_next)
    end, buffer=true, silent=true}
    vim.keymap.nnoremap{'[d', function()
        util.call_and_centre(vim.diagnostic.goto_prev)
    end, buffer=true, silent=true}
    util.command{"Diagnostics",       buffer=true, function() require('lspfuzzy').diagnostics(0) end}
    util.command{"DiagnosticsAll",    "LspDiagnosticsAll"}
end

function M.on_attach(client, bufnr)
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- TODO: find out how to disable the statuline badges as well.
	if vim.bo[bufnr].buftype ~= '' or vim.bo[bufnr].filetype == 'helm' then
		vim.diagnostic.disable()
	end

    vim.api.nvim_buf_call(bufnr, function() attach_mappings_commands(client) end)

    util.augroup{"STOP_LSP_TYPES", {
        {events="BufReadPost,BufNewFile", targets="*/templates/*.yaml,*/templates/*.tpl", run="LspStop"},
    }}

    local caps = client.resolved_capabilities
    if caps.code_lens then
        util.command{"CodeLensRefresh", buffer=true, function() vim.lsp.codelens.refresh() end}
        util.command{"CodeLensRun", buffer=true,     function() vim.lsp.codelens.run() end}
        vim.keymap.nnoremap{'<leader>cr', vim.lsp.codelens.run, buffer=true, silent=true}

        util.augroup{"CODE_LENSES", {
            {"CursorHold,CursorHoldI,InsertLeave", buffer=true, run=function()
                vim.lsp.codelens.refresh()
            end},
        }}
    end
end

function M.format_command(range_given, line1, line2, bang)
    if range_given then
        vim.lsp.buf.range_formatting(nil, {line1, 0}, {line2, 99999999})
    elseif bang then
        vim.lsp.buf.formatting_sync()
    else
        vim.lsp.buf.formatting()
    end
end

function M.code_action(range_given, line1, line2)
    if range_given then
        vim.lsp.buf.range_code_action(nil, {line1, 0}, {line2, 99999999})
    else
        vim.lsp.buf.code_action()
    end
end

return M
