import XMonad

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isDialog, doCenterFloat)
import XMonad.Hooks.UrgencyHook

import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.NamedScratchpad

import XMonad.Layout
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spacing
import XMonad.Layout.WindowNavigation

import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer

import XMonad.ManageHook

import System.IO
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.Operations as Operations
import qualified XMonad.StackSet as W

main = do
    j <- spawnPipe "/home/cr0xd/main/friday/dotfiles/eww/modules/friday--notifications.sh --init &"
    h <- spawnPipe "eww close-all && eww reload && eww open dock && eww open control-center && eww open notification-center"
    xmonad
      $ docks
      $ ewmh
      $ withUrgencyHook NoUrgencyHook
    	$ defaultConfig
	{ modMask             = modm
	, terminal	          = term
	, focusFollowsMouse   = mouseFocus
	, borderWidth         = bdrSize
	, normalBorderColor   = bdrNormal
	, focusedBorderColor  = bdrFocus
  , workspaces          = workspaces'

  -- Hooks
  , handleEventHook     = eventHook
  , logHook             = logHook'
  , layoutHook          = layoutHook'
  , manageHook          = manageHook'
  , startupHook         = startupHook'
  } `additionalKeys` keyboard

modm          = mod4Mask
mouseFocus    = False
keyboard      = myKeys
workspaces'   = myWorkspaces
term	        = "kitty"
browser       = "chromium"

----- Appearance
font          = "Misc Termsyn.Icons:size=13"

blackColor = "#19171C"
whiteColor = "#F0ECF9"
mainColor1 = "#ef9eac"

bgColor       = blackColor
fgColor       = whiteColor
bdrSize       = 2
bdrNormal     = bgColor
bdrFocus      = mainColor1
barBgColor    = bgColor
barFgColor    = mainColor1

---- Hooks
eventHook     = fullscreenEventHook
logHook'      = myLogHook
layoutHook'   = myLayoutHook
manageHook'   = myManageHook <+> manageScratchPad
startupHook'  = myStartupHook
-- }}}

-- ------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
-- ------------------------------------------------------------------------

myLogHook = return ()

-- ------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- ------------------------------------------------------------------------

myStartupHook = do
  --
  -- Mouse
  --
  spawnOnce "xset mouse 0 0"
  spawnOnce "xinput --set-prop 'Logitech Gaming Mouse G600' 'libinput Accel Speed' -0.9"
  -- spawnOnce "xsetroot -cursor_name left_ptr"
  --
  -- Power Management
  --
  -- turn off Display Power Management Service (DPMS)
  spawnOnce "xset -dpms"
  -- turn off black screensaver
  spawnOnce "xset s off"
  -- do not turn off monitor
  --    blank 0     - blank the screen after n minutes ( 0 - 60 )
  --    powerdown 0 - go to sleep after n minutes in blanked mode ( 0 - 60 )
  spawnOnce "setterm -blank 0 -powerdown 0"
  --
  -- Additional
  --
  -- eww
  spawnOnce "eww daemon"
  -- background
  spawnOnce "feh --bg-fill $HOME/.xmonad/background.jpg"
  -- compositor ( additional window effects )
  spawnOnce "picom --config /dev/null -bGC --focus-exclude \"class_g = 'Dmenu'\" --inactive-dim 0.3"
  spawnOnce "xkbcomp ~/.xkb_layout.xkb $DISPLAY"
  spawnOnce "xclip"
  spawnOnce "redshift -P -O 5000"
  spawnOnce "sleep 2 && xmodmap $HOME/.Xmodmap"

-- ------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
-- ------------------------------------------------------------------------

myLayoutHook =
  avoidStruts
  $ mkToggle (NOBORDERS ?? FULL ?? EOT)
  $ onWorkspace (w !! 0) termLayout
  $ standardLayout
  where
    w = workspaces'
    termLayout =
      gaps [(L,50), (U,50), (R,50), (D,50)] $
      standardLayout
    standardLayout =
      smartBorders $
      renamed [CutWordsLeft 1] $
      smartSpacingWithEdge 8 $
      layoutHook defaultConfig

-- ------------------------------------------------------------------------

-- Scratchpad {{{
manageScratchPad :: ManageHook
manageScratchPad = namedScratchpadManageHook scratchpads

-- Issue :: Recompilation does not update the settings!
--
-- Xmonad is reusing processes that already exist ( does not know if it was spawned before, or after recompilation ).
--
--  To fix, you can manually kill existing scratchpads:
-- ( ps aux | grep -E "scratchpad|dotfiles" | awk '{print $2}' | xargs kill ); xmonad --recompile
--
terminalScratchpad :: NamedScratchpad
terminalScratchpad = NS "scratchpad" spawnTerm queryBool floating
    where spawnTerm = "kitty --title=scratchpad"
          queryBool = title =? "scratchpad"
          floating  = customFloating $ W.RationalRect l t w h
                      where
                        h = 0.5
                        w = 0.8
                        t = 1 - h
                        l = (1 - w) / 2

terminalDotfile :: NamedScratchpad
terminalDotfile = NS "dotfiles" spawnTerm queryBool floating
    where spawnTerm = "kitty --title=dotfiles -e /bin/bash -ic 'source ~/.bashrc; tmux--dot'"
          queryBool = title =? "dotfiles"
          floating  = customFloating $ W.RationalRect l t w h
                      where
                        h = 1
                        w = 1
                        t = 1 - h
                        l = (1 - w) / 2

scratchpads = [terminalScratchpad, terminalDotfile]
------ }}}


-- Workspaces {{{
myWorkspaces = ws $ ["term", "inet", "dev", "root", "play", "prod"]
  where
    ws l =
      [ "^ca(1,xdotool key super+" ++ show n ++ ")  " ++ ws ++ "  ^ca()"
      | (i, ws) <- zip [1 ..] l
      , let n = i
      ]
-- }}}


-- Manage Hook {{{
myManageHook =
  composeAll . concat $
  [ [ className =? c --> doShift (w !! 1) | c <- inetApp ]
  , [ className =? c --> doShift (w !! 2) | c <- devApp ]
  , [ className =? c --> doShift (w !! 3) | c <- entApp ]
  , [ className =? c --> doShift (w !! 4) | c <- playApp ]
  , [ className =? c --> doShift (w !! 5) | c <- prodApp ]
  , [ className =? c --> doFloat          | c <- floatingApp ]
  , [ className =? c --> doIgnore         | c <- ignoreApp ]
  , [ isDialog       --> doCenterFloat ]
  , [ isRole         --> doCenterFloat ]
  , [ manageDocks ]
  , [ manageHook def ]
  ]
  where
    w = workspaces'
    isRole = stringProperty "WM_WINDOW_ROLE" =? "pop-up"
    inetApp = ["Chromium", "Firefox"]
    devApp =
      [ "SecureCRT", "GNS3", "VirtualBox Manager"
      , "VirtualBox Machine", "jetbrains-studio"
      , "Code", "oni"
      ]
    entApp = ["MPlayer", "smplayer", "mpv", "Gimp"]
    playApp = ["player", "Genymotion Player"]
    prodApp = ["MuPDF"]
    floatingApp = ["SecureCRT", "TeamViewer", "Xmessage"]
    ignoreApp = ["desktop", "desktop_window", "stalonetray", "trayer"]
-- }}}

-- Keymapping {{{
myKeys =
  [ ((m, xK_b), spawn browser)
  , ((m, xK_KP_Enter), spawn term)
  , ((m, xK_d), spawn rofi)
  , ((m, xK_grave), toggleWS)
  , ((m, xK_f), sendMessage ToggleStruts)
  , ((m, xK_s), scratchPad)
  , ((m, xK_a), dotfilesPad)
  , ((0, 0x1008ff12), spawn "friday--audio--toggle")
  , ((0, 0x1008ff11), spawn "friday--audio--dec")
  , ((0, 0x1008ff13), spawn "friday--audio--inc")
  , ((m, xK_F1), spawn "friday--screenshot--take")
  , ((m, xK_F2), spawn "friday--screenshot--edit")
  , ((m, xK_q), Operations.kill)
  , ((m, xK_r), spawn reloadXmonad)
  ]
  where
    m            = modm
    s            = shiftMask
    c            = controlMask
    scratchPad   = namedScratchpadAction scratchpads "scratchpad"
    dotfilesPad  = namedScratchpadAction scratchpads "dotfiles"
    reloadXmonad = "xmonad --recompile; pkill xmobar; xmonad --restart"
    rofi         = "rofi -show run -matching fuzzy"
-- }}}
