
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local second=audio.loadSound('second.wav')
local uiGroup


audio.play(second)

local function gotoAir()
	audio.pause(second)
    composer.removeScene( "air" )
    composer.gotoScene( "air", { time=800, effect="crossFade" } )
end

local function gotoWater()
	audio.pause(second)
    composer.removeScene( "water" )
    composer.gotoScene( "water", { time=800, effect="crossFade" } )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect( sceneGroup,"image.png", 2024, 768 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY


    local airButton = display.newImageRect( sceneGroup,"fillbox.png", 1000, 400 )
	airButton.x = 90
	airButton.y = 200
		up = display.newText(sceneGroup,"FLY  UP", 995, 770, "J-LOG Cameron Edge Small Caps.otf", 70)
		up.x = 110
		up.y = 180 
		 up:setFillColor(0,0,0)


	local waterButton = display.newImageRect( sceneGroup,"fillbox.png", 1000, 400 )
	waterButton.x = 900
	waterButton.y = 600
	down = display.newText(sceneGroup,"DIVE  DOWN", 995, 770, "J-LOG Cameron Edge Small Caps.otf", 70)
		down.x = 920
		down.y = 580 
		 down:setFillColor(0,0,0)
    -- local highScoresButton = display.newText( sceneGroup, "High Scores", display.contentCenterX, 600, native.systemFont, 44 )
    -- highScoresButton:setFillColor(  0, 0, 0)

    airButton:addEventListener( "tap", gotoAir )
    -- highScoresButton:addEventListener( "tap", gotoHighScores )
     waterButton:addEventListener( "tap", gotoWater )

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen


	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
