import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

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
        , ((mod4Mask , xK_Escape), spawn "$HOME/dotfiles/arch/scripts/lock2.sh")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]

