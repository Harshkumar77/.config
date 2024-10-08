local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  --
  -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  --
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('gk', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  -- nmap('gw', vim.diagnostic.open_float)
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    local row = (vim.api.nvim_exec2([[
         :echo line('.')
      ]], { output = true })).output

    for _, v in ipairs({ 'js', 'ts', 'css', 'jsx', 'tsx', 'vimwiki', 'typescriptreact', 'json' }) do
      if v == vim.bo.filetype then
        vim.cmd([[
        :%! node $HOME/.local/share/nvim/mason/bin/prettier "%"
        ]])
        vim.cmd(':' .. row)
        return
      end
    end

    for _, v in ipairs({ 'sql' }) do
      if v == vim.bo.filetype then
        vim.cmd([[
        :%! $HOME/.local/share/nvim/mason/bin/sqlfmt "%"
        ]])
        vim.cmd(':' .. row)
        return
      end
    end

    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
    vim.api.nvim_buf_create_user_command(bufnr, 'Wf', function(_)
    vim.cmd [[
      :w
      :Format
      :w
    ]]
  end, { desc = 'Format and save' })
end
local servers = {
  clangd = {},
  gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  html = {
    filetypes = { 'html', 'ejs', 'twig', 'hbs', 'tmpl', 'template' },
    init_options = {
      provideFormatter = false
    }
  },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },

  marksman = {
    filetypes = { "markdown" },
  },
  tailwindcss = {
    filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge",
      "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex",
      "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css",
      "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript",
      "typescript", "typescriptreact", "vue", "svelte" }
  },
}


-- Setup neovim lua configuration
require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}



