import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Graphics.X11.ExtraTypes.XF86
import System.IO

borderWidth = 0
focusedBorderColor = 000000


myStartupHook = do
        spawnOnce "picom &"
        spawnOnce "nm-applet &"
        spawnOnce "nitrogen --restore &"

main = do   
    xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc0"
    xmonad $ docks defaultConfig
        { layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
	, terminal = "alacritty"
        , modMask = mod1Mask     -- Rebind Mod to the Windows key
	, startupHook = myStartupHook
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask , xK_l), spawn "$HOME/dotfiles/arch/scripts/lock2.sh")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
	, ((0, xF86XK_AudioLowerVolume   ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        , ((0, xF86XK_AudioRaiseVolume   ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        , ((0, xF86XK_AudioMute          ), spawn "amixer set Master toggle")
	, ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%")
	, ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%")
	, ((mod4Mask, xK_space), spawn "$HOME/dotfiles/arch/scripts/layout_switch.sh")
        ]

