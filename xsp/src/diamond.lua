--金钻脚本

local f = {}

f.init = function ()
	return f
end


function maplocationtest()
	click(2070,1005)
	mSleep(500)
	touchDown(1, 100, 100)
	mSleep(100)
	touchMove(1, 700, 350)
	mSleep(100)
	touchUp(1, 700, 350)
	mSleep(500)
	click(1450,160)
end

f['go'] = function()
	package.path = '../?.lua;../?/?.lua'..package.path
	local websocket = require'websocket'
	print(websocket.client)
	local client = websocket.client.sync({timeout=2})
	local ok,err = client:connect('ws://quant.tomorrowstar.net/socket.io/?EIO=3&transport=websocket','echo')
	if not ok then
		print('could not connect',err)
	end
	
end

f[0] = function (...)
	printScreen('飞往塞维利亚')
	openBag()
	openFlyTicket()
	fly2City('塞维利亚')
	
	printScreen('航行到圣乔治')
	openMap()
	sail2City('圣乔治')
end

f[1] = function()
	printScreen('航行中...')
	while(true) do
		if isOnSail() then
			sysLog('on sail')
			speedup()
			mSleep(3000)
		else
			break
		end
	end
	onsailCount = 0
end

f[2] = function (...)
	printScreen('买入金钻')
	openTradeHouse('圣乔治')
	clickBuy()
	clickSpecialBuy()
	useBook(3,4)
	quitDialog()
	addAllGoods()
	confirmBuy()
	clickCancel()
	quit()
	quit()
end

f[3] = function (...)
	printScreen('航行到格罗宁根')
	openMap()
	sail2City('格罗宁根')
end

f[4] = function()
	printScreen('航行中...')
	sysLog(tostring(onsailCount))
	while(true) do
		if isOnSail() then
			sysLog('on sail')
			speedup()
			mSleep(3000)
		else
			break
		end
	end
	onsailCount = 0
end

f[5] = function (...)
	printScreen('到达格罗宁根')
	openTradeHouse('格罗宁根')
	sellAll()
end

return f



