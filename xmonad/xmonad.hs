import Dzen
import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog hiding (dzen)
import XMonad.Hooks.UrgencyHook
import System.IO (hPutStrLn)

myLogHook h = dynamicLogWithPP $ defaultPP
	-- display the current workspace as dgrey on lgrey
	{ppCurrent = dzenColor "#303030" "#909090" . pad
	-- display other workspaces with windows as brigher grey
	,ppHidden = dzenColor "#909090" "" . pad
	-- normal grey for those without windows
	,ppHiddenNoWindows = dzenColor "#606060" "" .pad
	-- current layout as brighter grey
	,ppLayout = dzenColor "#909090" "" .pad
	-- color window which needs attention on hidden workspaces
	,ppUrgent = dzenColor "#ff0000" "" . pad . dzenStrip
	-- shorten if more than 100 chars
	,ppTitle = shorten 100
	-- no separator between workspaces
	,ppWsSep = ""
	-- some spaces between objects
	,ppSep = "  "

	, ppOutput = hPutStrLn h}


myLeftBar :: DzenConf
myLeftBar = defaultDzen
	{ width = Just $ Percent 60
	, fgColor = Just "#909090"
	, bgColor = Just "#303030" }

myRightBar :: DzenConf
myRightBar = myLeftBar
	{ xPosition = Just $ Percent 60
	, width = Just $ Percent 40
	, alignment = Just RightAlign }

myManageHook = (composeAll []) <+> manageDocks

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["main", "code", "web", "im"]

main = do
	d <- spawnDzen myLeftBar
        spawnToDzen "/home/thomas/.xmonad/status.sh" myRightBar
	xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
		{ borderWidth        = 2
		, terminal           = "urxvt"
		, normalBorderColor  = "#cccccc"
		, focusedBorderColor = "#cd8b00"
		, workspaces         = myWorkspaces
		, logHook = myLogHook d
		, layoutHook = avoidStruts $ layoutHook defaultConfig}
