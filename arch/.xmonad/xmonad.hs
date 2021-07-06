import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.Navigation2D
import Graphics.X11.ExtraTypes.XF86
import System.IO

myWorkspaces    = ["terminal","web","dev","4","5","6","7","8","music"]
borderWidth = 0
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , className =? "Code" --> doShift "dev"
    , className =? "Spotify" --> doShift "music"
    , resource  =? "kdesktop"       --> doIgnore ]


myStartupHook = do
        spawnOnce "picom &"
        spawnOnce "nm-applet &"
        spawnOnce "nitrogen --restore &"
        spawnOnce "xautolock -time 10 -locker '$HOME/dotfiles/arch/scripts/lock2.sh' &"

main = do   
    xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc0"
    xmonad 
        $ navigation2D def
        (xK_Up, xK_Left, xK_Down, xK_Right)
        [       (mod4Mask,               windowGo  ),
                (mod4Mask .|. shiftMask, windowSwap)]
        False
        $ docks defaultConfig
        { layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
	, terminal = "alacritty"
        , modMask = mod1Mask     -- Rebind Mod to the Windows key
	, startupHook = myStartupHook
        , workspaces = myWorkspaces
        , manageHook = myManageHook <+> manageHook defaultConfig
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask , xK_l), spawn "$HOME/dotfiles/arch/scripts/lock2.sh")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
	, ((0, xF86XK_AudioLowerVolume   ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        , ((0, xF86XK_AudioRaiseVolume   ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        , ((0, xF86XK_AudioMute          ), spawn "amixer set Master toggle")
        , ((mod4Mask, xK_F1          ), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
        , ((mod4Mask, xK_F2          ), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
        , ((mod4Mask, xK_F3          ), spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
	, ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%")
	, ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%")
	, ((mod4Mask, xK_space), spawn "$HOME/dotfiles/arch/scripts/layout_switch.sh")
        ]

