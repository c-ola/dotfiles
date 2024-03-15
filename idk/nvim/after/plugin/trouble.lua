local tr = require("trouble");

-- Lua
vim.keymap.set("n", "<leader>xx", function() tr.toggle() end)
vim.keymap.set("n", "<leader>xw", function() tr.toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() tr.toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() tr.toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() tr.toggle("loclist") end)
vim.keymap.set("n", "gR", function() tr.toggle("lsp_references") end)
