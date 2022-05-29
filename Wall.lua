Wall = Class{}

local WALL_SCALE = 1

function Wall:init()
	self.image = love.graphics.newImage('wall1.png')
	self.width = self.image:getWidth() * WALL_SCALE
	self.height = self.image:getHeight() * WALL_SCALE

	self.x = VIRTUAL_WIDTH + self.width + math.random(0, 100)
	self.y = math.random(0, VIRTUAL_HEIGHT - self.height)
end	

function Wall:update(dt, speed)
	self.x = self.x - speed * dt
end

function Wall:render()
	love.graphics.draw(self.image, self.x, self.y, 0, WALL_SCALE, WALL_SCALE)
end