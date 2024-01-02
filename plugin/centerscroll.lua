print("IT WORKS")

function CenterCursor()
    vim.api.nvim_feedkeys("zz", "nt", true)
end

local M = {}

function M.centerscroll()
    local visible_lines = vim.fn.winheight(0)
    local screen_center = math.ceil(visible_lines / 2)
    local scrolloff_value = screen_center - 1

    local distance_to_eof = vim.fn.line("$") - vim.fn.line(".")

    if distance_to_eof <= screen_center then
        if vim.opt.scrolloff:get() ~= 0 then
            vim.opt.scrolloff = 0
            CenterCursor()
        else
            CenterCursor()
        end
    elseif distance_to_eof > screen_center then
        if vim.opt.scrolloff:get() ~= scrolloff_value then
            vim.opt.scrolloff = scrolloff_value
        end
    end
end

function M.autocmd()
    local checkline = nil
    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            if vim.fn.line(".") ~= checkline then
                M.centerscroll()
                checkline = vim.fn.line(".")
            end
        end,
    })
end

return M
