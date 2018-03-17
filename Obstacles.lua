function createObstacles(image, freq)
	
	o = {
		
		obstacles = {},
		img = love.graphics.newImage(image),
		frequency = freq or 10
		
	}
	
	function o:add()
		o.obstacles[#o.obstacles+1] = {
			x = 1280,
			y = 720/2
		}
		if #o.obstacles > 1 then
			d = o.obstacles[#o.obstacles].x - o.obstacles[#o.obstacles-1].x
			if d > 128 and d < 256 then
				o.obstacles[#o.obstacles].x = o.obstacles[#o.obstacles-1].x + 128
			elseif d < 256 + 128 and d > 256 then
				o.obstacles[#o.obstacles].x = o.obstacles[#o.obstacles-1].x + 256+128
			end
		end
	end
	
	function o:collision(player)
	
		for i=1, #o.obstacles do
		
			if player.x + player.width - 20 > o.obstacles[i].x
			and player.x + 24 < o.img:getWidth() + o.obstacles[i].x 
			and player.y + player.height > o.obstacles[i].y 
			and player.y < o.img:getHeight() + o.obstacles[i].y
			then
				return true	
			end
			
		end
		return false
	end
	
	function o:draw()
		for i=1, #o.obstacles do
			love.graphics.draw(o.img, o.obstacles[i].x, o.obstacles[i].y + 200)
		end
	end
	
	o:add()
	
	function o:update(player)
		
		-- Check if last image is one obstacle width away from end
		if o.obstacles[#o.obstacles].x < (1280-64) then
		
			-- Get random number from one to frequency, add obstacle if it's one
			if math.random(1, o.frequency) == 1 then
				o:add()
			end
		
		end
		
		for i=1, #o.obstacles do
			o.obstacles[i].x = o.obstacles[i].x - player.xSpeed*love.timer.getDelta()
		end
		
		if o:collision(player) and player.vulnerable then
			player:damage()
		end
		
	end
	
	return o
	
end