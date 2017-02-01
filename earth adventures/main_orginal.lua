
-- local background = display.newImageRect( "background.png", 1024, 768 )
-- background.x = display.contentCenterX
-- background.y = display.contentCenterY


-- math.randomseed( os.time() )
-- local arrowTable = {}
-- local gameLoopTimer

-- local platform = display.newImageRect( "spike.png", 1900, 70 )
-- platform.x = display.contentCenterX
-- platform.y = display.contentHeight-0
-- platform.myName = "plat"

-- local platform1 = display.newImageRect( "spike1.png", 1900, 70 )
-- platform1.x = display.contentCenterX
-- platform1.y = display.contentHeight-780
-- platform1.myName = "plat1"

-- local balloon = display.newImageRect( "balloon.png", 112, 112 )
-- balloon.x = display.contentCenterX-350
-- balloon.y = display.contentCenterY
-- balloon.alpha = 0.8
-- balloon.myName = "balloon"




-- local arrow
-- local function createArrow()

--     arrow = display.newImageRect( "arrow.png",  350, 100 )
--     table.insert( arrowTable, arrow )
--     physics.addBody( arrow, "dynamic", { radius=40, density=0.3, bounce=0.0} )
--     arrow.gravityScale = 0.0
--      arrow.myName = "asteroid"
--      local whereFrom =  1
--      if ( whereFrom == 1 ) then
--          arrow.x = display.contentWidth + 60
--         arrow.y = math.random( 90,700 )
--             arrow:applyLinearImpulse( -25, 0, arrow.x, arrow.y )    

--     end 

-- end

-- local function gameLoop()

--     -- Create new asteroid
--     createArrow()

--     -- Remove asteroids which have drifted off screen
--     for i = #arrowTable, 1, -1 do
--         local thisAsteroid = arrowTable[i]

--         if ( thisAsteroid.x < -100 or
--              thisAsteroid.x > display.contentWidth + 100 or
--              thisAsteroid.y < -100 or
--              thisAsteroid.y > display.contentHeight + 100 )
--         then
--             display.remove( thisAsteroid )
--             table.remove( arrowTable, i )
--         end
--     end
-- end

-- gameLoopTimer = timer.performWithDelay( 1000, gameLoop, 0 )

-- local physics = require( "physics" )
-- physics.start()
-- physics.addBody( balloon, "dynamic", { radius=50} )

-- physics.addBody( platform, "static" )
 -- physics.addBody( platform1, "static" )


-- local function onBackgroundTouch( event )

-- 	if event.phase == "began" then 

-- 		 balloon:applyLinearImpulse( 0, -0.5, balloon.x, balloon.y )
-- 	end
-- end

-- background:addEventListener( "touch", onBackgroundTouch )

-- local function onLocalCollision( self, event )

--     if ( event.phase == "began" ) then
        
--         display.remove( balloon )
        
--          for i = #arrowTable, 1, -1 do
--                 if ( arrowTable[i] == obj1 or arrowTable[i] == obj2 ) then
--                     table.remove( arrowTable, i )
--                     break
--                 end
--             end
--     end
-- end


-- balloon.collision = onLocalCollision
-- balloon:addEventListener( "collision")


-- score = 0
-- local scoreNumber = display.newText(score, 310, 80, nil, 50)
-- scoreNumber.xScale = 1.2
-- scoreNumber.yScale = 1.2

-- local function updateScore()
-- score = score + 1
-- scoreNumber.text = score
-- end

-- timer.performWithDelay(1000, updateScore, -0.1)

-- local scoreText = display.newText("score:", 200, 80, nil, 50)
-- scoreText.xScale = 1.2
-- scoreText.yScale = 1.2