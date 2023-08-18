local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

local color_scheme = wezterm.color.get_builtin_schemes()["terafox"]
color_scheme.background = "#181616"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "wsl.exe", "--cd", "~" }
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	if has_unseen_output then
		return {
			{ Foreground = { Color = "#F9E2AF" } },
			{ Text = tab.active_pane.title },
		}
	end

	return tab.active_pane.title
end)

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
	regex = [[["'\s]([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["'\s]] .. "]",
	format = "https://www.github.com/$1/$3",
})

wezterm.on("gui-startup", function(cmd) -- set startup Window position
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.audible_bell = "Disabled"
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}
config.font_size = 10
config.line_height = 1.2
config.window_padding = { left = 1, right = 1, top = 0, bottom = 0 }
config.check_for_updates = false
config.animation_fps = 1
config.initial_cols = 140
config.initial_rows = 40
config.window_frame = { font_size = 12 }
config.tab_max_width = 25
config.switch_to_last_active_tab_when_closing_tab = true
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.cursor_blink_rate = 0
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.term = "wezterm"
config.use_fancy_tab_bar = true
config.enable_csi_u_key_encoding = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.color_schemes = { custom = color_scheme }
config.color_scheme = "custom"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.disable_default_key_bindings = true

config.keys = {
	{ key = "n", mods = "SHIFT|CTRL", action = act.SpawnWindow },
	{ key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "l", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "+", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
}

return config
