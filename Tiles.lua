function createTiles(src)

  tiles = {
    source = src or "images/grassTiles/grassMid.png",
    t = {}
  }

  function tiles:getTile(x)
    return tiles.t[x]
  end

  function tiles:addTile()

    tiles.t[#tiles.t+1] = {
      x = 0,
      y = 720/2 + 128,
      img = love.graphics.newImage(tiles.source)
    }

    if tiles.t[#tiles.t-1] ~= nil then
      tiles.t[#tiles.t].x = tiles.t[#tiles.t-1].x + tiles.t[#tiles.t-1].img:getWidth() 
    end

  end

  function tiles:removeTile()
    table.remove(tiles.t, 1)
  end

  function tiles:draw()
    for i=1, #tiles.t do
      love.graphics.draw(tiles.t[i].img, tiles.t[i].x, tiles.t[i].y, 45)
    end
  end

  tiles:addTile()

  function tiles:update(dx)

    if self.t[#self.t].x < 1280 then
      tiles:addTile()
    end

    if tiles.t[i].x + 128 < 0 then
      tiles:removeTile()
    end

    for i=1, #tiles.t do
      tiles.t[i].x = tiles.t[i].x - dx*love.timer.getDelta()
    end

  end

  return tiles

end
