local monitorLeft = "DP-1"
local monitorRight = "DP-2"
hl.monitor({
	output = monitorLeft,
	mode = "preferred",
	position = "0x0",
	scale = 1.5,
})
hl.monitor({
	output = monitorRight,
	mode = "preferred",
	position = "auto-right",
	scale = 1,
})

local terminal = "alacritty"
local fileManager = "dolphin"
local menu = "wofi --show drun"

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("ashell")
	hl.exec_cmd("hyprctl setcursor Hackneyed 32")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("1password --silent")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_SCREEN_SCALE_FACTORS", "1.25")

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = "rgb(b9b9b9)",
			inactive_border = "rgb(303030)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 10,
			render_power = 1,
			offset = { 3, 6 },
			color = "rgba(1a1a1a99)"
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "flat",
		touchpad = {
			natural_scroll = false,
		}
	},
})

local mainMod = "SUPER"

hl.bind(mainMod .. "+ Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "+ C", hl.dsp.window.close())
hl.bind(mainMod .. "+ E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. "+ V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+ D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. "+ P", hl.dsp.window.pseudo())
hl.bind(mainMod .. "+ J", hl.dsp.layout("togglesplit")) -- dwindle only

local directions = {
	{ direction = "left",  vimKey = "h" },
	{ direction = "right", vimKey = "l" },
	{ direction = "up",    vimKey = "k" },
	{ direction = "down",  vimKey = "j" },
}
for _, v in pairs(directions) do
	-- Move focus
	hl.bind(mainMod .. "+" .. v.direction, hl.dsp.focus({ direction = v.direction }))
	hl.bind(mainMod .. "+" .. v.vimKey, hl.dsp.focus({ direction = v.direction }))
	-- Move window
	hl.bind(mainMod .. "+ SHIFT +" .. v.direction, hl.dsp.window.move({ direction = v.direction }))
	hl.bind(mainMod .. "+ SHIFT +" .. v.vimKey, hl.dsp.window.move({ direction = v.direction }))
end

-- Workspaces
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Workspaces assigned to monitors
for i = 1, 5 do
	hl.workspace_rule({ workspace = i, monitor = monitorLeft })
end
for i = 6, 10 do
	hl.workspace_rule({ workspace = i, monitor = monitorRight })
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name           = "suppress-maximize-events",
	match          = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name     = "fix-xwayland-drags",
	match    = {
		class      = "^$",
		title      = "^$",
		xwayland   = true,
		float      = true,
		fullscreen = false,
		pin        = false,
	},

	no_focus = true,
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
