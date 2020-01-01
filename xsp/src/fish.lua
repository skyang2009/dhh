--钓鱼脚本



function fclick(x, y)
	x = x + math.random(-3,3) 
	y = y + math.random(-3,3)
	touchDown(1, x, y)
--	mSleep(math.random(200,250))                --某些特殊情况需要增大延迟才能模拟点击效果
	mSleep(50)
	touchUp(1, x, y)
	sysLog('点击:'.. x..','..y)
	local id = createHUD()---创建HUD用于显示点击位置圆点
	--  local s = height * 0.018 --用于按屏幕大小缩放显示圆点大小
	showHUD(id,"",1,"0xffff0000","d.png",0,x-25,y-25,50,50)---d.png为圆点图片，可以用PS做一个
	mSleep(10)
	hideHUD(id)
end



function clickFish(number, stime)
	for i=0,number,1 do
		fclick(2080,1066)
		mSleep(stime)
	end
end

local f = {}

f.init = function (a)
	return f
end

--click基础时间是60ms
f[1] = function (...)
	printScreen('进入钓鱼画面')
	local ocr = require("ocr.BaiduOCR")
	local status=0
	while(true) do
		text = ocr.getText(244,583,743,698) 
		printScreen(text)
		if(startwith(text,'快看')) then
			status = 1
			clickFish(1,200)
		elseif (startwith(text, '这次的鱼似乎比较普通')) then
			status = 2		
			printScreen('40次点击开始')
			clickFish(29,240)	
		elseif (startwith(text, '看起来这条鱼的力道很大')) then
			status = 3
			printScreen('60次点击开始')
			clickFish(30,95)	
			mSleep(800)
			clickFish(23,160)
		elseif (startwith(text, '啊,这次')) then
			status = 4
			printScreen('12次点击开始')
			clickFish(12,890)	
		elseif (startwith(text, '这鱼儿反抗很激烈')) then
			status = 5
			printScreen('30次点击开始')
			clickFish(30,95)	
			mSleep(800)
			clickFish(5,900)
		elseif (startwith(text, '有鱼上钩')) then
			status = 6
			printScreen('14次点击开始')
			clickFish(5,1200)	
			mSleep(1000)
			clickFish(4,1300)	
		elseif (startwith(text, '鱼快跑了')) then
			status = 7
			printScreen('13次点击开始')
			clickFish(8,1300)	
		else
			status = 0
		end
		
		if(status~=1) then
			mSleep(1000)
		end
	end
	
	
end

f[5] = function (...)	
	
end

f[13] = function (...)
	

end

f[15] = function (...)
-- ...
end

return f



