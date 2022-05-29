Wall = Class{}

function Wall:init()
	self.image = love.graphics.newImage('wall1.png')
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	self.x = VIRTUAL_WIDTH - 100
	self.y = math.random(0, VIRTUAL_HEIGHT - self.width)
end	

function Wall:update(dt, speed)
	self.x = self.x - speed * dt
end

function Wall:render()
	love.graphics.draw(self.image, self.x, self.y)
end