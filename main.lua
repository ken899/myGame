physics = require("physics")
physics.start();physics.pause();
physics.setGravity(0,3)

_W = display.contentWidth
_H = display.contentHeight

local back = display.newImage("sky.png")
back.x = _W/2; back.y =_H/2

rect1 = display.newRect(-10,-_H*3,10,_H*10)
rect2 = display.newRect(_W-50,-_H*3,10,_H*10)
rect3 = display.newRect(0,_H,_W,5)


physics.addBody(rect1, "static")
physics.addBody(rect2, "static")
physics.addBody(rect3, "static",{isSensor = true})

group = display.newGroup()

box_num = 99

local box = {}
for i=1,box_num do
  box[i] = display.newImage("crate.png")
  box[i].x = 10+math.random(_W-90);
  box[i].y = -math.random(5000);
  box[i].rotation = math.random(90)
  physics.addBody( box[i], { bounce=0.8 } )
  group:insert(box[i])
end

score = group.numChildren*2+2

local text1 = display.newText(score, 260, 20, native.systemFont, 50) 
local text2 = display.newText("SCORE", 20, 20, native.systemFont, 50) 
local startBtn = display.newText("START",_W/2-100,_H/2,native.systemFont,50)

local function start(event)
	startBtn:removeSelf()
	physics.start()
end

startBtn:addEventListener("touch",start)

local function onTimeEvent( event )
	text1.text = score
end

timer.performWithDelay(1, onTimeEvent, 0 )

function boxUp(event)
	event.target:applyForce(math.random(3)-3,-50,event.x,event.y)
	return true
end

for i=1, group.numChildren do
	group[i]:addEventListener("touch",boxUp)
end

rect3:addEventListener("collision",
	function (event)
		score=score-1
	end)

stp=display.newRect(_W-31,-10950,50,5000)
physics.addBody(stp)
stp:setFillColor(255,0,0)

soundID = audio.loadSound("beep_mp3.mp3")

local playBeep = function()
	print("beep")
	audio.play(soundID)
end

 
stp:addEventListener("collision",
	function (event)
		physics.addBody(rect3, "static")
		stp:removeSelf()
		last=score
		text2.text = "FINISH"
		text1:removeSelf() 
		local text3 = display.newText(last, 260, 20, native.systemFont, 50) 
		playBeep()
		fin=display.newRect(_W-30,-950,50,5000)
		fin:setFillColor(255,0,0)
	end)

