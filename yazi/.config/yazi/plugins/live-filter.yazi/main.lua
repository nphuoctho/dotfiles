--- Live filter: realtime filtering, no auto-enter to unique directory.
--- Adapted from yazi-rs/plugins:smart-filter (MIT).
--- Type      -> live filter
--- Enter     -> apply filter, exit prompt (filter stays)
--- Escape    -> clear filter

local function prompt()
	return ya.input {
		title = "Filter:",
		pos = { "center", w = 50 },
		realtime = true,
		debounce = 0.1,
	}
end

local function entry()
	local input = prompt()
	while true do
		local value, event = input:recv()
		if event ~= 1 and event ~= 3 then
			ya.emit("escape", { filter = true })
			break
		end
		ya.emit("filter_do", { value, smart = true })
		if event == 1 then
			break
		end
	end
end

return { entry = entry }
