import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Cursor
import XMonad.Actions.Navigation2D
import XMonad.Actions.CycleWS
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile( MirrorResize( MirrorShrink, MirrorExpand ) )
import Graphics.X11.ExtraTypes.XF86
import System.IO
import Control.Monad ((>=>), join, liftM, when)
import Data.Maybe (maybeToList)

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.ByteString as B
import Control.Monad (liftM2)
import qualified DBus as D
import qualified DBus.Client as D

rofi_launcher = "rofi -no-lazy-grab -show drun -modi run,drun,window -theme $HOME/.config/rofi/launcher/style -drun-icon-theme \"candy-icons\""

-- EWMH full screen support
addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

-- Workspaces
terminal_workspace = "\xf66b "
web_workspace = "\xfa9e "
dev_workspace = "\xf121 "
reading_workspace = "\xe28b "
chat_workspace = "\xf868 "
tasks_workspace = "\xf634 "
music_workspace = "\xf1bc "
myWorkspaces    = [terminal_workspace, web_workspace, dev_workspace, reading_workspace, chat_workspace, tasks_workspace, "5", "6", music_workspace]


myBorderWidth = 1
myNormalBorderColor  = "#290000"
myFocusedBorderColor = "#eb4034"


myLayout = tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

myModMask = mod1Mask 
-- controlMask = ctrl key


-- window manipulations
myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [isFullscreen -->  doFullFloat]
    , [className =? c --> doCenterFloat | c <- centerFloats]
    , [title =? t --> doFloat | t <- floats]
    , [resource =? r --> doFloat | r <- resourceFloats]
    , [resource =? i --> doIgnore | i <- ignores]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo web_workspace | x <- webShifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo dev_workspace | x <- devShifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo reading_workspace | x <- readingShifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo chat_workspace | x <- chatShifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo tasks_workspace | x <- tasksShifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo music_workspace | x <- musicShifts]
    ]
    where
    doShiftAndGo = doF . liftM2 (.) W.greedyView W.shift
    centerFloats = ["Arandr", "Arcolinux-calamares-tool.py", "Arcolinux-tweak-tool.py", "Arcolinux-welcome-app.py", "Galculator", "feh", "mpv", "Xfce4-terminal", "vlc"]
    floats = ["Downloads", "Save As..."]
    resourceFloats = []
    ignores = ["desktop_window"]
    webShifts = ["Chromium", "Google-chrome", "firefox"]
    devShifts = ["Code"]
    readingShifts = ["qpdfview"]
    chatShifts = ["Whatsapp-for-linux", "whatsapp-nativefier-d40211"]
    tasksShifts = ["ClickUp Desktop", "notion-app-enhanced"]
    musicShifts = ["Spotify"]


{-
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , className =? "Code" --> doShift dev_workspace
    , className =? "spotify" --> doShift music_workspace
    , className =? "Google-chrome" --> doShift web_workspace
    , className =? "firefox" --> doShift web_workspace
    , className =? "Whatsapp-for-linux" --> doShift chat_workspace
    , className =? "ClickUp Desktop" --> doShift tasks_workspace
    , className =? "qpdfview" --> doShift reading_workspace
    , isFullscreen -->  doFullFloat
    , resource  =? "kdesktop"       --> doIgnore ]
-}


myStartupHook = do
	spawn "~/.xmonad/scripts/autostart.sh"
        spawnOnce "picom &"
	spawnOnce "lxpolkit &"
        spawnOnce "nm-applet &"
        spawnOnce "nitrogen --restore &"
        spawnOnce "xautolock -time 10 -locker '$HOME/dotfiles/arch/scripts/lock2.sh' &"
	spawnOnce "~/dotfiles/arch/scripts/set-keyboard-layout-us.sh"
	setWMName "LG3D"

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True


main = do   
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobarrc0"
    xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmobar/xmobarrc0"
    xmonad 
        $ navigation2D def
        (xK_Up, xK_Left, xK_Down, xK_Right)
        [       (mod4Mask,               windowGo  ),
                (mod4Mask .|. shiftMask, windowSwap)]
        False
        $ docks $ ewmh defaultConfig
        { handleEventHook    = fullscreenEventHook
        , layoutHook = avoidStruts $ smartBorders $ windowNavigation $ mySpacing 8 $ myLayout
        , logHook = dynamicLogWithPP xmobarPP
                        --{ ppOutput = hPutStrLn xmproc
			
			{ ppOutput = \x -> hPutStrLn xmproc0 x                          -- xmobar on monitor 1
				        >> hPutStrLn xmproc1 x                          -- xmobar on monitor 2
                        , ppTitle = (\str -> "")
                        , ppCurrent = xmobarColor "#eb4034" "" . wrap "" ""
                        , ppSep = " | "
                        , ppOrder  = \(ws:l:t:_)   -> [ws]
                        }
	, terminal = "alacritty"
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
	, startupHook = myStartupHook >> addEWMHFullscreen
        , workspaces = myWorkspaces
        , borderWidth = myBorderWidth
        , focusedBorderColor = myFocusedBorderColor
        , normalBorderColor = myNormalBorderColor
        , manageHook = myManageHook <+> manageHook defaultConfig
        } `additionalKeys`
        [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod1Mask , xK_l), spawn "$HOME/dotfiles/arch/scripts/lock2.sh")
        , ((mod4Mask , xK_p), spawn rofi_launcher)
        , ((controlMask, xK_Print), spawn "sleep 0.2; maim -s ~/Pictures/screenshots/$(date +%Y%m%d_%H%M%S).jpg && notify-send 'Screen Captured'")
        , ((0, xK_Print), spawn "maim ~/Pictures/screenshots/$(date +%Y%m%d_%H%M%S).jpg && notify-send 'Screen Captured'")
	, ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
        , ((mod4Mask, xK_F1), spawn "playerctl --player spotify play-pause")
        , ((mod4Mask, xK_F2), spawn "playerctl --player spotify previous")
        , ((mod4Mask, xK_F3), spawn "playerctl --player spotify next")
	, ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%")
	, ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%")
	, ((mod1Mask, xK_space), spawn "$HOME/dotfiles/arch/scripts/layout_switch.sh")
	, ((mod4Mask, xK_l), sendMessage $ Go R)
	, ((mod4Mask, xK_h), sendMessage $ Go L)
   	, ((mod4Mask, xK_k), sendMessage $ Go U)
   	, ((mod4Mask, xK_j), sendMessage $ Go D)
   	, ((mod4Mask , xK_Tab), toggleWS)
	, ((mod4Mask .|. shiftMask, xK_h), sendMessage Shrink)
	, ((mod4Mask .|. shiftMask, xK_l), sendMessage Expand)
	, ((mod4Mask .|. shiftMask, xK_j), sendMessage MirrorShrink)
	, ((mod4Mask .|. shiftMask, xK_k), sendMessage MirrorExpand)
	, ((controlMask .|. mod4Mask, xK_j), windows W.swapDown  )
	, ((controlMask .|. mod4Mask, xK_k), windows W.swapUp    )
	, ((controlMask .|. mod4Mask, xK_Left), sendMessage (IncMasterN 1))
	, ((controlMask .|. mod4Mask, xK_Right), sendMessage (IncMasterN (-1)))
        ]

