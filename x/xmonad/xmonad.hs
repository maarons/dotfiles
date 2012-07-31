import XMonad
import Data.Char
import Data.List
import Data.Monoid
import qualified Data.Map as M
import Control.Monad
import System.Exit

import Graphics.X11.Xinerama
    ( getScreenInfo
    )
import Graphics.X11.Xlib
    ( openDisplay
    , closeDisplay
    )
import Graphics.X11.ExtraTypes

import XMonad.Hooks.ManageDocks
    ( manageDocks
    , avoidStruts
    )
import XMonad.Layout.NoBorders
    ( smartBorders
    )
import XMonad.Hooks.EwmhDesktops
    ( ewmhDesktopsLogHook
    , ewmhDesktopsEventHook
    , ewmhDesktopsStartup
    , fullscreenEventHook
    )
import XMonad.Util.Run
    ( spawnPipe
    , safeSpawn
    , unsafeSpawn
    , hPutStrLn
    )
import XMonad.Hooks.ManageHelpers
    ( isInProperty
    )
import XMonad.Hooks.DynamicLog
    ( dynamicLogWithPP
    , defaultPP
    , ppOutput
    , ppCurrent
    , ppVisible
    , ppHidden
    , ppHiddenNoWindows
    , ppUrgent
    , ppSep
    , ppWsSep
    , ppTitle
    , ppLayout
    , ppOrder
    , ppSort
    , ppExtras
    , wrap
    , trim
    , xmobarColor
    )
import XMonad.Util.WorkspaceCompare
    ( getSortByXineramaPhysicalRule
    )
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

main = do
    -- List of displays as numbers ([1..]).
    displays <- getDisplays :: IO [Int]

    xmobarH <- mapM (spawnPipe . ("xmobar -x " ++) . show) displays

    xmonad $ defaultConfig
        -- Use Super instead of Alt.
        {  modMask = modKey
        -- Set default terminal command.
        , terminal = "urxvt"

        -- Get more workspaces.
        , workspaces = myWorkspaces

        -- manageDocks and avoidStruts make XMonad play nicely with panels.
        -- smartBorders won't display borders around full screen windows, etc.
        , manageHook = mconcat
            [ manageDocks
            -- Special treatment for some software.
            , myManageHook
            , manageHook defaultConfig
            ]
        , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig

        , logHook = mconcat
            -- Update xmobar on every action.
            [ myXmobarHook xmobarH
            -- Provide info for panels.
            , ewmhDesktopsLogHook
            , logHook defaultConfig
            ]

        , handleEventHook = mconcat
            -- React to panel clicks.
            [ ewmhDesktopsEventHook
            -- Play nice with applications that want the full screen.
            , fullscreenEventHook
            , handleEventHook defaultConfig
            ]

        , startupHook = mconcat
            -- Advertise EWMH support to the X server.
            [ ewmhDesktopsStartup
            -- Autostart stuff
            , myStartupHook
            , startupHook defaultConfig
            ]

        -- Use custom key bindings.
        , keys = myKeys
        }

-- Use 12 workspaces.
myWorkspaces = map show [1..12]

-- Use super as the mod key.
modKey = mod4Mask

myKeys conf =  M.fromList $ concat
    [ launchKeys conf
    , layoutKeys
    , workspaceKeys
    , xineramaKeys
    , focusKeys
    , orderKeys
    , restartKeys
    , masterAreaKeys
    , floatKeys
    , appKeys
    ]

appKeys =
    -- Volume control.
    [ ((0, xF86XK_AudioMute), safeSpawn "pa-control" ["--mute-switch"])
    , ((0, xF86XK_AudioRaiseVolume), safeSpawn "pa-control" ["--volume-up"])
    , ((0, xF86XK_AudioLowerVolume), safeSpawn "pa-control" ["--volume-down"])

    -- Media player control.
    , ((0, xF86XK_AudioNext), safeSpawn "banshee" ["--next"])
    , ((0, xF86XK_AudioPrev), safeSpawn "banshee" ["--restart-or-previous"])
    , ((0, xF86XK_AudioStop), safeSpawn "banshee" ["--stop"])
    , ((0, xF86XK_AudioPlay), safeSpawn "banshee" ["--toggle-playing"])

    -- Display lock.
    , ((0, xF86XK_Sleep), safeSpawn "shade" ["--sleep", "lock"])
    ]

launchKeys conf =
    [ ((modKey .|. shiftMask, xK_Return), safeSpawn (terminal conf) [])
    , ((modKey .|. shiftMask .|. controlMask, xK_c), kill)
    ]

layoutKeys =
    [ ((modKey, xK_n), sendMessage NextLayout)
    ]

focusKeys =
    [ ((modKey, xK_j), windows W.focusDown)
    , ((modKey, xK_k), windows W.focusUp)
    , ((modKey, xK_m), windows W.focusMaster)
    ]

floatKeys =
    [ ((modKey, xK_t), withFocused $ windows . W.sink)
    ]

orderKeys =
    [ ((modKey, xK_Return), windows W.shiftMaster)
    , ((modKey .|. shiftMask, xK_j), windows W.swapDown)
    , ((modKey .|. shiftMask, xK_k), windows W.swapUp)
    ]

masterAreaKeys =
    [ ((modKey, xK_h), sendMessage Shrink)
    , ((modKey, xK_l), sendMessage Expand)
    , ((modKey, xK_comma), sendMessage (IncMasterN 1))
    , ((modKey, xK_period), sendMessage (IncMasterN (-1)))
    ]

restartKeys =
    [ ((modKey, xK_q), unsafeSpawn "~/.xmonad/scripts/restart.sh")
    , ((modKey .|. shiftMask .|. controlMask, xK_p), cleanExit)
    ]

cleanExit = do
    unsafeSpawn "~/.xmonad/scripts/before_exit.sh"
    io (exitWith ExitSuccess)

myStartupHook = unsafeSpawn "~/.xmonad/scripts/on_restart.sh after"

-- Switch between physical screens/move windows between screens.
xineramaKeys =
    [ ((modKey, k), screenWorkspace s >>= flip whenJust (windows . W.view))
    | (k, s) <- zip [xK_a, xK_s, xK_d] [0..]
    ] ++
    [ ((modKey .|. shiftMask, k),
        screenWorkspace s >>= flip whenJust (windows . viewShift))
    | (k, s) <- zip [xK_a, xK_s, xK_d] [0..]
    ]
    where
        -- Move and switch focus.
        viewShift i = (W.view i) . (W.shift i)

-- Switch workspaces with F1-F12 keys.
workspaceKeys =
    [ ((modKey, fKey), windows $ W.greedyView wSpace)
    | (wSpace, fKey) <- zip myWorkspaces [xK_F1..xK_F12]
    ] ++
    [ ((modKey .|. shiftMask, fKey), windows $ W.shift wSpace)
    | (wSpace, fKey) <- zip myWorkspaces [xK_F1..xK_F12]
    ]

getDisplays = do
    d <- openDisplay ""
    i <- getScreenInfo d
    closeDisplay d
    return $ zipWith const [0..] i

myManageHook = composeAll
    -- Don't tile splash screens.
    [ isSplash --> doIgnore
    -- Don't tile notifications.
    , isNotification --> doIgnore
    -- Float VLC, Gimp and Wine windows.
    , className =? "Vlc" --> doFloat
    , className =? "Wine" --> doFloat
    ]

isSplash = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_SPLASH"

isNotification = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_NOTIFICATION"

myXmobarHook xmobarH = dynamicLogWithPP $ defaultPP
    { ppOutput = \s -> mapM_ ((flip hPutStrLn) s) xmobarH
    , ppCurrent = wrap "[" "]"
    , ppVisible = wrap "(" ")"
    , ppHidden = id
    , ppHiddenNoWindows = const ""
    , ppUrgent = id
    , ppSep = ":"
    , ppWsSep = " "
    , ppTitle = id
    , ppLayout = id
    , ppOrder = myPPOrder
    , ppSort = getSortByXineramaPhysicalRule
    , ppExtras = []
    }

-- Nicely formats list of workspaces:
-- [visible workspaces (maybe on multiple displays)] other workspaces
-- Currently active workspace is coloured and in brackets.
myPPOrder [workspaces, layout, title] =
    [formatWorkspaces workspaces, layout, title]

formatWorkspaces :: String -> String
formatWorkspaces workspaces = joinWorkspaces $ splitWorkspaces workspaces
    where
        splitWorkspaces w = splitWorkspaces' 'l' [] [] [] [] $ words w

        -- left of current screen, current, right of current screen, other (not
        -- displayed) workspaces.
        splitWorkspaces' _ l c r o [] =
            [ wSort l
            , wSort c
            , wSort r
            , wSort o
            ]

        splitWorkspaces' 'l' l c r o ((h:t):w)
            | h == '(' = splitWorkspaces' 'l' ((init t):l) c r o w
            | h == '[' = splitWorkspaces' 'r' l ((init t):c) r o w
            | otherwise = splitWorkspaces' 'o' l c r o ((h:t):w)

        splitWorkspaces' 'r' l c r o ((h:t):w)
            | h == '(' = splitWorkspaces' 'r' l c ((init t):r) o w
            | otherwise = splitWorkspaces' 'o' l c r o ((h:t):w)

        splitWorkspaces' 'o' l c r o w = splitWorkspaces' '_' l c r w []

        -- Sort by numeric value, not lexycographic order (2 should be before
        -- 12).
        wSort :: [String] -> String
        wSort l = unwords $ map show (sort $ map read l :: [Int])

        joinWorkspaces [l, c, r, o] = join
            [ "["
            , l
            , xmobarColor "yellow" "black" $ wrap lBracket rBracket c
            , r
            , "]"
            , displaySpace
            , o
            ]
            where
                join = foldl1 (\a b -> a ++ b)
                lBracket
                    | null l = "("
                    | otherwise = " ("
                rBracket
                    | null r = ")"
                    | otherwise = ") "
                displaySpace
                    | null o = ""
                    | otherwise = " "
