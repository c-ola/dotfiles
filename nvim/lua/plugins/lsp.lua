return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            luasnip.config.setup {}

            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                experimental = {
                    ghost_text = true,
                },
                sources = {
                    {name = 'luasnip'},
                    {name = 'nvim_lsp'},
                    {name = 'buffer'},
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    ["<C-y>"] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                }),
                snippet = {
                    expand = function(args)
                        --vim.snippet.expand(args.body)
                        luasnip.lsp_expand(args.body)
                    end,
                },
            })
        end
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        opts = function()
            local ret = {
                diagnostics = {
                    underline = true,
                    virtual_text = {
                        spacing = 4,
                        source = "if_many",
                    }
                },
                severity_sort = true,
                signs = {
                    text = {
                        --[vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
                        --[vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
                        --[vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
                        --[vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
                    },
                },
                inlay_hints = {
                    enabled = true,
                },
                codelens = {
                    enabled = false,
                }
            }
            return ret
        end,
        config = function()
            local lsp_zero = require('lsp-zero')

            -- lsp_attach is where you enable features that only work
            -- if there is a language server active in the file
            local lsp_attach = function(client, bufnr)
                local opts = {buffer = bufnr}

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end

            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require('cmp_nvim_lsp').default_capabilities()
            })
            lsp_zero.configure('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        hint = {
                            enable = true,
                        }
                    }
                }
            })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'rust_analyzer',
                    'cmake',
                    'clangd',
                    'marksman',
                    'jdtls',
                    'html',
                    'ruff_lsp'
                    --'pylsp'
                },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                }
            })
        end
    }
}
