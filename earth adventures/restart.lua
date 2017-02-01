
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


local function gotoAir()
    composer.removeScene( "air" )
    composer.gotoScene( "air", { time=800, effect="crossFade" } )
end

local function gotoMenu()
    composer.removeScene( "menu" )
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect( sceneGroup,"background.png", 1024, 768 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local final = display.newImageRect( sceneGroup,"ScoreScreen.png", 624, 768 )
	final.x = display.contentCenterX
	final.y = display.contentCenterY

    local restart = display.newImageRect( sceneGroup,"reload.png", 150, 200 )
	restart.x = 40
	restart.y = 600


	local home = display.newImageRect( sceneGroup,"homeButton.png", 150, 218 )
	home.x = 1000
	home.y = 600
	
    restart:addEventListener( "tap", gotoAir ) 
    
  	home:addEventListener("tap", gotoMenu)

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
