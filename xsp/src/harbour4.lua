-- 从塞维利亚到圣保罗

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
	if startwith(text,'赛')==false then
		printScreen('飞往塞维利亚')
		openBag()
		openFlyTicket()
		fly2City('塞维利亚')
	end
end

f[2] = function (...)	
	printScreen('抵达塞维利亚')
	openTradeHouse('塞维利亚')
	clickBuy()
	clickSpecialBuy()
	useBook(2,2)
	quitDialog()
--	addAllGoods()

	addGoods(3)
	addGoods(2)
	addGoods(1)
	addGoods(4)
	addGoods(6)

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
