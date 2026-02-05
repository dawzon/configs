-- Vim options
vim.opt.cmdheight = 0

-- Highlight Groups
vim.api.nvim_set_hl(0, "CustomStatusMode", {
	bold = true,
})

-- "Custom" statusline
ModeNames = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "VISUAL LINE",
}

MaxNameLen = 0
for _, v in pairs(ModeNames) do
	MaxNameLen = math.max(MaxNameLen, string.len(v))
end

function CenterPad(s, length)
	local emptyChars = MaxNameLen - string.len(s)
	assert(emptyChars >= 0, "source string is longer than given length")

	local leftSpaces = math.floor(emptyChars / 2)
	local rightSpaces = math.ceil(emptyChars / 2)
	return string.rep(" ", leftSpaces) .. s .. string.rep(" ", rightSpaces)
end

function ModeName()
	local mode = vim.api.nvim_get_mode().mode
	local name = ModeNames[mode] or mode
	local padded = CenterPad(name, MaxNameLen)
	return "%-" .. MaxNameLen .. "." .. MaxNameLen .. "(" .. padded .. "%)"
end

vim.opt.statusline =
	"%#TermCursor# %{%luaeval('ModeName()')%} %#StatusLine# %f %m%r%h%w%q %= %#TermCursor# %l/%L (%c) %y "
