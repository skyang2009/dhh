--从里斯本到威廉斯塔德运送食品的路线
--买入食品，并将其他物品卖光


local ocr = require("ocr.BaiduOCR")

local f = {}
f.init = function ()
	return f
end


f[0] = function()
	if(isTaohuaWood()) then
		local city = getGoodsSellCity(territory_goods[city_to])
		openMap()
		sail2City(city)
		onSail()
		printScreen('抵达'..city)
		openTradeHouse(city)
		sellAll()
	elseif (isLoaded()) then
		f[3]()
		f[5]()
		f[6]()
	end
end


f[1] = function()
	text = ocr.getText(1818,14,2107,72) -- 地点名称
	if startwith(text,'里斯本')==false then
		printScreen('飞往塞维利亚')
		openBag()
		openFlyTicket()
		fly2City('塞维利亚')
		openMap()
		printScreen('前往里斯本')
		sail2City('里斯本')
		onSail()
	end
end

f[2] = function (...)	
	printScreen('抵达里斯本')
	openTradeHouse('里斯本')
	clickBuy()
	clickSpecialBuy()
	useBook(1,4)
	quitDialog()
	
	addGoods(1)	
	addGoods(2)
	confirmBuy()
	quit()
	quit()
end

f[3] = function()
	printScreen('前往'..city_to)
	openMap()
	sail2City(city_to)
	onSail()
end


f[5] = function (...)
	printScreen('抵达'..city_to)
	openTradeHouse(city_to)
	sellAll()
	mSleep(1000)	
end

-- 购买特产
f[6] = function()
	if(special_goods=='1') then
		openTerrioryHouse(city_to)
		buyLocalProduct()
		local city = getGoodsSellCity(territory_goods[city_to])
		openMap()
		sail2City(city)
		onSail()
		openTradeHouse(city)
		sellAll()
	end
end


return f





