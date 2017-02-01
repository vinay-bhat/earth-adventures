
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()

local score = 0

local arrowTable = {}

local gameLoopTimer
local arrow
local balloon
local scoreNumber
local scoreText
local platform
local platform1
local scoreTimer
local backGroup
local mainGroup
local uiGroup
local cloud1
local cloud2

local function updateScore()
score = score + 1
scoreNumber.text = score
end

local function scrollCloud(cloud1)
	if cloud1.x<-240 
		then cloud1.x=720 
	else cloud1.x=cloud1.x-0.25
	end
end

local function scrollCloud(cloud2)
	if cloud2.x<-240 
		then cloud2.x=720 
	else cloud2.x=cloud2.x-0.25
	end
end


local function createArrow()

    arrow = display.newImageRect( mainGroup, "arrow.png",  350, 100 )
    table.insert( arrowTable, arrow )
    physics.addBody( arrow, "dynamic", { radius=40, density=0.3, bounce=0.0} )
    arrow.gravityScale = 0.0
     arrow.myName = "asteroid"
     local whereFrom =  1
     if ( whereFrom == 1 ) then
         	arrow.x = display.contentWidth + 60
        	arrow.y = math.random( 90,700 )
            arrow:applyLinearImpulse( -25, 0, arrow.x, arrow.y )    

    end 

end

local function onBackgroundTouch( event )

	if event.phase == "began" then 

		 balloon:applyLinearImpulse( 0, -0.5, balloon.x, balloon.y )
	end
end



local function gameLoop()

    -- Create new asteroid
    createArrow()

    -- Remove asteroids which have drifted off screen
    for i = #arrowTable, 1, -1 do
        local thisAsteroid = arrowTable[i]

        if ( thisAsteroid.x < -100 or
             thisAsteroid.x > display.contentWidth + 100 or
             thisAsteroid.y < -100 or
             thisAsteroid.y > display.contentHeight + 100 )
        then
            display.remove( thisAsteroid )
            table.remove( arrowTable, i )
        end
    end
end

local function endGame()
	
    composer.setVariable( "finalScore", score )
    composer.removeScene( "highscores" )
    print("game")
    composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
end

local function onLocalCollision( self, event )

    if ( event.phase == "began" ) then
        
        display.remove( balloon )

        
        timer.performWithDelay( 1, endGame )

         for i = #arrowTable, 1, -1 do
                if ( arrowTable[i] == balloon  ) then
                    table.remove( arrowTable, i )
                    break
                end
            end
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	 physics.pause()  -- Temporarily pause the physics engine
	   -- Set up display groups
    backGroup = display.newGroup()  -- Display group for the background image
    sceneGroup:insert( backGroup )  -- Insert into the scene's view group

    mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
    sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

    uiGroup = display.newGroup()    -- Display group for UI objects like the score
    sceneGroup:insert( uiGroup )    -- Insert into the scene's view group


	local background = display.newImageRect( backGroup,"bg.png", 1024, 768 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	balloon = display.newImageRect( mainGroup,"hotair.png", 150, 150 )
	balloon.x = display.contentCenterX-350
	balloon.y = display.contentCenterY
	physics.addBody( balloon, "dynamic", { radius=50} )
	balloon.alpha = 0.8
	balloon.myName = "balloon"

	cloud1 = display.newImageRect(mainGroup,"cloud.png",1000,300);
	cloud1.x = display.contentCenterX
	cloud1.y = display.contentHeight-580

	cloud2 = display.newImageRect(mainGroup,"cloud.png",1000,300);
	cloud2.x = display.contentCenterX+1100
	cloud2.y = display.contentHeight-580

	platform = display.newImageRect( mainGroup,"spike.png", 1900, 70 )
	platform.x = display.contentCenterX
	platform.y = display.contentHeight-0
	physics.addBody( platform, "static" )
	platform.myName = "plat"

	platform1 = display.newImageRect( mainGroup,"spike1.png", 1900, 70 )
	platform1.x = display.contentCenterX
	platform1.y = display.contentHeight-780
	physics.addBody( platform1, "static" )
	platform1.myName = "plat1"

	scoreNumber = display.newText(uiGroup,score, 310, 80, nil, 50)
	scoreNumber.xScale = 1.2
	scoreNumber.yScale = 1.2

	scoreText = display.newText( uiGroup,"score:", 200, 80, nil, 50)
	scoreText.xScale = 1.2
	scoreText.yScale = 1.2

	
	Runtime:addEventListener( "touch", onBackgroundTouch )
	cloud1.enterFrame=scrollCloud
	Runtime:addEventListener( "enterFrame", cloud1 )
	cloud2.enterFrame=scrollCloud
	Runtime:addEventListener( "enterFrame", cloud2 )



end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
        balloon.collision = onLocalCollision
		balloon:addEventListener( "collision")
		scoreTimer = timer.performWithDelay(1000, updateScore, -0.1)
        gameLoopTimer = timer.performWithDelay( 1000, gameLoop, 0 )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		  timer.cancel( gameLoopTimer )
		  timer.cancel( scoreTimer )


	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		-- balloon.collision = onLocalCollision
		-- balloon:removeEventListener( "collision")
		Runtime:removeEventListener( "collision", onLocalCollision )
		Runtime:removeEventListener("touch", onBackgroundTouch )
        physics.pause()

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
