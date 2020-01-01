local f = {}

f.init = function (a)
	return f
end


isInteresting = function()
	local x, y = findColor({1673, 657, 2101, 741}, 
	{
		{x=0,y=0,color=0x645a4c},
		{x=33,y=-12,color=0xa7946b},
		{x=36,y=23,color=0x8c7552},
		{x=-7,y=25,color=0x907b51}
	},
	95, 0, 0, 0)
	if x > -1 then
		return false
	end
	return true
end


sayHello = function(city)
	openBar(city)
--  找吧女	
	click(1927,1154)
	mSleep(100)
	
--	喝一杯
	click(1894,698)
	mSleep(1000)
	
	if(isInteresting()) then
		click(1921,1051)
		mSleep(1000)
	end
	
-- 聊三下
	click(1915,822)
	mSleep(1000)
	
	if(isInteresting()) then
		click(1921,1051)
		mSleep(100)
		click(1921,1051)
		mSleep(100)
		click(1921,1051)
		mSleep(1000)
	end
	
	quit()
	mSleep(1000)
end

onSail = function()
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

f[1] = function (...)
	printScreen('飞往阿姆斯特丹')
	openBag()
	openFlyTicket()
	fly2City('阿姆斯特丹')
	sayHello('阿姆斯特丹')
	
	printScreen('航行到伦敦')	
	openMap()
	sail2City('伦敦')
	onSail()
	sayHello('伦敦')
	
	printScreen('航行到斯德哥尔摩')	
	openMap()
	sail2City('斯德哥尔摩')
	onSail()
	sayHello('斯德哥尔摩')
	
	printScreen('飞往热那亚')
	openBag()
	openFlyTicket()
	fly2City('热那亚')
	sayHello('热那亚')

	printScreen('航行到马赛')	
	openMap()
	sail2City('马赛')
	onSail()
	sayHello('马赛')

	printScreen('航行到突尼斯')	
	openMap()
	sail2City('突尼斯')
	onSail()
	sayHello('突尼斯')

	printScreen('航行到那不勒斯')	
	openMap()
	sail2City('那不勒斯')
	onSail()
	sayHello('那不勒斯')

	printScreen('航行到威尼斯')	
	openMap()
	sail2City('威尼斯')
	onSail()
	sayHello('威尼斯')

	printScreen('航行到亚历山大')	
	openMap()
	sail2City('亚历山大')
	onSail()
	sayHello('亚历山大')
	
	printScreen('航行到雅典')	
	openMap()
	sail2City('雅典')
	onSail()
	sayHello('雅典')
	
	printScreen('航行到伊斯坦布尔')	
	openMap()
	sail2City('伊斯坦布尔')
	onSail()
	sayHello('伊斯坦布尔')

	printScreen('飞往开普敦')
	openBag()
	openFlyTicket()
	fly2City('开普敦')
	sayHello('开普敦')

	printScreen('航行到蒙巴萨')	
	openMap()
	sail2City('蒙巴萨')
	onSail()
	sayHello('蒙巴萨')
	
	printScreen('航行到亚丁')	
	openMap()
	sail2City('亚丁')
	onSail()
	sayHello('亚丁')
	
	printScreen('航行到卡利卡特')	
	openMap()
	sail2City('卡利卡特')
	onSail()
	sayHello('卡利卡特')
	
	printScreen('飞往塞维利亚')
	openBag()
	openFlyTicket()
	fly2City('塞维利亚')
	sayHello('塞维利亚')
	
	printScreen('航行到里斯本')	
	openMap()
	sail2City('里斯本')
	onSail()
	sayHello('里斯本')		
	
	printScreen('航行到圣多明各')
	openMap()	
	sail2City('圣多明各')
	onSail()
	sayHello('圣多明各')	
		
	printScreen('航行到维拉克鲁斯')	
	openMap()
	sail2City('维拉克鲁斯')
	onSail()
	sayHello('维拉克鲁斯')	
		
	printScreen('航行到里约热内卢')	
	openMap()
	sail2City('里约热内卢')
	onSail()
	sayHello('里约热内卢')	

	printScreen('航行到圣乔治')	
	openMap()
	sail2City('圣乔治')
	onSail()
	sayHello('圣乔治')		
end

return f


