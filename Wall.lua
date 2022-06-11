Wall = Class{}

local WALL_SCALE = 1.5
local WALL_IMAGE = love.graphics.newImage('wall.png')

function Wall:init()
	self.width = WALL_IMAGE:getWidth() * WALL_SCALE
	self.height = WALL_IMAGE:getHeight() * WALL_SCALE

	-- Поля width и height должны быть заданы до иницализации полей x и y.
	self.x = VIRTUAL_WIDTH + self.width + math.random(0, 100)
	self.y = math.random(0, VIRTUAL_HEIGHT - self.height)
end	

function Wall:update(dt, speed)
	self.x = self.x - speed * dt
end

function Wall:render()
	love.graphics.draw(WALL_IMAGE, self.x, self.y, 0, WALL_SCALE, WALL_SCALE)
end