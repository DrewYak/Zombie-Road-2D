Car = Class{}

local CAR_SCALE = 0.3

local carRound = 0

function Car:init()
	self.image = love.graphics.newImage('car.png')
	self.width = CAR_SCALE * self.image:getWidth()
	self.height = CAR_SCALE * self.image:getHeight()

	self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
	self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
	self.shake = 0
end

function Car:render()
	s = self.shake
	x = self.x + math.random(-s / 80, s / 80)
	y = self.y + math.random(-s / 80, s / 80)
	love.graphics.draw(self.image, x, y, carRound, CAR_SCALE, CAR_SCALE)
end