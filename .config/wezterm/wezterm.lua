-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Basic Settings
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.use_ime = true
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Default Shell
local function get_default_prog()
  if wezterm.target_triple:find("windows") then
    return { "pwsh.exe" } 
  else
    return { "/bin/zsh", "-l" } -- macOS/Linux
  end
end
config.default_prog = get_default_prog()

-- Font Settings
config.font_size = 12.0
config.font_with_fallback = (
  wezterm.font_with_fallback({
    'HackGenNerd',
    'MesloLGS NF',
  })
)

-- Window Appearance
config.color_scheme = 'Kasugano (terminal.sexy)'
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"

-- Key Bindings
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

-- and finally, return the configuration to wezterm
return config
