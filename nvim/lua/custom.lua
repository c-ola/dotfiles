function OpenScratchBuffer(cmd)
    vim.cmd("vnew")  -- Open a new buffer
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "hide"
    vim.bo.swapfile = false
    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(0, -1, -1, false, data)
            end
        end
    })
end

vim.api.nvim_create_user_command("Scratch", function(opts)
    OpenScratchBuffer(opts.args)
end, { nargs = 1 })

function RunFileGuess()
    local cmd = "!" .. vim.bo.filetype .. " " .. vim.fn.expand("%")
    local output = vim.fn.execute(cmd)
    vim.cmd("vnew")
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "hide"
    vim.bo[buf].swapfile = false
    local lines = vim.split(output, "\n")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

vim.api.nvim_create_user_command("RunFileGuess", RunFileGuess, {})
vim.keymap.set({"n", "v"}, "<leader>rf", "<cmd>RunFileGuess<CR>")

-- Highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying text)",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
