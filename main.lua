push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

local background = love.graphics.newImage('background.jpg')
local backgroundScroll = 0
local backgroundScrollSpeed = 60
local BACKGROUND_LOOPING_POINT = 512

local speedUp = false
local speedDown = false
local handBreak = false

function love.load()
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
	elseif key == 'space' then
		handBreak = true
	elseif key == 'a' then
		speedDown = true
	elseif key == 'd' then
		speedUp = true
	end
end

function love.keyreleased(key, scancode)
	if key == 'space' then
		handBreak = false
	elseif key == 'a' then
		speedDown = false
	elseif key == 'd' then
		speedUp = false
	end
end

function love.update(dt)
	if handBreak then
		backgroundScrollSpeed = math.max(0, backgroundScrollSpeed - 50)		
	elseif speedDown then 
		backgroundScrollSpeed = math.max(0, backgroundScrollSpeed - 15)
	elseif speedUp then 
		backgroundScrollSpeed = math.min(5000, backgroundScrollSpeed + 15)
	end

	backgroundScroll = (backgroundScroll + backgroundScrollSpeed * dt) 
	% BACKGROUND_LOOPING_POINT	
end

function love.draw()
	push:start()

	love.graphics.draw(background, -backgroundScroll, 0, 0, 0.5, 0.5)

	push:finish()
end