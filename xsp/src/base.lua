_isDebug = false

function click(x, y)
	x = x + math.random(-1,1) 
	y = y + math.random(-1,1)
	touchDown(1, x, y)
--	mSleep(math.random(200,250))            --某些特殊情况需要增大延迟才能模拟点击效果
	mSleep(150)									--点击时间不要低于150，再小的点击延迟另写函数
	touchUp(1, x, y)
	sysLog('点击:'.. x..','..y)
	local id = createHUD()---创建HUD用于显示点击位置圆点
	--  local s = height * 0.018 --用于按屏幕大小缩放显示圆点大小
	showHUD(id,"",1,"0xffff0000","d.png",0,x-25,y-25,50,50)---d.png为圆点图片，可以用PS做一个
	mSleep(500)
	hideHUD(id)
end

local printID
printID = createHUD()  --创建一个HUD
function printScreen(msg)
	sysLog(tostring(msg))
	showHUD(printID,msg,50,"0xffff0000","0xffffffff",0,10,1100,500,100)      --显示HUD内容
--	mSleep(1000)
end

--debug的时候才会出现
function print2(...)
	if not _isDebug then
		do return end
	end
	local params = {...}
	local str = nil
	for k,v in pairs(params) do
		if not str then
			str = tostring(v)
		else
			str = str .. ", " .. tostring(v)
		end
	end
    sysLog("[debug]>>>>"..str)
end

function checkScreeSize() --检查分辨率函数 from 云耳
  if w == 640 and h==1136 then 
      require('t640')
			_w,_h=640,1136
	elseif w == 768  or h == 1024  then
	   lua_exit()
			--_w,_h=768,1024
	else                 
      needScale = true
      if w== 750 or w==1242 or w == 720 or w== 1080 or w==1440 or h== 1334 or h == 2208 then
        require('t640')
				_w,_h=640,1136
      elseif w == 1536 or w == 2048 then
        lua_exit()
				--t=t4_3
				--_w,_h=768,1024
      else
        toast("您的手机分辨率为"..h.."*"..w.."。很抱歉，不支持您的手机分辨率。")
        mSleep(1000)
        lua_exit()
      end
    end
end


function click2(x, y)  --点击函数
	local x, y = x, y
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
	local index =0 --math.random(1,5)
	x = x + math.random(-3,3) 
	y = y + math.random(-3,3)
	touchDown(index,x, y)
	mSleep(math.random(60,180))                --某些特殊情况需要增大延迟才能模拟点击效果
	touchUp(index, x, y)
	taptime=mTime()
	mSleep(500)
end


function checkColor(array,s) --多点比色
	s = s or 95
	s = math.floor(0xff*(100-s)*0.01)
	for var = 1, #array do
		local lr,lg,lb = getColorRGB(array[var][1],array[var][2])
		local rgb = array[var][3]
    
		local r = math.floor(rgb/0x10000)
		local g = math.floor(rgb%0x10000/0x100)
		local b = math.floor(rgb%0x100)
		if math.abs(lr-r) > s or math.abs(lg-g) > s or math.abs(lb-b) > s then
			return false
		end
	end
	return true
end

function findMultiColor(t)  --多点找色
	return findMultiColorInRegionFuzzy(t[1],t[2], t[3], t[4], t[5], t[6], t[7])
end

function getPage() --获取当前页面函数，校对用
	local res = '未知页面'
	keepScreen(true)
	if needScale then
	setScreenScale(_w,_h,0)
	end
	for _, v in pairs(界面列表) do
		if checkColor(v[2]) then
			res = v[1]  --界面名称
			break
		end
	end
	if needScale then
	resetScreenScale()
	end

	keepScreen(false)
	sysLog(res)
	return res
end


function F点击页面元素(page,unit) --点击元素
    sysLog('点击模块当前页面：'..page.n)
	sysLog('点击模块当前元素：'..unit)
	local x,y
	local res=false
	keepScreen(true)
  if needScale then --缩放
	setScreenScale(_w,_h,0)
	end
	for _ , v in pairs(page) do
		if v.w=='CC' then
		  --sysLog('循环K：'..v[1])
			if F多点比色(v.c) and v[1]==unit then
			  sysLog('当前点击：'..v[1])
				F点击(v.tap[1],v.tap[2])
				res = true
				break
			end
		elseif v.w=='MSC' then
			x,y=F多点找色(v.c)
			sysLog('找:'..v[1]..'x='..x..'y='..y)
			if x>-1 and y>-1 and v[1]==unit then
			  F点击(x,y)
				res=true
				break
			end
		end
	end
	if needScale then
	--setScreenScale(_w,_h,0)
	resetScreenScale()
	end
	keepScreen(false)
	return res
end

currentPage = nil
function command(t) --运行任务函数
	time=mTime()
	while true do
	  if mTime()-time>30000 then
			break
		end
	  	currentPage=getPage() --获取当前页面
		for k,v in pairs(t) do
		  --sysLog(v[1].n)
			if currentPage==v[1].n then
				for _,_v in pairs(v[2]) do
				  sysLog('传入点击元素：'.._v)
			    if click(v[1],_v) then
						time=mTime()
					  break
					end
				end
			end
		end
		mSleep(1000)
	end
end

local function sort(f)
    local ret = {}
	for k,v in pairs(f) do
		if tonumber(k) then
			if #ret == 0 then
				table.insert(ret, {func = v, id = k})
			else
				local flag, index, count = false, 0, 1
				for k2, v2 in pairs(ret) do
					print2(k, v2.id)
					if k < v2.id then
						flag = true
						index = count
						break
					end
					count = count + 1
				end
				if flag then
					table.insert(ret, index, {func = v, id = k})
				else
					table.insert(ret, {func = v, id = k})
				end
			end
		end
	end
	return ret
end

-- 跑一次
function runOnce(stepConfig)
	local ret = sort(stepConfig)
    for k, v in pairs(ret) do
		print2("running:", v.id)
    	mSleep(500)
    	v.func()
    end
end

function runForever(stepConfig)
	local ret = sort(stepConfig)
	
	while(true) do
		for k, v in pairs(ret) do
			print2("running:", v.id)
			mSleep(500)
			v.func()
		end
		mSleep(1000)
		sysLog('新一轮循环开始')
	end
end

--滑动进度条的函数
function slipCaptcha(x)
	printScreen('准备破解验证码')
	tap(712,917)
	move2x(712+x)
	
	quit()
	quit()
end






