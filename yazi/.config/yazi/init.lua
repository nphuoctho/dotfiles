require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("git"):setup()

require("smart-enter"):setup({
	open_multi = true,
})

require("relative-motions"):setup({
	show_numbers = "none",
	show_motion = true,
})

require("bookmarks"):setup({
	persist = "vim",
	desc_format = "parent",
	show_keys = true,
})

-- Custom linemode: chỉ hiện size cho file, để trống cho directory
function Linemode:size_only()
	local size = self._file:size()
	return size and ya.readable_size(size) or ""
end
