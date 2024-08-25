-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
-- EXAMPLE
local servers = { "html", "cssls", "tsserver", "tailwindcss", "eslint", "emmet_ls" }
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
