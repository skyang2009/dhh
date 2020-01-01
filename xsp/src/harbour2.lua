--从格罗宁根到威廉斯塔德运送蜂蜜的路线
--买入全部蜂蜜，并将其他物品卖光


local ocr = require("ocr.BaiduOCR")

local f = {}
f.init = function ()
	return f
end


--检查有没有货物，必须是在cabin里面
--function isLoaded()
--	openCabin()
--	text = ocr.getText(1550,1030,1638,1081) 
--	quit()
--	if(tonumber(text)==nil) then
--		text = 0
--	end	
--	if(tonumber(text)>500) then
--		printScreen('船舱货物数为'..tostring(text))
--		return true
--	else 
--		return false
--	end
--end

--function isTaohuaWood()
--	openCabin()
--	click(1272,333)
--	text = ocr.getText(630,283,1036,361)
--	quit()
--	if startwith(text,'桃花') then
--		printScreen('载有桃花木')
--		return true
--	else 
--		return false
--	end
--end

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
	if startwith(text,'格')==false then
		printScreen('飞往阿姆斯特丹')
		openBag()
		openFlyTicket()
		fly2City('阿姆斯特丹')
		openMap()
		printScreen('前往格罗宁根')
		sail2City('格罗宁根')
		onSail()
	end
end

f[2] = function (...)	
	printScreen('抵达格罗宁根')
	openTradeHouse('格罗宁根')
	clickBuy()
	clickSpecialBuy()
	useBook(1,5)
	quitDialog()

	sellGoods(1)
	sellGoods(1)
	sellGoods(2)
	sellGoods(2)
	
	addGoods(3)
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





