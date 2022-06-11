Car = Class{}

local CAR_SCALE = 0.3

function Car:init()
	self.image = love.graphics.newImage('car.png')
	self.width = self.image:getWidth() * CAR_SCALE
	self.height = self.image:getHeight() * CAR_SCALE

	self.x = 100
	self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
	self.shake = 0
	self.speedRL = 10
end

function Car:collides(wall)
	if (self.x + self.width < wall.x + 5) or (wall.x + wall.width < self.x + 5) or 
	   (self.y + self.height < wall.y + 5) or (wall.y + wall.height < self.y + 5) then
	   	return false
	else
		return true
	end
end

function Car:render()
	s = self.shake
	x = self.x + math.random(-s / 80, s / 80)
	y = self.y + math.random(-s / 80, s / 80)
	love.graphics.draw(self.image, x, y, 0, CAR_SCALE, CAR_SCALE)
end