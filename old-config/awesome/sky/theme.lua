-------------------------------
--    "Sky" awesome theme    --
--  By Andrei "Garoth" Thorp --
-------------------------------
-- If you want SVGs and extras, get them from garoth.com/awesome/sky-theme

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local themes_path = require("gears.filesystem").get_themes_dir()


-- BASICS
local theme                                     = {}
theme.font                                      = "monospace 10"

theme.bg_normal                                 = "#1B1D1E"
theme.bg_focus                                  = "#1B1D1E"
theme.bg_urgent                                 = "#1B1D1E"
theme.bg_minimize                               = "#1B1D1E"
theme.bg_systray                                = theme.bg_normal

theme.fg_normal                                 = "#75715E"
theme.fg_focus                                  = "#9c64fe"
theme.fg_urgent                                 = "#F92672"
theme.fg_minimize                               = "#75715E"

theme.useless_gap                               = dpi(1)
theme.border_width                              = dpi(1.5)
theme.border_normal                             = "#000000"
theme.border_focus                              = "#A6E22E"
theme.border_marked                             = "#91231c"

-- IMAGES
theme.layout_fairh                              = themes_path .. "sky/layouts/fairh.png"
theme.layout_fairv                              = themes_path .. "sky/layouts/fairv.png"
theme.layout_floating                           = themes_path .. "sky/layouts/floating.png"
theme.layout_magnifier                          = themes_path .. "sky/layouts/magnifier.png"
theme.layout_max                                = themes_path .. "sky/layouts/max.png"
theme.layout_fullscreen                         = themes_path .. "sky/layouts/fullscreen.png"
theme.layout_tilebottom                         = themes_path .. "sky/layouts/tilebottom.png"
theme.layout_tileleft                           = themes_path .. "sky/layouts/tileleft.png"
theme.layout_tile                               = themes_path .. "sky/layouts/tile.png"
theme.layout_tiletop                            = themes_path .. "sky/layouts/tiletop.png"
theme.layout_spiral                             = themes_path .. "sky/layouts/spiral.png"
theme.layout_dwindle                            = themes_path .. "sky/layouts/dwindle.png"
theme.layout_cornernw                           = themes_path .. "sky/layouts/cornernw.png"
theme.layout_cornerne                           = themes_path .. "sky/layouts/cornerne.png"
theme.layout_cornersw                           = themes_path .. "sky/layouts/cornersw.png"
theme.layout_cornerse                           = themes_path .. "sky/layouts/cornerse.png"

theme.awesome_icon                              = themes_path .. "sky/awesome-icon.png"

-- from default for now...
theme.menu_submenu_icon                         = themes_path .. "default/submenu.png"

-- Generate taglist squares:
local taglist_square_size                       = dpi(7)
theme.taglist_squares_sel                       = theme_assets.taglist_squares_sel(
    taglist_square_size, "#dfd561"
)
theme.taglist_squares_unsel                     = theme_assets.taglist_squares_unsel(
    taglist_square_size, "#f3005f"
)

-- MISC
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/wallpaper/wallpaper.jpg"
theme.taglist_squares                           = "true"
theme.titlebar_close_button                     = "true"
theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(400)

-- Define the image to load
theme.titlebar_close_button_normal              = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "default/titlebar/maximized_focus_active.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

--[[
background #191919
foreground #c4c4b5
cursor #f6f6ec
selection_background #343434
color0 #191919
color8 #615e4b
color1 #f3005f
color9 #f3005f
color2 #97e023
color10 #97e023
color3 #fa8419
color11 #dfd561
color4 #9c64fe
color12 #9c64fe
color5 #f3005f
color13 #f3005f
color6 #57d1ea
color14 #57d1ea
color7 #c4c4b5
color15 #f6f6ee
selection_foreground #191919
    --]]
