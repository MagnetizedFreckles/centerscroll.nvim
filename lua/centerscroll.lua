local function centercursor()
    -- I don't know if this is the most optimal way to autocenter
    -- But it seems to work
    vim.api.nvim_exec2("normal! zz", {})
end

-- NOTE: There is a sligtly noticeable "bump"
-- when approaching EOF, for now I don't know how to fix
local function centerscroll()
    local visible_lines = vim.fn.winheight(0)
    local screen_center = math.ceil(visible_lines / 2)

    local distance_to_eof = vim.fn.line("$") - vim.fn.line(".")

    -- Through testing it seems that keeping scrolloff constantly on doesn't do any harm
    vim.opt.scrolloff = screen_center

    if distance_to_eof <= screen_center then
        centercursor()
    end
end

local M = {}

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
