from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os
import subprocess

from libqtile import hook

mod = "mod4"
terminal = "alacritty"
menu = "rofi -show drun"
home = os.path.expanduser("~")
browser = "firefox"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/qtile-autostart.sh')
    subprocess.Popen([home])

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn(menu), desc="Launch menu"),
    Key([mod, "shift"], "f", lazy.spawn(browser), desc="Launch browser"),
    # Toggle between different layouts as defined below
    Key([mod], "tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi-cmd"), desc="Spawn a command using a prompt widget"),
    # screenstuff
    Key(
        [mod, "shift"],
        "Right",  # Example key combination (Ctrl + Left Arrow)
        lazy.window.toscreen(0),  # Move window to screen 1
        lazy.to_screen(0),
        desc="Move window to screen 1",
    ),
    Key(
        [mod, "shift"],
        "Left",  # Example key combination (Ctrl + Right Arrow)
        lazy.window.toscreen(1),  # Move window to screen 0
        lazy.to_screen(1),
        desc="Move window to screen 0",
    ),
    Key([mod], "right", lazy.to_screen(0), desc="Move focus to next monitor"),
    Key([mod], "left", lazy.to_screen(1), desc="Move focus to previous monitor"),
    Key([mod], "space", lazy.next_screen(), desc="Move focues to the next screen"),
    Key([mod, "control"], "right", lazy.layout.next_split()),
    Key([mod, "control"], "left", lazy.layout.next_split()),
    Key([mod, "control"], "n", lazy.layout.next()),

    Key([mod],"i", lazy.spawn("./brightness-down.sh"), desc="reduce brightness"),
    Key([mod],"XF86MonBrightnessUp", lazy.spawn("firefox"), desc="reduce brightness")]
# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [
    Group("1"),
    Group("2"),
    Group("3", label="web"),
    Group("4", matches=Match(wm_class="emacs"), label="emacs"),
    Group(
        "5",
        matches=[Match(wm_class="pavucontrol"), Match(title="ncspot")],
        label="music",
    ),
    Group("6", matches=Match(wm_class="virt-manager"), label="vm"),
    Group("7", label="email"),
    Group("8"),
    Group("9"),
]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            #:Key(
            #    [mod, "shift"],
            #   i.name,
            #    lazy.window.togroup(i.name, switch_group=True),
            #   desc="Switch to & move focused window to group {}".format(i.name),
            # ),
            # # mod1 + shift + group number = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )
    #######################
    ### Group shortcuts ###
    #######################

    keys.extend(
        [
            Key([mod], "m", lazy.group[groups[6].name].toscreen()),  # email
            Key([mod], "e", lazy.group[groups[3].name].toscreen()),  # emacs
            Key([mod], "b", lazy.group[groups[2].name].toscreen()),  # Browser
        ]
    )


layouts = [
    layout.Columns(border_focus="#000000", margin=[0, 2, 2, 2], border_width=0),
    layout.MonadTall(border_focus="#28464B", margin=4),
    layout.Max(),
    # layout.MonadWide(border_focus="#28464B"),
    # layout.Stack(num_stacks=2),
    # layout.Bsp
    # layout.Matrix(),
    layout.MonadThreeCol(ratio=0.6),
    # layout.RatioTile(),
    # layout.Tile(),
    layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


screens = [Screen()]  # u Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
