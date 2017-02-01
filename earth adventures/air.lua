
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
local scoreNumber=0
local scoreText
local platform
local platform1
local scoreTimer=0
local backGroup
local mainGroup
local uiGroup


local background
-- local cloud1
-- local cloud2
local wind=audio.loadSound('wind.wav')

audio.play(wind)
local hot=audio.loadSound('baloonup.wav')
local thud=audio.loadSound('collide.wav')

local function updateScore()
score = score + 1
scoreNumber.text = score

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
        	arrow.y = math.random( 80,750 )
            arrow:applyLinearImpulse( -25, 0, arrow.x, arrow.y )    

    end 

end

local function onBackgroundTouch()

	

		 balloon:applyLinearImpulse( 0, -0.5, balloon.x, balloon.y )
		 audio.play(hot)
	
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




local function alert()

	  composer.removeScene( "menu" )
    
    print("game")
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
	
end



local function endGame()
	
    composer.setVariable( "finalScore", score )
	    scores = display.newText(uiGroup,"score", 995, 770, "J-LOG Cameron Edge Small Caps.otf", 85)
		scoreNumber.xScale = 1.2
		scoreNumber.yScale = 1.2 
		
     timer.performWithDelay( 3000, alert )

     transition.to(scoreNumber, {time = 600, x = 500, y = 400, onComplete = function() end})
     scoreNumber:setFillColor(0,0,0)
     transition.to(scores, {time = 600, x = 200, y = 395, onComplete = function() end})
     scores:setFillColor(0,0,0)
    
   

     	display.remove(press)
		display.remove(scoreText)
		

	 	 timer.cancel( gameLoopTimer )
		  timer.cancel( scoreTimer )

		
end




local function onLocalCollision( self, event )

    if ( event.phase == "began" ) then
    	audio.pause(hot)
         audio.play(thud)
        display.remove( balloon )

       
        
        timer.performWithDelay( 1, endGame )
        --endGame()

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

    function scrollCity(self,event)
    if self.x < -240 then
        self.x = 480+240
    else
        self.x = self.x - self.speed
    end
end

 function scrollCloud(self,event)
    if self.x < -240 then
        self.x = 480+240
    else
        self.x = self.x - self.speed
    end
end



    background1 = display.newImageRect( backGroup,"back.jpg", 2024, 768)
    background1.x = 240
    background1.y = 380
    background1.speed = 2
 
    background2 = display.newImageRect( backGroup,"back.jpg", 2024, 768)
    background2.x = 480+240
    background2.y = 380
    background2.speed = 2

    cloud1 = display.newImageRect( backGroup,"clouds.png", 2024, 768)
    cloud1.x = 280
    cloud1.y = 380
    cloud1.speed = 2

    cloud2 = display.newImageRect( backGroup,"clouds.png", 2024, 768)
    cloud2.x = 480+240
    cloud2.y = 380
    cloud2.speed = 2



	balloon = display.newImageRect( mainGroup,"hotair.png", 150, 150 )
	balloon.x = display.contentCenterX-350
	balloon.y = display.contentCenterY
	physics.addBody( balloon, "dynamic", { radius=50} )
	balloon.alpha = 1.8
	balloon.myName = "balloon"

	

	platform = display.newImageRect( mainGroup,"spike.png", 1900, 70 )
	platform.x = display.contentCenterX
	platform.y = display.contentHeight-0
	physics.addBody( platform, "static" )
	platform.alpha=0.02
	platform.myName = "plat"

	platform1 = display.newImageRect( mainGroup,"spike1.png", 1900, 70 )
	platform1.x = display.contentCenterX
	platform1.y = display.contentHeight-780
	physics.addBody( platform1, "static" )
	platform1.alpha=0.02
	platform1.myName = "plat1"

	scoreText= display.newImageRect( uiGroup,"scorewindows.png", 350, 250 )
	scoreText.x = display.contentCenterX-505
	scoreText.y = display.contentHeight-680

	scoreNumber = display.newText(uiGroup,score, 115, 90, "J-LOG Cameron Edge Small Caps.otf", 50)
	scoreNumber.xScale = 1.2
	scoreNumber.yScale = 1.2

	press = display.newImageRect( mainGroup,"homeButton.png",  2024, 968 )
	press.x = display.contentCenterX
	press.y = display.contentCenterY
	--physics.addBody( press, "static" )
	press.alpha=0.02
	
	press:addEventListener( "tap", onBackgroundTouch )
	

	background1.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", background1)

    background2.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", background2)

    cloud1.enterFrame = scrollCloud
    Runtime:addEventListener("enterFrame", cloud1)

    cloud2.enterFrame = scrollCloud
    Runtime:addEventListener("enterFrame", cloud2)

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
		 
		  --display.remove(scoreNumber)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		-- balloon.collision = onLocalCollision
		-- balloon:removeEventListener( "collision")
		Runtime:removeEventListener( "collision", onLocalCollision )
		--press:removeEventListener("tap", onBackgroundTouch )
		--Runtime:removeEventListener( "enterFrame", move )
		--background3.enterFrame = scrollCity
    	Runtime:removeEventListener("enterFrame", background1)

	   -- background4.enterFrame = scrollCity
	    Runtime:removeEventListener("enterFrame", background2)

	    Runtime:removeEventListener("enterFrame", cloud1)

	   -- background4.enterFrame = scrollCity
	    Runtime:removeEventListener("enterFrame", cloud2)
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
