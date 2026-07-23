---@diagnostic disable: lowercase-global
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")

require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/" .. "zenburn/theme.lua")
-- beautiful.init("~/.config/awesome/" .. "zenburn/theme-patch.lua")
-- beautiful.init("~/.config/awesome/" .. "gtk/theme.lua")
-- beautiful.init("~/.config/awesome/" .. "default/theme.lua")

-- beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
home = os.getenv("HOME") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"
keyboardNative = io.popen("~/.config/ts-scripts/key.ts keyboardNative"):read("*all")
if keyboardNative:match("true") then
	modkey = "Mod4"
end

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.corner.nw,
	awful.layout.suit.fair,
	awful.layout.suit.spiral,
	awful.layout.suit.max,
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.top,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", terminal },
	},
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
-- mytextclock = wibox.widget({
-- 	widget = wibox.widget.textclock,
-- })

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	local names = { "main", "main-II", "main-III", "fullscreen", "todo", "empty" }
	local l = awful.layout.suit -- Just to save some typing: use an alias.
	local layouts = { l.corner.nw, l.corner.nw, l.corner.nw, l.max.fullscreen, l.magnifier }
	awful.tag(names, s, layouts)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
			-- s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			-- mykeyboardlayout,
			-- wibox.widget.systray(),
			mytextclock,
			s.mylayoutbox,
			s.mytaglist,
		},
	})
end)
-- }}}
-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
	awful.key({ modkey }, "=", function()
		local command = "picom-trans -g --current"
		awful.spawn.easy_async_with_shell(command, function(stdout)
			local opacity = tonumber(stdout) or 100
			opacity = opacity + 8
			awful.spawn("picom-trans --current --opacity " .. opacity)
		end)
	end, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "-", function()
		local command = "picom-trans -g --current"
		awful.spawn.easy_async_with_shell(command, function(stdout)
			local opacity = tonumber(stdout) or 100
			opacity = opacity - 8
			if opacity < 11 then
				opacity = 11
			end
			awful.spawn("picom-trans --current --opacity " .. opacity)
		end)
	end, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	-- awful.key({ modkey,           }, "w", function ()  end,
	--         {description = "show main menu", group = "awesome"}),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
		--awful.client.focus.byidx(-1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
		--awful.client.focus.byidx( 1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	-- awful.key({ modkey }, "Tab", function()
	-- 	awful.spawn.easy_async_with_shell("~/.config/ts-scripts/key.ts singleTapMod", function(singleTapMod)
	-- 		if singleTapMod:match("false") then
	-- 			awful.spawn.easy_async_with_shell("~/.config/ts-scripts/key.ts modTabMode", function(out)
	-- 				if out:match("swap") then
	-- 					awful.client.swap.byidx(1)
	-- 					awful.client.focus.byidx(-1)
	-- 				elseif out:match("swap-reverse") then
	-- 					awful.client.swap.byidx(-1)
	-- 					awful.client.focus.byidx(1)
	-- 				elseif out:match("cycle-forward") then
	-- 					awful.client.focus.byidx(1)
	-- 				else
	-- 					awful.client.focus.history.previous()
	-- 					if client.focus then
	-- 						client.focus:raise()
	-- 					end
	-- 				end
	-- 			end)
	-- 		end
	-- 	end)
	-- end, { description = "go back", group = "client" }),

	-- awful.key({ "Tab" }, "Tab", function()
	-- 	awful.spawn.easy_async_with_shell("~/.config/ts-scripts/key.ts singleTapMod", function(singleTapMod)
	-- 		if singleTapMod:match("true") then
	-- 			awful.spawn.easy_async_with_shell("~/.config/ts-scripts/key.ts modTabMode", function(out)
	-- 				if out:match("swap") then
	-- 					awful.client.swap.byidx(1)
	-- 					awful.client.focus.byidx(-1)
	-- 				elseif out:match("swap-reverse") then
	-- 					awful.client.swap.byidx(-1)
	-- 					awful.client.focus.byidx(1)
	-- 				elseif out:match("cycle-forward") then
	-- 					awful.client.focus.byidx(1)
	-- 				else
	-- 					awful.client.focus.history.previous()
	-- 					if client.focus then
	-- 						client.focus:raise()
	-- 					end
	-- 				end
	-- 			end)
	-- 		end
	-- 	end)
	-- end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey, "Shift" }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	-- awful.key({ modkey }, "space", function()
	-- 	-- Change to the next layout
	-- 	awful.layout.inc(1)
	--
	-- 	-- Get the current layout's name after the change
	-- 	local current_layout = awful.layout.getname(awful.layout.get())
	--
	-- 	-- Display a notification with the current layout
	-- 	naughty.notify({ text = "" .. current_layout })
	-- 	--  	    awful.spawn("notify-send " .. current_layout)
	-- end, { description = "select next", group = "layout" }),
	--
	-- awful.key({ modkey, "Control" }, "space", function()
	-- 	local layouts = {
	-- 		["floating"] = awful.layout.suit.floating,
	-- 		["tile"] = awful.layout.suit.tile,
	-- 		["tile.left"] = awful.layout.suit.tile.left,
	-- 		["tile.bottom"] = awful.layout.suit.tile.bottom,
	-- 		["tile.top"] = awful.layout.suit.tile.top,
	-- 		["fair"] = awful.layout.suit.fair,
	-- 		["fair.horizontal"] = awful.layout.suit.fair.horizontal,
	-- 		["spiral"] = awful.layout.suit.spiral,
	-- 		["spiral.dwindle"] = awful.layout.suit.spiral.dwindle,
	-- 		["max"] = awful.layout.suit.max,
	-- 		["max.fullscreen"] = awful.layout.suit.max.fullscreen,rc.la
	-- 		["magnifier"] = awful.layout.suit.magnifier,
	-- 		["corner.nw"] = awful.layout.suit.corner.nw,
	-- 		["corner.ne"] = awful.layout.suit.corner.ne,
	-- 		["corner.sw"] = awful.layout.suit.corner.sw,
	-- 		["corner.se"] = awful.layout.suit.corner.se,
	-- 	}
	--
	-- 	awful.spawn.easy_async(
	-- 		"/home/giga/.config/awesome/rofi-selector.sh",
	-- 		function(stdout, stderr, reason, exit_code)
	-- 			-- Trim any whitespace from the output
	-- 			local layout_name = stdout:gsub("%s+", "")
	--
	-- 			-- Set the layout if the selected layout is valid
	-- 			if layouts[layout_name] then
	-- 				awful.layout.set(layouts[layout_name])
	-- 				naughty.notify({ text = "" .. layout_name })
	-- 			else
	-- 				naughty.notify({ text = "Invalid layout selected." })
	-- 			end
	-- 		end
	-- 	)
	-- end, { description = "select next", group = "layout" }),

	awful.key({ modkey, "Shift" }, "space", function()
		-- Change to the previous layout
		awful.spawn("rofi -show windowcd")
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	awful.key({ modkey }, "r", function(c)
		awful.spawn("obsidian 'obsidian://adv-uri?vault=Electra%20Coil&commandid=workspace%3Anew-window'")
		awful.client.urgent.jumpto()
	end, { description = "obsidian omnisearch", group = "launcher" }),

	-- Rofi
	awful.key({ modkey }, "space", function()
		awful.spawn.with_shell("~/.config/awesome/rofi-general.sh")
	end, { description = "", group = "launcher" }),

	awful.key({ modkey, "Shift" }, "r", function()
		awful.spawn(
			"obsidian 'obsidian://adv-uri?vault=Electra%20Coil&commandid=quickadd%3Achoice%3A525f3b49-1278-477e-8e09-ef5bb134e518'"
		)
		awful.client.urgent.jumpto()
	end, { description = "", group = "launcher" }),

	awful.key({ modkey, "Shift", "Control" }, "r", function()
		awful.spawn("rofi -show window")
	end, { description = "", group = "launcher" }),

	awful.key({ modkey, "Shift" }, "b", function()
		awful.spawn("google-chrome-stable --new-window 'google.com/pizza'")
	end, { description = "", group = "launcher" }),

	awful.key({ modkey }, "b", function()
		awful.spawn("firefox --new-window")
	end, { description = "", group = "launcher" }),

	awful.key({ modkey }, "e", function()
		awful.spawn("rofimoji")
	end, { description = "", group = "launcher" }),

	-- Custom
	awful.key({ modkey }, "t", function()
		awful.spawn("redshift -O 3500")
	end, { description = "", group = "launcher" }),

	awful.key({ modkey, "Shift" }, "t", function()
		awful.spawn("redshift -x")
	end, { description = "", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		-- awful.prompt.run({
		-- 	prompt = "Run Lua code: ",
		-- 	textbox = awful.screen.focused().mypromptbox.widget,
		-- 	exe_callback = awful.util.eval,
		-- 	history_path = awful.util.get_cache_dir() .. "/history_eval",
		-- })
		awful.spawn.with_shell("xkill")
	end, { description = "lua execute prompt", group = "awesome" })
	-- Menubar
	--    awful.key({ modkey }, "p", function() menubar.show() end,
	--              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "v", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "w", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" }),
	awful.key({ modkey, "Shift" }, "p", function()
		awful.spawn.with_shell("flameshot gui")
	end, { description = "run command", group = "client" }),
	awful.key({ modkey }, "c", function(c)
		-- awful.spawn.with_shell("/home/giga/.config/scripts/mpv-clipboard.sh")
		awful.spawn.with_shell("/home/giga/.config/scripts/screenshot-window.sh")
	end, { description = "run command", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c)
		-- awful.spawn.with_shell("/home/giga/.config/scripts/mpv-clipboard.sh")
		awful.spawn.with_shell("/home/giga/.config/scripts/screenshot-window-clipboard.sh")
	end, { description = "run command", group = "client" }),
	awful.key({ modkey, "Control" }, "c", function(c)
		-- awful.spawn.with_shell("/home/giga/.config/scripts/mpv-clipboard.sh")
		awful.spawn.with_shell("/home/giga/.config/scripts/screenshot-open-latest.sh")
	end, { description = "run command", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local keysTags = "asdfg"
for i = 1, 5 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, keysTags:sub(i, i), function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			local t = awful.screen.focused().selected_tag
			if tag then
				if t then
					if t == tag then
						awful.tag.viewtoggle(tag)
					else
						tag:view_only()
					end
				else
					tag:view_only()
				end
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		-- awful.key({ modkey, "Shift" }, keysTags:sub(i, i), function()
		-- awful.key({ modkey }, keysTags:sub(i, i), function()
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, keysTags:sub(i, i), function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

titleBarEnabled = io.popen("~/.config/ts-scripts/key.ts titleBarEnabled"):read("*all"):match("true")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = titleBarEnabled } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox Beta" }, properties = { screen = 1, tag = "fullscreen-II" } },
	-- { rule = { class = "jetbrains-studio" }, properties = { screen = 1, tag = "fullscreen" } },
	{ rule = { class = "mpv" }, properties = { screen = 1, tag = "fullscreen" } },
	-- { rule = { class = "Thunar" }, properties = { screen = 1, tag = "main" } },
	-- { rule = { class = "okular" }, properties = { screen = 1, tag = "main" } },
	-- { rule = { class = "alacritty" }, properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

local notify_id = 9999

local function show_stack(s)
	if not s then
		return
	end

	local focused = client.focus
	local lines = {}

	for _, c in ipairs(s:get_clients(false)) do
		local class = (c.class or ""):lower()

		if
			c.type ~= "dock"
			and class ~= "rofi"
			and class ~= "polybar"
			and class ~= "eww"
			and class ~= "xfce4-notifyd"
			and class ~= "Xfdesktop"
			and class ~= "Desktop"
			and class ~= "DHIS"
		then
			local prefix = (c == focused) and "▶ " or " ○ "
			table.insert(lines, string.format("%s%s — %s", prefix, c.class or "<unknown>", c.name or "<untitled>"))
		end
	end

	table.insert(lines, "")
	table.insert(lines, os.date("%a %d %b %Y  %H:%M:%S"))

	local g = s.workarea -- or s.geometry

	notif = naughty.notify({
		replaces_id = notif and notif.id or nil,
		title = ("Screen %d Window Stack"):format(s.index),
		text = table.concat(lines, "\n"),

		position = "bottom_right",
		timeout = 1.2,

		width = math.floor(g.width * 0.5),
	})

end

client.connect_signal("focus", function(c)
	if c then
		show_stack(c.screen)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}
--
--

awful.spawn.with_shell("~/.config/awesome/awesome-startup.sh")

modTabMode = io.popen("~/.config/ts-scripts/key.ts modTabMode"):read("*all")
function quickWindowSwitch()
	if modTabMode:match("swap") then
		awful.client.swap.byidx(1)
		awful.client.focus.byidx(-1)
	elseif modTabMode:match("swap-reverse") then
		awful.client.swap.byidx(-1)
		awful.client.focus.byidx(1)
	elseif modTabMode:match("cycle-forward") then
		awful.client.focus.byidx(1)
	else
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end
end

singleTapMod = io.popen("~/.config/ts-scripts/key.ts singleTapMod"):read("*all")
if singleTapMod:match("false") then
	globalkeys = gears.table.join(
		globalkeys,
		awful.key({ modkey }, "Tab", quickWindowSwitch, { description = "go back", group = "client" })
	)
else
	globalkeys = gears.table.join(
		globalkeys,
		awful.key({ "Tab" }, "Tab", quickWindowSwitch, { description = "go back", group = "client" })
	)
end

-- Set keys
root.keys(globalkeys)
-- }}}
