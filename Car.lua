Car = Class{}

local CAR_SCALE = 0.3

function Car:init()
	self.image = love.graphics.newImage('car.png')
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	self.x = VIRTUAL_WIDTH / 2 - (self.width * CAR_SCALE / 2)
	self.y = VIRTUAL_HEIGHT / 2 - (self.height * CAR_SCALE/ 2)
end

function Car:render()
	love.graphics.draw(self.image, self.x, self.y, carRound, CAR_SCALE, CAR_SCALE)
end