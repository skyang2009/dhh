require('base')
require('config')
require('captcha')
local ocr = require("ocr.BaiduOCR")

init("0", 1); --以当前应用 Home 键在右边初始化
device_width,device_height =getScreenSize()
sysLog("分辨率：宽 " .. device_width  .. "高 "..device_height)


--发现启航按钮
function getStart()
	x, y = findMultiColorInRegionFuzzy(0xfef7c8,"84|0|0x37b2d6,198|-5|0x39accf,198|52|0x0c83bc,84|48|0x18d5c2,0|45|0xe8d38e", 95, 0, 0, 2207, 1241, 0, 0)
	if x > -1 then
		click(x,y)
	end
end

function clickBuy()
	click(1900,980)
	mSleep(500)
end

--todo:触发议价的处理
function clickSell()
	click(1900,1090)
	mSleep(800)
end

function clickSpecialBuy()
	click(352,984)
	mSleep(500)
end

function useBook(level, number)
	for i = 1,number,1 do
		if(level==3) then
			click(1728,432)
		elseif level==2 then
			click(1728,667)
		else 
			click(1728,908)
		end
	end
end

function quitDialog()
	click(1937,120)
	mSleep(1000)
end


function sellAll()
	clickSell()
	click(356,980)
	mSleep(500)
	confirmSell()
--	这里有可能触发讨价
	bargain()
	quit()
	quit()
end

function bargain()
	text = ocr.getText(643,158,903,215)
	sysLog(tostring(text))
	if(tostring(text)=='交易所老板' or startwith(text,'露娜') or startwith(text,'卢克')
	 or startwith(text,'米开')) then
		clickSomewhere()
		clickSomewhere()
		clickSomewhere()
		clickSomewhere()
		clickSomewhere()
		clickSomewhere()
		clickSomewhere()
		quit()
	end	
end


function sellGoods(index)
	addGoods(index)
	confirmBuy()
	mSleep(100)
	click(113,365)
	mSleep(100)
	click(356,980)
	mSleep(100)
	confirmSell()
	mSleep(500)
	click(118,216)
	mSleep(100)
end


function addGoods(index)
	items = {{650,330},{950,330},{1250,330}
		,{650,730},{950,730},{1250,730}}
	click(items[index][1],items[index][2])
	mSleep(50)
end


function addAllGoods()
	for i = 1,6,1 do
		addGoods(i)
	end
end

function confirm()
	x, y = findColor({0, 0, 2207, 1241},
		"0|0|0xa9752e,149|-5|0xb57d31,183|18|0xecdecc,44|43|0xd69e3e",
		95, 0, 0, 0)
	if x > -1 then
		click(x,y)
	end
end

function quit()
	click(2160,60)
	mSleep(1500)
end

function openBag()
	click(2123,993)
	mSleep(1000)
end

function openFlyTicket()
	click(1390,310)
	mSleep(500)
	click(940,855)
	mSleep(500)
end

string.split = function(s, p)
	local rt= {}
	string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
	return rt
end


function fly2City(city)
	list = string.split(fly_cities[city],',')
	x = list[1]
	y = list[2]
	click(x,y)
	mSleep(500)
	alertConfirm()
	mSleep(5000)
	clickSomewhere(1)
	clickSomewhere(1)
	mSleep(6000)
end

function alertConfirm()
	click(1288,788)
end

function alertCancel()
	click(910,800)
end

function clickSomewhere(index)
	if(index==1) then
		click(1200,50)
	else
		click(459,897)
	end
	mSleep(500)
end

function clickCancel()
	click(100, 100)
	mSleep(500)
end

function openTradeHouse(city)
	list = string.split(trade_houses[city],',')
	x = list[1]
	y = list[2]
	click(x,y)
	mSleep(1000)
end

function openBar(city)
	list = string.split(bars[city],',')
	x = list[1]
	y = list[2]
	click(x,y)
	mSleep(1000)
end

function openTerrioryHouse(city)
	mSleep(1000)
	list = string.split(territory_houses[city],',')
	x = list[1]
	y = list[2]
	click(x,y)
	mSleep(3000)
end

function buyLocalProduct()
	click(1900,1092)
	mSleep(1000)
	click(1812,979)
	mSleep(1000)
	crackCaptcha()
	quit()
	quit()
end

function buyAffairHouse(city)
	affairHouse = {威廉斯塔德='1152,421'}
	list = string.split(affairHouse[city],',')
	x = list[1]
	y = list[2]
	click(x,y)
	mSleep(1000)
	click(1900,1092)
	mSleep(500)
	click(1812,979)
	quit()
	quit()
end

function confirmBuy()
	click(1870,1114)
	mSleep(500)
	crackCaptcha()
	clickCancel()
end

function confirmSell()
	click(1870,1114)
	mSleep(500)
	crackCaptcha()
	clickCancel()
end


function sail2City(city)
	toast('前往'..city)
	list = string.split(cities_all[city],',')
	x1=list[1]
	y1=list[2]
	x2=list[3]
	y2=list[4]
	
	click(x1,y1)		
	mSleep(3000)
	click(x2,y2)
	mSleep(500)
	click(1747,1078)	--前往
	mSleep(2000)
	
	--	todo: 半路出发的话不要触发底下的内容	
	x, y = findColor({1301, 968, 1637, 1104}, 
	"0|0|0x161c2e,14|7|0x767f89,26|10|0xaeb3b9,17|24|0xdddddd",
	95, 0, 0, 0)
	if x > -1 then
		haveDrink()
		getSupply()
		sailConfirm()	
		mSleep(10000)
	end

end

function sailConfirm()
	--出航
	click(2035,1030)
	mSleep(1000)
end


function haveDrink()
	text = ocr.getText(1676,195,1785,239)
	sysLog(tostring(text))
	if(tonumber(text)==nil) then
		text = 0
	end
	if(tonumber(text)<10) then
		return
	end

	click(2020,233)
	mSleep(1500)
	click(1900,839)
	mSleep(1000)
	
--	todo：两种场景是否都能点到
	click(1910,1020)
	mSleep(200)
--	click(1910,1020)
--	mSleep(200)
	quit()
	
	text = ocr.getText(156,82,290,140)
	if(startwith(text, '酒吧')) then
		quit()
	end
end

function getSupply()
	click(1766,1037)
	mSleep(500)
end

function openMap()
	click(1948,40)
	mSleep(500)
	click(2070,1005)
	mSleep(500)
	touchDown(1, 100, 100)
	mSleep(100)
	touchMove(1, 700, 350)
	mSleep(100)
	touchUp(1, 700, 350)
	mSleep(500)
end

function openCabin()
	click(499,94)
	mSleep(500)
end

onsailCount = 0
function isOnSail()
	x, y = findColor({1754, 18, 2197, 361}, 
	"0|0|0x1fa634,2|-1|0x1fa634,2|2|0x1fa634",
	96, 0, 0, 0)
	
	if x == -1 then
		x, y = findColor({1734, 13, 2201, 363}, 
		"0|0|0x0b3c13,3|1|0x0b3c13,1|4|0x0b3912",
		96, 0, 0, 0)
	end
	
	if x > -1 then
		onsailCount = 0
		sysLog('true')
		return true
	elseif onsailCount > -5 then
		onsailCount = onsailCount - 1
		return true
	else 
		onsailCount = onsailCount - 1	
--		需要再文本检查一下有没有进入城市
		text = ocr.getText(1636,20,1734,66)
		sysLog(tostring(text))
		if(text=='领地' or text=='同盟') then
			return false
		else 
			mSleep(3000)
			return true
		end
	end
end

function isInCity()
	x, y = findColorInRegionFuzzy(0x1973ca, 95, 0, 0, 2207, 1241, 0, 0)
	
	if x > -1 then
		return true
	else 
		return false
	end
end

function speedup()
	x, y = findMultiColorInRegionFuzzy(0xe1d1a7,"1|-10|0x958160,72|-7|0xef7302,31|33|0xd2c6a7,-3|40|0xbea87f,-21|76|0xe65308", 95, 0, 0, 2207, 1241, 0, 0)
	if x > -1 then
		toast('加速')
		click(x,y)
	end
end

function groupBuy(city)
	openTradeHouse(city)
	clickBuy()
	addAllGoods()
	confirmBuy()
	quit()
	quit()
end

function startwith(str, substr)
	if str == nil or substr == nil then
		return nil
	end
	if string.find(str, substr) == 1 then
		return true
	else
		return false
	end
end


--检查有没有货物，必须是在cabin里面
function isLoaded()
	openCabin()
	text = ocr.getText(1550,1030,1638,1081) 
	quit()
	if(tonumber(text)==nil) then
		text = 0
	end	
	if(tonumber(text)>10) then
		printScreen('船舱货物数为'..tostring(text))
		return true
	else 
		return false
	end
end

function isTaohuaWood()
	openCabin()
	click(1272,333)
	text = ocr.getText(630,283,1036,361)
	quit()
	if startwith(text,'桃花') then
		printScreen('载有桃花木')
		return true
	elseif startwith(text,'碧') then
		printScreen('载有碧玺')
		return true
	elseif startwith(text,'黑') then
		printScreen('载有黑曜石')
		return true
	elseif startwith(text,'帝王玉') then
		printScreen('载有帝王玉')
		return true
	else 
		return false
	end
end

--todo：增加半点在世界频道录入托帕石的功能
function onSail()
	printScreen('航行中...')
	sysLog(tostring(onsailCount))
	while(true) do
		if isOnSail() then
			sysLog('on sail')
			speedup()
			sayTopaz()
			checkFront()
			pickupBox()
			mSleep(3000)
		else
			break
		end
	end
	onsailCount = 0
end

local topaz = true
function sayTopaz()
	t = getNetTime()
	if( t%7200 < 5400 and t%7200 > 5250 and topaz==true) then
		printScreen('猜托帕石')
		click(1108,1127)
--		点击世界
		click(86,634) 
--		点击输入框
		click(349,1177)
		inputText("#CLEAR#") --删除输入框中的文字（假设输入框中已存在文字）
		inputText("托帕石 #ENTER#")
		mSleep(1000)
		click(854,571)
		click(813,1173)
		clickSomewhere(1)
		topaz = false
	end
	
	if(t%7200>5400) then
		topaz = true
	end
end

function checkFront()
	while(true) do
		isfront = isFrontApp("com.netease.dhhzl"); --更新前台状态
		if isfront == 1 then
			break
		end
		mSleep(3000)
	end
end

function clickCityRight()
	click(2070,621)
	mSleep(500)
end

function clickCityLeft()
	click(140,617)
	mSleep(500)
end

--选择最优出货城市
--检查贡献度是否低于30万，是的话就不再拉货
function getGoodsSellCity(goods)
	printScreen('检查奥斯陆')
	openMap()
	list = string.split(cities_all['奥斯陆'],',')
	city_change = {'奥斯陆','哥本哈根','里加','斯德哥尔摩','吕贝克','卑尔根','但泽','柯尼斯堡','汉堡'
	,'不莱梅','阿姆斯特丹','安特卫普','阿尔克马尔','格罗宁根','爱丁堡','伦敦','多佛','都柏林','南安普顿','加来'}
	x1=list[1]
	y1=list[2]
	x2=list[3]
	y2=list[4]
	
	click(x1,y1)		
	mSleep(3000)
	click(x2,y2)
	mSleep(500)
	
	local goods_price = {
		桃花心木=10790,
		黑曜石=14000,
		帝王玉=18500,
		雪茄=11000,
	}
	local max_price = 0
	local max_city = ''
	local index = 1
	while(true) do	
		goods = ocr.getText(1243,381,1401,444) -- 首个货物名称
		price = ocr.getText(1487,385,1713,443) -- 首个货物价格
		if(goods==nil or price==nil) then
			lua_restart()
		end
		price = string.split(price,'(')

		if(price[2]==nil) then 
			price = 0
		else
			price = price[1] 
		end
		printScreen(goods..price)
		city = city_change[index]
		index = index + 1
		price = tonumber(price)
		if(price>max_price) then
			max_price = price
			max_city = city
		end
		
		if(city=='加来') then 
			quitDialog()
			quit()
			return max_city
		end
		
		if(price>goods_price[goods]) then
			quitDialog()
			quit()
			return city
		else
--			往右点击换个城市，
			clickCityRight()
		end
	end
end

function pickupBox()
	x, y = findColor({134,378,1768,864}, 
	"0|0|0x8d665c,30|3|0x815b54,30|38|0x8b655c,14|35|0x4b4751",
	95, 0, 0, 0)
	if x > -1 then
		click(x,y)
	end
end

--openMap()
--click(772,910)
--sayTopaz()
--actionConfig = require("captcha").init()	
--runOnce(actionConfig)	
--appid = frontAppName()
--printScreen(appid)
--do return end

local confirm,result=showUI("ui.json");
if confirm==0 then        
  toast("您选择了取消，停止脚本运行")
  lua_exit()
end

sysLog(tostring(result['pg']))

local actionConfig

if(result['pg']=='1') then
	if(result['rg']=='0') then
		actionConfig = require("fish").init()
	elseif(result['rg']=='1') then
		actionConfig = require("diamond").init()
	elseif(result['rg']=='2') then
		actionConfig = require("bargirl").init()	
	elseif(result['rg']=='3') then
		actionConfig = require("popular").init()		
	elseif(result['rg']=='4') then	
		actionConfig = require("captcha").init()	
	end
else
	source_cities = {'阿姆斯特丹','格罗宁根','塞维利亚','里斯本'}
	target_cities = {'威廉斯塔德','开曼','圣保罗','特略鲁西','卡宴','贝伦'}
	city_from = source_cities[tonumber(result['city_from'])+1]
	city_to = target_cities[tonumber(result['city_to'])+1]
	printScreen('从'..city_from..'到'..city_to)
	special_goods = result['special_goods']

	if(result['city_from']=='0') then
		actionConfig = require("harbour").init()
	elseif(result['city_from']=='1') then
		actionConfig = require("harbour2").init()	
	elseif(result['city_from']=='2') then
		actionConfig = require("harbour3").init()	
	elseif(result['city_from']=='3') then
		actionConfig = require("harbour5").init()
	end
end


--runOnce(actionConfig)
runForever(actionConfig)
do return end





