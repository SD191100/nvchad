-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
-- EXAMPLE
local servers = { "html", "cssls", "tsserver", "tailwindcss", "eslint", "emmet_ls", "prismals" }
local nvlsp = require "nvchad.configs.lspconfig"
local command = vim.api.nvim_create_user_command
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
lspconfig.tsserver.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

lspconfig.omnisharp.setup {
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  cmd = { "dotnet", "/home/tanjiro/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" },
  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,
  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,
  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = false,
  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = true,
  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,
  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = true,
  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = false,
}

command("LspFormat", function()
  if vim.fn.exists ":NullFormat" == 2 then
    vim.cmd "NullFormat"
    return
  end
  vim.lsp.buf.formatting()
end, { desc = "format current buffer" })

null_ls.setup {
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
    local bufcmd = vim.api.nvim_buf_create_user_command
    local format = function()
      local params = vim.lsp.util.make_formatting_params {}
      client.request("textDocument/formatting", params, nil, bufnr)
    end

    if client.server_capabilities.documentFormattingProvider then
      bufcmd(bufnr, "NullFormat", format, { desc = "format using null_ls" })
    end

    nvlsp.on_attach(client, bufnr)
  end,
}
