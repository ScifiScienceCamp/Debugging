require("Basics")
require("Animation")
require("Player")
require("Tiles")
require("Obstacles")

-- This one is called right at the start
function love.load()
	sky = love.graphics.newImage("images/sky.jpg")
	player = createPlayer("images/traveler")
	t = createTiles()
	obs = createObstacles("images/facebook.png", 100)
end

-- This function is being called repeatedly and draws things to the screen
function love.draw()

	if player.health > 0 then
		love.graphics.draw(sky)
		player:animate()
		t:draw()
		obs:draw()
		player:drawHealth(10, 10)
		words = "Distance Traveled: "..tostring(math.floor(player.score/10000)).."\n"
		words = words.."Player Health: "..tostring(player.health)
		love.graphics.print(words, 10, 30)
	else
		words = "Distance Traveled: "..tostring(math.floor(player.score/10000)).."\n"
		words = words.."Press Space to try again!"
		love.graphics.print(words, 550, 350)
	end

end

-- This one is also being called repeatedly, handles game logic
function love.update(dt)
	if player.health > 0 then
		player:update(dt)
		t:update(player.xSpeed)
		o:update(player)
	end
end

function love.keypressed(key)

	if key == "space" then
		player:jump()
		if player.health < 1 then
			player.health = 5
			player.xSpeed = 0
			player.score = 0
		end
	end

	if key == "escape" then
		love.event.quit()
	end

end

function love.keyreleased(key)

	if key == "space" then
		player:endJump()
	end

end
