push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

local background = love.graphics.newImage('background.jpg')
local backgroundScroll = 0
local backgroundScrollSpeed = 60
local BACKGROUND_LOOPING_POINT = 512


function love.load()
	--love.graphics.setDefaultFilter('nearest', 'nearest')
	
	love.window.setTitle('Zombie Road 2D')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	elseif key == 'd' then
		backgroundScrollSpeed = backgroundScrollSpeed + 10
	elseif key == 'a' then
		backgroundScrollSpeed = backgroundScrollSpeed - 10
	end
end

function love.update(dt)
	backgroundScroll = (backgroundScroll + backgroundScrollSpeed * dt) 
	% BACKGROUND_LOOPING_POINT
end

function love.draw()
	push:start()

	love.graphics.draw(background, -backgroundScroll, 0, 0, 0.5, 0.5)

	push:finish()
end