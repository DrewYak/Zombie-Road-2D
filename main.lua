push = require 'push'
Class = require 'class'
require 'Car'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

local background = love.graphics.newImage('background.jpg')
local backgroundScroll = 0
local backgroundScrollSpeed = 60
local BACKGROUND_SCALE = 0.5
local BACKGROUND_LOOPING_POINT = 1024 * BACKGROUND_SCALE

local speedUp_d = false
local speedUp_rshift = false
local speedDown = false
local handBreak = false
local moveToRight = false
local moveToLeft = false

local car = Car()
carAmplitude = 0
speedRL = 10

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
	if key == 'escape' then love.event.quit() end

	if key == 'rshift' then speedUp_rshift = true end
	if key == 'd' then speedUp_d = true end
	if key == 'space' then handBreak = true end
	if key == 'w' then moveToLeft = true end
	if key == 's' then moveToRight = true end
	if key == 'a' then	speedDown = true end
end

function love.keyreleased(key, scancode)
	if key == 'rshift' then speedUp_rshift = false end
	if key == 'd' then speedUp_d = false end
	if key == 'space' then handBreak = false end
	if key == 'w' then moveToLeft = false end
	if key == 's' then moveToRight = false end
	if key == 'a' then	speedDown = false end
end

function love.update(dt)
	updateSpeed()
	updateBackgroud(dt)
	updateShake(dt)
	updateTurns(dt)
end

function updateSpeed()
	if handBreak then
		backgroundScrollSpeed = math.max(0, backgroundScrollSpeed - 50)	
	end
	if speedDown then 
		backgroundScrollSpeed = math.max(0, backgroundScrollSpeed - 25)
	end
	if speedUp_d or speedUp_rshift then 
		backgroundScrollSpeed = math.min(5000, backgroundScrollSpeed + 15)
	end
end

function updateBackgroud(dt)
	backgroundScroll = (backgroundScroll + backgroundScrollSpeed * dt) 
	% BACKGROUND_LOOPING_POINT	
end

function updateShake(dt)
	car.shake = backgroundScrollSpeed * dt
end

function updateTurns(dt)
	if moveToLeft then
		car.y = math.max(0, car.y - speedRL * math.sqrt(backgroundScrollSpeed) * dt)
	end
	if moveToRight then
		car.y = math.min(car.y + speedRL * math.sqrt(backgroundScrollSpeed) * dt, VIRTUAL_HEIGHT - car.height)
	end
end

function love.draw()
	push:start()

	renderBackground()
	car:render()
	renderSpeedometer()

	push:finish()
end

function renderBackground()
	love.graphics.draw(background, -backgroundScroll, 0, 0, BACKGROUND_SCALE, BACKGROUND_SCALE)
end

function renderSpeedometer()
	font = love.graphics.newFont("Xolonium-Regular.ttf", 50)
	love.graphics.setFont(font)
	speedMsg = "Cкорость: " .. tostring(math.floor(backgroundScrollSpeed / 40)) .. " км/ч"
	love.graphics.print(speedMsg, 0, 0, 0, 1, 1)
end