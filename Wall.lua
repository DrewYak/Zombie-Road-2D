Wall = Class{}

function Wall:init( ... )
	self.image = love.graphics.newImage('wall01.png')
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()

	self.x = VIRTUAL_WIDTH
	self.y = math.random(0, VIRTUAL_HEIGHT - self.width)
end	

function Wall:render()
	love.graphics.draw(self.image, self.x, self.y)
end