--流行模板，

local ocr = require("ocr.BaiduOCR")

local f = {}
f.init = function ()
	return f
end


--f[0] = function()
--	if (isLoaded()) then
--		printScreen('前往马林迪')
--		openMap()
--		sail2City('马林迪')
--		onSail()
--		f[5]()
--	end
--end

--f[1] = function()
--	printScreen('航行到马萨瓦')
--	openMap()
--	sail2City('马萨瓦')
--	onSail()
--end

--f[2] = function (...)	
--	printScreen('抵达马萨瓦')
--	openTradeHouse('马萨瓦')
--	clickBuy()
--	clickSpecialBuy()
--	useBook(3,9)
--	quitDialog()
--	addGoods(3)
--	addGoods(2)
--	confirmBuy()
--	clickCancel()
--	quit()
--	quit()
--end

--f[3] = function()
--	printScreen('前往马林迪')
--	openMap()
--	sail2City('马林迪')
--	onSail()
--end

--f[5] = function (...)
--	printScreen('抵达马林迪')
--	openTradeHouse('马林迪')
--	sellAll()
--end

--return f

-- 果阿到法索拉

--f[0] = function()
--	if (isLoaded()) then
--		printScreen('前往尼斯')
--		openMap()
--		sail2City('尼斯')
--		onSail()
--		f[5]()
--	end
--end


--f[1] = function()
----	printScreen('飞往阿姆斯特丹')
----	openBag()
----	openFlyTicket()
----	fly2City('阿姆斯特丹')
--end

--f[2] = function()
--	printScreen('航行到卡利卡特')
--	openMap()
--	sail2City('卡利卡特')
--	onSail()
--end

--f[3] = function (...)	
--	printScreen('抵达卡利卡特')
--	openTradeHouse('卡利卡特')
--	clickBuy()
--	clickSpecialBuy()
--	useBook(3,7)
--	quitDialog()

----	sellGoods(1)
----	sellGoods(1)
----	sellGoods(2)
----	sellGoods(2)
	
--	addGoods(5)
--	addGoods(6)
--	confirmBuy()
--	quit()
--	quit()
--end

--f[4] = function()
--	printScreen('前往马达加斯加')
--	openMap()
--	sail2City('马达加斯加')
--	onSail()
--end

--f[5] = function (...)
--	printScreen('抵达马达加斯加')
--	openTradeHouse('马达加斯加')
--	sellAll()
--end

--return f


--马洛卡到哥本哈根
f[0] = function()
	if (isLoaded()) then
		printScreen('前往亚速尔')
		openMap()
		sail2City('马达加斯加')
		onSail()
		f[5]()
	end
end


f[1] = function()
--	printScreen('飞往热那亚')
--	openBag()
--	openFlyTicket()
--	fly2City('热那亚')
end

f[2] = function()
	printScreen('航行到亚丁')
	openMap()
	sail2City('亚丁')
	onSail()
end

f[3] = function (...)	
	printScreen('抵达亚丁')
	openTradeHouse('亚丁')
	clickBuy()
	clickSpecialBuy()
	useBook(3,11)
	quitDialog()

	sellGoods(4)
	sellGoods(4)
	sellGoods(5)
	sellGoods(5)
	
	addGoods(6)
	confirmBuy()
	quit()
	quit()
end

f[4] = function()
	printScreen('前往马达加斯加')
	openMap()
	sail2City('马达加斯加')
	onSail()
end

f[5] = function (...)
	printScreen('抵达马达加斯加')
	openTradeHouse('马达加斯加')
	sellAll()
end

return f



