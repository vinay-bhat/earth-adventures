
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local main=audio.loadSound('main.wav')

audio.play(main)

local function gotoArcade()
	audio.pause(main)
    composer.removeScene( "arcade" )
    composer.gotoScene( "arcade", { time=800, effect="crossFade" } )
end



local function gotoHighScores()
    composer.removeScene( "highscores" )
    composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect( sceneGroup,"background.png", 2024, 768 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local earth = display.newImageRect( sceneGroup,"earth.png", 700, 190 )
	earth.x =  display.contentCenterX
	earth.y = 100

	local adventure = display.newImageRect( sceneGroup,"adventure.png", 1300, 218 )
	adventure.x =  display.contentCenterX
	adventure.y = 300


	local playButton = display.newImageRect( sceneGroup,"ButtonPlay.png", 425, 218 )
	playButton.x = 80
	playButton.y = 600

	local highScoresButton = display.newImageRect( sceneGroup,"ButtonScore.png", 425, 218 )
	highScoresButton.x = 900
	highScoresButton.y = 600

    playButton:addEventListener( "tap", gotoArcade )
    highScoresButton:addEventListener( "tap", gotoHighScores )

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
