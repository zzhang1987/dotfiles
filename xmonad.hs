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
import XMonad.Actions.CycleWS
import XMonad.Util.SpawnOnce


myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]


myStartHook = do
  spawnOnce "/usr/bin/feh --bg-scale ${HOME}/.wallpaper.jpg"
  spawnOnce "/usr/bin/xrdb -merge ~/.Xresources"
  spawnOnce "trayer --edge top --align right --expand true --width 10 --transparent true --tint 0x333333 --alpha 0 --height 28 --monitor 1 && sleep 1"
  spawnOnce "/usr/bin/nm-applet --sm-disable"
  spawnOnce "~/.gem/ruby/2.6.0/bin/fusuma"
  spawnOnce "/usr/bin/xbindkeys"
  spawnOnce "/usr/bin/xcompmgr"
  spawnOnce "/usr/bin/trayer"
  spawnOnce "/usr/bin/ibus-daemon -x -d"
  spawnOnce "/usr/bin/conky"
  spawnOnce "/usr/bin/albert"
  spawnOnce "/usr/bin/blueberry-tray"
  spawnOnce "/usr/bin/nextcloud"
  spawnOnce "/usr/bin/xscreensaver"

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ desktopConfig 
    {startupHook = myStartHook
    , manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                  <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
                }
    , terminal    = "xterm"
    , modMask     = mod4Mask
    }`additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((controlMask .|. shiftMask, xK_t), spawn "xterm")
        , ((0, xK_Print), spawn "scrot")
        , ((shiftMask, xK_Insert), pasteSelection)
        , ((mod4Mask .|. shiftMask, xK_s), spawn "xrandr --auto --output eDP1 --scale 1x1")
        , ((mod4Mask .|. shiftMask, xK_d), spawn "xrandr --output DP1 --primary --left-of eDP1 --output eDP1 --scale 1x1 --auto")
        , ((controlMask .|. shiftMask, xK_Down), nextWS)
        , ((controlMask .|. shiftMask, xK_Up), prevWS)
        , ((controlMask .|. shiftMask, xK_Right), nextScreen)
        , ((controlMask .|. shiftMask, xK_Left), prevScreen)
        ]


