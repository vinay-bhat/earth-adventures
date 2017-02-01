
local composer = require( "composer" )
local widget = require( "widget" )
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
local submarine = nil
local scoreNumber
local scoreText
local platform
local platform1
local scoreTimer
local backGroup
local mainGroup
local uiGroup
local base

local screenW = display.contentWidth
local screenH = display.contentHeight
local halfW = display.contentWidth * 0.5
local halfH = display.contentHeight * 0.5

local sonar=audio.loadSound('sonar.wav')
local thud=audio.loadSound('collide.wav')




local function updateScore()
score = score + 1
scoreNumber.text = score
end


local function createArrow()

    arrow = display.newImageRect( mainGroup, "shark.png",  250, 90 )
    table.insert( arrowTable, arrow )
    physics.addBody( arrow, "dynamic", { radius=40, density=0.3} )
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

	if event.phase == "ended" then 

		
		audio.play(sonar)

		transition.to( submarine, { time = 500, x = event.x, y = event.y } )

	end

	return true

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
    scores = display.newText(uiGroup,"score", 175, 770, "J-LOG Cameron Edge Small Caps.otf", 85)
	scoreNumber.xScale = 1.2
	scoreNumber.yScale = 1.2 

     timer.performWithDelay( 3000, alert )

     transition.to(scoreNumber, {time = 600, x = 520, y = 400, onComplete = function() end})
     scoreNumber:setFillColor(0,0,0)
     transition.to(scores, {time = 600, x = 220, y = 395, onComplete = function() end})
      scores:setFillColor(0,0,0)

    
   
      audio.pause(sonar)
 
		display.remove(arrow)
		display.remove(scoreText)

	 	 timer.cancel( gameLoopTimer )
		  timer.cancel( scoreTimer )
end




local function onLocalCollision( self, event )

    if ( event.phase == "began" ) then
        
        display.remove( submarine )
       -- audio.pause(sonar)
        audio.play(thud)

        
        endGame()
       -- timer.performWithDelay( 1, endGame )

         for i = #arrowTable, 1, -1 do
                if ( arrowTable[i] == submarine  ) then
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


    function scrollBackground(self,event)
    if self.x < -240 then
        self.x = 480+240
    else
        self.x = self.x - self.speed
    end
end

	 function scrollBase(self,event)
    if self.x < -300 then
        self.x = 480+300
    else
        self.x = self.x - self.speed
    end
end



	background = display.newImageRect( backGroup,"water.png", 2024, 768 )
	background.x = 240
	background.y = 380
	background.speed=2

	background1 = display.newImageRect( backGroup,"water.png", 2024, 768 )
	background1.x = 480+240
	background1.y = 380
	background1.speed=2
	

	submarine = display.newImageRect( mainGroup,"sub.png", 620, 420 )
	submarine.x = display.contentCenterX-350
	submarine.y = display.contentCenterY
	physics.addBody( submarine, "static", { radius=50} )
	submarine.alpha = 1.8
	submarine.myName = "submarine"

	

	platform = display.newImageRect( mainGroup,"spike.png", 1900, 70 )
	platform.x = display.contentCenterX
	platform.y = display.contentHeight-0
	physics.addBody( platform, "static" )
	platform.alpha=(0.02)
	platform.myName = "plat"

	platform1 = display.newImageRect( mainGroup,"spike1.png", 1900, 70 )
	platform1.x = display.contentCenterX
	platform1.y = display.contentHeight-780
	physics.addBody( platform1, "static" )
	platform1.alpha=(0.02)
	platform1.myName = "plat1"

	base1 = display.newImageRect( mainGroup,"base.png", 1900, 900 )
	base1.x = 300
	base1.y = 350
	base1.speed=2

	base2 = display.newImageRect( mainGroup,"base.png", 1900, 900 )
	base2.x = 480+300
	base2.y = 350
	base2.speed=2

	scoreText= display.newImageRect( uiGroup,"scorewindows.png", 350, 250 )
	scoreText.x = display.contentCenterX-505
	scoreText.y = display.contentHeight-680

	scoreNumber = display.newText(uiGroup,score, 115, 90, "J-LOG Cameron Edge Small Caps.otf", 50)
	scoreNumber.xScale = 1.2
	scoreNumber.yScale = 1.2

	background:addEventListener( "touch", onBackgroundTouch )
	 background.enterFrame = scrollBackground
    Runtime:addEventListener("enterFrame", background)

    background1.enterFrame = scrollBackground
    Runtime:addEventListener("enterFrame", background1)

     base1.enterFrame = scrollBase
    Runtime:addEventListener("enterFrame", base1)

    base2.enterFrame = scrollBase
    Runtime:addEventListener("enterFrame", base2)



	sceneGroup:insert( submarine )
	
	
	
	
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
		
        submarine.collision = onLocalCollision
		submarine:addEventListener( "collision")
		scene:addEventListener( "create", scene )

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
		Runtime:removeEventListener( "collision", onLocalCollision )
		Runtime:removeEventListener("enterFrame", background)

	   -- background4.enterFrame = scrollCity
	    Runtime:removeEventListener("enterFrame", background1)
		
		Runtime:removeEventListener("enterFrame", base1)

	   -- background4.enterFrame = scrollCity
	    Runtime:removeEventListener("enterFrame", base2)
		

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
