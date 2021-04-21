--
-- npm -g i --prefix ~/.node_modules bash-language-server
-- npm -g i --prefix ~/.node_modules vim-language-server
-- npm -g i --prefix ~/.node_modules dockerfile-language-server-nodejs
-- npm -g i --prefix ~/.node_modules vscode-html-languageserver-bin
-- npm -g i --prefix ~/.node_modules vscode-json-languageserver
-- npm -g i --prefix ~/.node_modules pyright
-- npm -g i --prefix ~/.node_modules yaml-language-server
-- go install github.com/lighttiger2505/sqls@latest
-- yay -S lua-language-server-git
-- go get github.com/nametake/golangci-lint-langserver

-- vim.lsp.set_log_level("debug")
local lspconfig = require 'lspconfig'
local completion = require 'completion'

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.html.setup{
    capabilities = capabilities,
}

local on_attach = function(client, bufnr)
    completion.on_attach()
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_exec([[
        augroup LSP_MAPPINGS
            autocmd! * <buffer>
            " Use <Tab> and <S-Tab> to navigate through popup menu
            inoremap <buffer> <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
            inoremap <buffer> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

            " also see https://github.com/sparkcanon/nvim/blob/master/lua/lsp.lua
            nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
            nnoremap <buffer> <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
            nnoremap <buffer> <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
            nnoremap <buffer> <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
            nnoremap <buffer> <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
            nnoremap <buffer> <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
            nnoremap <buffer> <silent> <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>

            inoremap <buffer> <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
            imap <buffer> <tab> <Plug>(completion_smart_tab)
            imap <buffer> <s-tab> <Plug>(completion_smart_s_tab)
            " imap <buffer> <c-j> <Plug>(completion_next_source) "use <c-j> to switch to previous completion
            " imap <buffer> <c-k> <Plug>(completion_prev_source) "use <c-k> to switch to next completion

            nnoremap <buffer> <silent> <leader>dd <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
            nnoremap <buffer> <silent> <leader>dq <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
            nnoremap <buffer> <silent> <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
            nnoremap <buffer> <silent> <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
        augroup END
    ]], false)

    local opts = { noremap=true, silent=true }
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        -- vim.api.nvim_exec([[
        --     augroup lsp_formatting
        --         autocmd! * <buffer>
        --         autocmd BufWritePre * silent! lua vim.lsp.buf.formatting_sync(nil, 1000)
        --     augroup END
        -- ]], false)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "gq", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    vim.api.nvim_exec([[
        hi LspReferenceRead ctermbg=180 guibg=#43464F gui=bold
        hi LspReferenceText ctermbg=180 guibg=#43464F gui=bold
        hi LspReferenceWrite ctermbg=180 guibg=#43464F gui=bold
    ]], false)
    if client.resolved_capabilities.document_highlight then
        -- vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                autocmd CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end

    if client.resolved_capabilities.code_action then
        vim.api.nvim_exec([[
        augroup lsp_formatting
            autocmd! * <buffer>
            autocmd BufWritePre * silent! lua vim.lsp.buf.formatting_sync(nil, 1000)
            autocmd BufWritePre <buffer> lua lsp_organize_imports()
        augroup END
        ]], false)
    end
end


lspconfig.bashls.setup{ on_attach = on_attach }
lspconfig.vimls.setup{ on_attach = on_attach }
lspconfig.dockerls.setup{ on_attach = on_attach }
lspconfig.pyright.setup{ on_attach = on_attach }
lspconfig.yamlls.setup{ on_attach = on_attach }

lspconfig.jsonls.setup {
    on_attach = on_attach,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}

--- settings for sumneko lua lsp
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/usr/bin/lua-language-server'
local sumneko_binary = "/usr/bin/lua-language-server"

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

--- gopls
lspconfig.gopls.setup{
    on_attach = on_attach,
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            completeUnimported = true,
            staticcheck = true,
            buildFlags = {"-tags=integration,e2e"},
            hoverKind = "FullDocumentation",
            linkTarget = "pkg.go.dev",
            linksInHover = true,
            -- workspaceFolders = true,
            allExperiments = true,
            -- formatting = {
            --      gofumpt = true,
            -- },
            usePlaceholders = true,
        },
    },
}


function lsp_organize_imports()
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


function goimports(timeout_ms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end

-- vim.api.nvim_exec([[
--     augroup lsp_goimports
--         autocmd! * <buffer>
--         autocmd BufWritePre *.go lua goimports(1000)
--     augroup END
-- ]], false)

-- local servers = {"sumneko_lua",  "jsonls", "html", "yamlls", "pyright", "dockerls", "vimls", "bashls"}
-- -- local servers = {"sumneko_lua", "gopls", "jsonls", "html", "yamlls", "pyright", "dockerls", "vimls", "bashls"}
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup { on_attach = on_attach }
-- end