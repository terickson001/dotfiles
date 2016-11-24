import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main :: IO ()
main = do
    xmonad $ defaultConfig
        { terminal = "urxvt"
        , modMask  = mod1Mask -- Alt Key
        , borderWidth = 0
        , workspaces = myWorkspaces
        , manageHook = myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        }

modKey = mod1Mask

myWorkspaces :: [String]
myWorkspaces = ["1:dev", "2:web", "3:testing", "4", "5", "6", "7", "8", "9", "0", "-", "=:media"]

myManageHook = composeAll
    [ className =? "spotify" --> doShift "=:media"
    , manageDocks
    ]
