--阿姆斯特丹奢饰品去威廉斯塔德

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
	if startwith(text,'阿姆')==false then
		printScreen('飞往阿姆斯特丹')
		openBag()
		openFlyTicket()
		fly2City('阿姆斯特丹')
	end
end

f[2] = function()
	printScreen('抵达阿姆斯特丹')
--	groupBuy('阿姆斯特丹')

	openTradeHouse('阿姆斯特丹')
	clickBuy()
	clickSpecialBuy()
	useBook(3,1)
	useBook(2,1)
	useBook(1,1)
	quitDialog()
	
	addGoods(5)
	addGoods(6)
	addGoods(4)
	addGoods(3)
	addGoods(2)
	addGoods(1)
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




