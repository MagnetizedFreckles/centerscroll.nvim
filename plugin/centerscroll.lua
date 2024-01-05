local M = {}

local function centercursor()
    -- This should add "zz" after every executed command, so separate keymaps should be unnecessary
    -- So far, this works as intended
    vim.api.nvim_feedkeys("zz", "nt", true)
end

local function centerscroll()
    local visible_lines = vim.fn.winheight(0)
    local screen_center = math.ceil(visible_lines / 2)
    local scrolloff_value = screen_center - 1

    local distance_to_eof = vim.fn.line("$") - vim.fn.line(".")

    if distance_to_eof <= screen_center then
        -- I thought that setting scrolloff on every move of cursor is ineffective, hence these checks.
        -- But maybe just setting scrolloff is faster than performing the check, idk
        if vim.opt.scrolloff:get() ~= 0 then
            vim.opt.scrolloff = 0
            centercursor()
        else
            centercursor()
        end
    elseif distance_to_eof > screen_center then
        if vim.opt.scrolloff:get() ~= scrolloff_value then
            vim.opt.scrolloff = scrolloff_value
        end
    end
end

-- Instantiate a variable outside the scope of autocmd,
-- to record the line where the cursor was on previous check
local checkline = nil
function M.setup()
    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = function()
            -- Since calling centerscroll function on every move of the cursor is expensive,
            -- this only performs the call when the line is changed
            if vim.fn.line(".") ~= checkline then
                -- Call the function, then record current line in a variable for the latter checks.
                -- Very simple.
                centerscroll()
                checkline = vim.fn.line(".")
            end
        end,
    })
end

return M
