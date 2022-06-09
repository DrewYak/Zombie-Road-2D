push = require 'push'
Class = require 'class'
require 'Car'
require 'Wall'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

local background = love.graphics.newImage('background.jpg')
local backgroundScroll = 0
local backgroundScrollSpeed = 60
local BACKGROUND_SCALE = 1
local BACKGROUND_LOOPING_POINT = 1024 * BACKGROUND_SCALE

local speedUp_d = false
local speedUp_rshift = false
local speedDown = false
local handBreak = false
local moveToRight = false
local moveToLeft = false

local car = Car()
local walls = {}

local distance = 0
local countWalls = 0


function love.load()
	love.window.setTitle('Zombie Road 2D')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})

	-- font for render speedometer and distance
	font = love.graphics.newFont("Xolonium-Regular.ttf", 50)
	love.graphics.setFont(font)	
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.keypressed(key)
	if key == 'escape' then love.event.quit() end

	if key == 'rctrl' then speedUp_rshift = true end
	if key == 'd' then speedUp_d = true end
	if key == 'space' then handBreak = true end
	if key == 'w' then moveToLeft = true end
	if key == 's' then moveToRight = true end
	if key == 'a' then	speedDown = true end
end

function love.keyreleased(key, scancode)
	if key == 'rctrl' then speedUp_rshift = false end
	if key == 'd' then speedUp_d = false end
	if key == 'space' then handBreak = false end
	if key == 'w' then moveToLeft = false end
	if key == 's' then moveToRight = false end
	if key == 'a' then	speedDown = false end
end

function love.update(dt)
	-- update backgroundScrollSpeed
	if handBreak then
		backgroundScrollSpeed = math.max(0, backgroundScrollSpeed - 50)	
	end
	if speedDown then 
		backgroundScrollSpeed = math.max(0, backgroundScrollSpeed - 25)
	end
	if speedUp_d or speedUp_rshift then 
		backgroundScrollSpeed = math.min(5000, backgroundScrollSpeed + 15)
	end

	-- update backgroud
	backgroundScroll = (backgroundScroll + backgroundScrollSpeed * dt) 
	% BACKGROUND_LOOPING_POINT

	-- update car shake
	car.shake = backgroundScrollSpeed * dt

	-- update car turns
	if moveToLeft then
		car.y = math.max(0, car.y - car.speedRL * math.sqrt(backgroundScrollSpeed) * dt)
	end
	if moveToRight then
		car.y = math.min(car.y + car.speedRL * math.sqrt(backgroundScrollSpeed) * dt, VIRTUAL_HEIGHT - car.height)
	end

	-- update walls
	-- пусть стены появляются каждые 0.02 км 
	if distance / (40 * 3600) - countWalls * 0.02 > 0 then
		table.insert(walls, Wall())
		countWalls = countWalls + 1
	end

	for k, wall in ipairs(walls) do
		wall:update(dt, backgroundScrollSpeed)
		if wall.x < -wall.width then
			table.remove(walls, k)
		end
	end

	-- update distance
	distance = distance + backgroundScrollSpeed * dt
end


function love.draw()
	push:start()

	-- render background
	love.graphics.draw(background, -backgroundScroll, 0, 0, BACKGROUND_SCALE, BACKGROUND_SCALE)
	
	-- render car
	car:render()
	
	-- render walls
	for k, wall in ipairs(walls) do
		wall:render()
	end

	-- render speedometer
	speedMsg = string.format("%3.0f км/ч", backgroundScrollSpeed / 40)
	love.graphics.printf("Cкорость: ", 0, 0, VIRTUAL_WIDTH - 280, "right")
	love.graphics.printf(speedMsg, 0, 0, VIRTUAL_WIDTH - 10, "right")

	-- render distance
	distanceMsg = string.format("%.3f км", distance / (40 * 3600))
	love.graphics.printf("Путь: ", 0, 50, VIRTUAL_WIDTH - 280, "right")	
	love.graphics.printf(distanceMsg, 0, 50, VIRTUAL_WIDTH - 10, "right")

	push:finish()
end