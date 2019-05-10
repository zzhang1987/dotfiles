import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Util.Paste
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit


myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]


main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ desktopConfig 
    {manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                  <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
                }
    , terminal    = "urxvt"
    , modMask     = mod4Mask
    }`additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((shiftMask, xK_Insert), pasteSelection)
        , ((mod4Mask .|. shiftMask, xK_s), spawn "xrandr --auto")
        , ((mod4Mask .|. shiftMask, xK_d), spawn "xrandr --output DP1 --primary --left-of eDP1 --output eDP1 --auto")
        ]


