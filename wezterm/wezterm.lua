local wezterm = require("wezterm")

local color_scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
color_scheme.background = "#181616"

return {
	default_domain = "WSL:Ubuntu-22.04",
	font = wezterm.font("JetBrainsMono Nerd Font"),
	color_schemes = { custom = color_scheme },
	color_scheme = "custom",
	font_size = 10,
	line_height = 1.2,
	window_padding = { left = 1, right = 1, top = 0, bottom = 0 },
	check_for_updates = false,
	enable_tab_bar = false,
	animation_fps = 1,
	cursor_blink_rate = 0,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	disable_default_key_bindings = false,
}
