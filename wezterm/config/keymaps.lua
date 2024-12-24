local wezterm = require('wezterm')
local action = wezterm.action

local keys = {
    -- tabs --
    -- tabs: spawn+close
    { key = 't', mods = 'SUPER', action = action.SpawnTab('DefaultDomain') },
    { key = 't', mods = 'SUPER', action = action.SpawnTab({ DomainName = 'WSL:Ubuntu' }) },
    { key = 'w', mods = 'SUPER', action = action.CloseCurrentTab({ confirm = false }) },

    -- tabs: navigation
    { key = '[', mods = 'SUPER', action = action.ActivateTabRelative(-1) },
    { key = ']', mods = 'SUPER', action = action.ActivateTabRelative(1) },

    -- panes --
    -- panes: split panes
    {
        key = [[-]],
        mods = 'SUPER',
        action = action.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
        key = [[\]],
        mods = 'SUPER',
        action = action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },

    -- panes: zoom+close pane
    { key = 'Enter', mods = 'SUPER', action = action.TogglePaneZoomState },
    { key = 'w',     mods = 'SUPER', action = action.CloseCurrentPane({ confirm = false }) },

    -- panes: navigation
    { key = 'k',     mods = 'SUPER', action = action.ActivatePaneDirection('Up') },
    { key = 'j',     mods = 'SUPER', action = action.ActivatePaneDirection('Down') },
    { key = 'h',     mods = 'SUPER', action = action.ActivatePaneDirection('Left') },
    { key = 'l',     mods = 'SUPER', action = action.ActivatePaneDirection('Right') },
    {
        key = 'p',
        mods = 'SUPER',
        action = action.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
    },

    -- panes: scroll pane
    { key = 'u',        mods = 'SUPER', action = action.ScrollByLine(-5) },
    { key = 'd',        mods = 'SUPER', action = action.ScrollByLine(5) },
    { key = 'PageUp',   mods = 'NONE',  action = action.ScrollByPage(-0.75) },
    { key = 'PageDown', mods = 'NONE',  action = action.ScrollByPage(0.75) },

    -- resize panes
    {
        key = 'r',
        mods = 'SUPER',
        action = action.ActivateKeyTable({
            name = 'resize_pane',
            one_shot = false,
            timemout_miliseconds = 1000,
        }),
    },
    {
        key = 'r',
        mods = 'SUPER|CTRL',
        action = action.ActivateKeyTable({
            name = 'resize_font',
            one_shot = false,
            timemout_miliseconds = 1000,
        }),
    },
}

local key_tables = {
    resize_font = {
        { key = 'k',      action = action.IncreaseFontSize },
        { key = 'j',      action = action.DecreaseFontSize },
        { key = 'r',      action = action.ResetFontSize },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
    resize_pane = {
        { key = 'k',      action = action.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'j',      action = action.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'h',      action = action.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'l',      action = action.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
}

return {
    disable_default_key_bindings = true,
    -- disable_default_mouse_bindings = true,
    leader = { key = ',', mods = 'SUPER|CTRL' },
    keys = keys,
    key_tables = key_tables,
}
