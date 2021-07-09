import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Gaps
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.Navigation2D
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import Graphics.X11.ExtraTypes.XF86
import System.IO

terminal_workspace = "\xf66b "
web_workspace = "\xfa9e "
dev_workspace = "\xf121 "
music_workspace = "\xf1bc "
myWorkspaces    = [terminal_workspace, web_workspace, dev_workspace, "1", "2", "3", "5", "6", music_workspace]
myBorderWidth = 1
myNormalBorderColor  = "#290000"
myFocusedBorderColor = "#755454"

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , className =? "Code" --> doShift dev_workspace
    , className =? "Spotify" --> doShift music_workspace
    , className =? "Google-chrome" --> doShift web_workspace
    , className =? "firefox" --> doShift web_workspace
    , isFullscreen -->  doFullFloat
    , resource  =? "kdesktop"       --> doIgnore ]


myStartupHook = do
        spawnOnce "picom --experimental-backends &"
        spawnOnce "nm-applet &"
        spawnOnce "nitrogen --restore &"
        spawnOnce "xautolock -time 10 -locker '$HOME/dotfiles/arch/scripts/lock2.sh' &"

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True




main = do   
    xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc0"
    xmonad 
        $ navigation2D def
        (xK_Up, xK_Left, xK_Down, xK_Right)
        [       (mod4Mask,               windowGo  ),
                (mod4Mask .|. shiftMask, windowSwap)]
        False
        $ docks defaultConfig
        { handleEventHook    = fullscreenEventHook
        , layoutHook = avoidStruts $ smartBorders $ mySpacing 8 $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = (\str -> "")
                        , ppCurrent = xmobarColor "#eb4034" "" . wrap "" ""
                        , ppSep = " | "
                        , ppOrder  = \(ws:l:t:_)   -> [ws]
                        }
	, terminal = "alacritty"
        , modMask = mod1Mask     -- Rebind Mod to the Windows key
	, startupHook = myStartupHook
        , workspaces = myWorkspaces
        , borderWidth = myBorderWidth
        , focusedBorderColor = myFocusedBorderColor
        , normalBorderColor = myNormalBorderColor
        , manageHook = myManageHook <+> manageHook defaultConfig
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask , xK_l), spawn "$HOME/dotfiles/arch/scripts/lock2.sh")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
	, ((0, xF86XK_AudioLowerVolume   ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        , ((0, xF86XK_AudioRaiseVolume   ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        , ((0, xF86XK_AudioMute          ), spawn "amixer set Master toggle")
        , ((mod4Mask, xK_F1          ), spawn "playerctl play-pause")
        , ((mod4Mask, xK_F2          ), spawn "playerctl previous")
        , ((mod4Mask, xK_F3          ), spawn "playerctl next")
	, ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%")
	, ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%")
	, ((mod4Mask, xK_space), spawn "$HOME/dotfiles/arch/scripts/layout_switch.sh")
        ]

