-- lsp_config.lua
return {
    -- nvim-lspconfig プラグイン
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- LSPの進捗表示用プラグイン
            { 'j-hui/fidget.nvim', opts = {} },
            
            -- Mason: LSPサーバーの管理ツール
            {
                'williamboman/mason.nvim',
                config = function()
                    require("mason").setup()
                end
            },
            
            -- MasonとLSPConfigの連携プラグイン
            'williamboman/mason-lspconfig.nvim'
        },
        config = function()
            -- LSPサーバーのセットアップ
            local lspconfig = require('lspconfig')
            
            -- clangdのセットアップ (C/C++用)
            lspconfig.clangd.setup {
                on_attach = function(client, bufnr)
                    -- キーマッピング
                    local bufopts = { noremap=true, silent=true, buffer=bufnr }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                end,
                
                -- clangdの追加設定
                cmd = {
                    "clangd",
                    "--background-index",  -- インデックス作成
                    "--suggest-missing-includes",  -- 不足しているインクルードの提案
                    "--clang-tidy",  -- clang-tidyによる静的解析
                    "--header-insertion=iwyu"  -- インクルードの最適化
                },
                
                -- diagnostics設定
                diagnostics = {
                    enable = true,
                    severity_sort = true,
                }
            }

            -- 診断サインの設定
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',  -- 仮想テキストのプレフィックス
                    source = "always"  -- 常に情報源を表示
                },
                severity_sort = true,  -- 重大度でソート
                float = {
                    border = "rounded",  -- 浮動ウィンドウの枠
                    source = "always"  -- 常に情報源を表示
                }
            })

            -- 診断サインの設定
            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" }
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
            end
        end
    }
}
