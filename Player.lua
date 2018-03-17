-- function: createPlayer - Adds a new playable character to the game
-- folder: (String) - The folder containing character animations
-- ax: (optional) - The player's x position
-- ay: (optional) - The player's y position
-- scale: (optional) - How to scale the character's animations
function createPlayer(folder, ax, ay, scale)

  player = {

    animations = {},
    x = ax or love.graphics.getWidth()/3,
    y = ay or love.graphics.getHeight()*0.5,
    xSpeed = 0,
    ySpeed = 0,
    width = 128,
    height = 128,
    currentAnim = "",
    maxSpeed = 500,
	health = 5,
	vulnerable = true,
	damageTime = 3,
	alpha = 255,
	alphaTime = 0.025,
	score = 0

  }

  -- Adds animation stored in given folder
  function player:addAnimation(name, f)
    player.animations[name] = createAnimation(f)
  end

  directories = getFoldersInFolder(folder)
  for i=1, #directories do
    player:addAnimation(directories[i], folder.."/"..directories[i])
  end

  function player:isGrounded()
    return self.y >= love.graphics.getHeight()*0.5
  end

  function player:jump()
    if player:isGrounded() then
      player.y = player.y - 1
      player.ySpeed = -1250 * 50
    end
  end

  function player:endJump()
    if player.ySpeed < -500 then
      player.ySpeed = -500
    end
  end

  function player:setAnimation(anim)
    if player.animations[anim] ~= nil then
      player.currentAnim = anim
      player.animations[anim].frame = 1
    end
  end
  
  function player:damage()
  
	player.health = player.health - 1
	player.xSpeed = player.xSpeed/4
	player.vulnerable = false
  
  end
  
  function player:damageBoost(dt)
  
	if player.vulnerable == false then
		player.damageTime = player.damageTime - dt
		if player.damageTime < 0 then
			player.vulnerable = true
			player.damageTime = 3 
		end
	end
	
  end
  
  function player:drawHealth(x, y)
	
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.rectangle("fill", x, y, player.health*25, player.health*16)
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("line", x, y, 5*25, 16, 3, 3)
	love.graphics.setColor(255, 255, 255, 255)
	
  end

  function player:animate(scale, x, y)
  
	if player.vulnerable == false then
		player.alphaTime = player.alphaTime - love.timer.getDelta()
		if player.alphaTime < 0 then
			player.alphaTime = 0.025
			if player.alpha == 255 then
				player.alpha = 150
			else
				player.alpha = 255
			end
		end
	else
		player.alpha = 255
	end
	
	love.graphics.setColor(255, 255, 255, player.alpha)
    player.animations[player.currentAnim]:play(x or player.x, y or player.y, 0, scale or 2)
	love.graphics.setColor(255, 255, 255, 255)
	
  end

  function player:update(dt)

    if self:isGrounded() then --and self.ySpeed > 0 then
      self.y = love.graphics.getHeight()*0.5
      self.ySpeed = 0
      if player.currentAnim ~= "run" then
        player:setAnimation("run")
      end
    else
      if player.ySpeed < -8 and player.currentAnim ~= "jump_up" then
        player:setAnimation("jump_up")
      elseif player.ySpeed < 8 and player.ySpeed > -8 and player.currentAnim ~= "jump_midair" then
        player:setAnimation("jump_midair")
      elseif player.ySpeed > 8 and player.currentAnim ~= "jump_down" then
        player:setAnimation("jump_down")
      end
      self.ySpeed = self.ySpeed + 2500*dt
    end

    if player.xSpeed < player.maxSpeed then
        player.xSpeed = player.xSpeed + 250*dt
    else
        player.xSpeed = player.maxSpeed
    end

	player:damageBoost(dt)
    self.y = self.y + self.ySpeed*dt
	player.score = player.score + player.xSpeed

  end

  return player

end
