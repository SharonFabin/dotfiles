import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Util.Cursor
import XMonad.Actions.Navigation2D
import XMonad.Actions.CycleWS
import XMonad.Actions.CopyWindow
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile( MirrorResize( MirrorShrink, MirrorExpand ) )
import XMonad.Layout.MultiToggle 
import XMonad.Layout.MultiToggle.Instances 
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
dev_extra_workspace = "\xf16c "
reading_workspace = "\xe28b "
chat_workspace = "\xf868 "
tasks_workspace = "\xf634 "
music_workspace = "\xf1bc "
myWorkspaces    = [terminal_workspace, web_workspace, dev_workspace, dev_extra_workspace, reading_workspace, chat_workspace, tasks_workspace, "8", music_workspace]


myBorderWidth = 1
myNormalBorderColor  = "#290000"
myFocusedBorderColor = "#eb4034"
myFont = "xft:TerminessTTF Nerd Font:size=13:antialias=true:hinting=true"

myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }


mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True


defaultLayout = tiled ||| tabbed shrinkText myTabTheme
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

myLayout = avoidStruts $ smartBorders $ mkToggle (NOBORDERS ?? FULL ?? EOT) $ windowNavigation $ mySpacing 8 $ defaultLayout

-- Mouse Bindings
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((modMask, button3), (\w -> focus w >> windows W.swapMaster))
    , ((modMask, button2), (\w -> focus w >> mouseResizeWindow w))
    , ((0, button2), (\w -> kill))
    ]


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
    resourceFloats = ["Toolkit"]
    ignores = ["desktop_window"]
    webShifts = ["Chromium", "Google-chrome", "firefox"]
    devShifts = ["Code"]
    readingShifts = ["qpdfview, Xreader"]
    chatShifts = ["Whatsapp-for-linux", "whatsapp-nativefier-d40211"]
    tasksShifts = ["ClickUp Desktop", "notion-app-enhanced"]
    musicShifts = ["Spotify"]

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "~/.xmonad/scripts/autostart.sh"
  spawnOnce "picom &"
  spawnOnce "lxpolkit &"
  spawnOnce "nm-applet &"
  spawnOnce "nitrogen --restore &"
  spawnOnce "~/dotfiles/arch/scripts/bin/set-keyboard-layout-us &"
  setWMName "LG3D"

myKeys = 
        [ ("M1-l", spawn "$HOME/dotfiles/arch/scripts/bin/lock")
        , ("M-p", spawn rofi_launcher)
        , ("C-<Print>", spawn "sleep 0.2; shutter -s -e -n -o ~/Pictures/screenshots/%d-%m-%Y-%T.jpg && notify-send 'Screen Captured'")
        , ("<Print>", spawn "maim ~/Pictures/screenshots/$(date +%Y%m%d_%H%M%S).jpg && notify-send 'Screen Captured'")
        , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        , ("<XF86AudioMute>", spawn "amixer set Master toggle")
        , ("M-<XF86AudioMute>", spawn "playerctl --player spotify play-pause")
        , ("M-<XF86AudioLowerVolume>", spawn "playerctl --player spotify previous")
        , ("M-<XF86AudioRaiseVolume>", spawn "playerctl --player spotify next")
        , ("<XF86MonBrightnessUp>", spawn "lux -a 10%")
        , ("<XF86MonBrightnessDown>", spawn "lux -s 10%")
        , ("M1-<Space>", spawn "$HOME/dotfiles/arch/scripts/bin/layout_switch")
        , ("M1-q", spawn "$HOME/dotfiles/arch/scripts/bin/refresh_displays")
        , ("M-f", sendMessage $ Toggle FULL)
        , ("M-l", windowGo R False)
        , ("M-h", sendMessage $ Go L)
        , ("M-k", windows W.focusUp)
        , ("M-j", windows W.focusDown)
        , ("M-<Tab>", toggleWS)
        , ("M-S-h", sendMessage Shrink)
        , ("M-S-l", sendMessage Expand)
        , ("M-S-j", sendMessage MirrorShrink)
        , ("M-S-k", sendMessage MirrorExpand)
        , ("M-C-j", windows W.swapDown  )
        , ("M-C-k", windows W.swapUp    )
        , ("M-C-<Left>", sendMessage (IncMasterN 1))
        , ("M-C-<Right>", sendMessage (IncMasterN (-1)))
        , ("M-a" , windows copyToAll)
        , ("M-C-a", killAllOtherCopies)
        , ("M-S-a", kill1)
        ]

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
        , layoutHook = myLayout
        , logHook = dynamicLogWithPP xmobarPP
                -- ppOutput = hPutStrLn xmproc
                { ppOutput = \x -> hPutStrLn xmproc0 x                          -- xmobar on monitor 1
                                >> hPutStrLn xmproc1 x                          -- xmobar on monitor 2
                , ppTitle = (\str -> "")
                , ppCurrent = xmobarColor "#eb4034" "" . wrap "" ""
                , ppVisible = xmobarColor "#fcba03" "" . wrap "" ""
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
                ,mouseBindings = myMouseBindings
        } `additionalKeysP` myKeys

