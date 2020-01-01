--破解滑动验证码
--1、解决图片上传问题
--2、解决滑动问题
local bb   = require("badboy")
local json = bb.getJSON()
bb.loadluasocket()

local function snapshotRead(x1, y1, x2, y2)
	local filename = '[public]ocr.png'
	snapshot(filename, x1, y1, x2, y2)
	local file = io.open(filename, 'r')
	local retbyte = file:read("*a")
	file:close()
	return retbyte
end

local function urlEncode(s)
    s = string.gsub(s, "([^%w%.%- ])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
    return (string.gsub(s, " ", "+"))
end

local function has_key(search, t)
	if type(t) ~= 'table' then return false end
    for k, v in pairs(t) do
      if k == search then
          return true
      end
    end
    return false
end

function getImage(x1, y1, x2, y2)
	local imgRaw    = snapshotRead(x1, y1, x2, y2)
	local imgBase64 = ZZBase64.encode(imgRaw)
	local imgData   = urlEncode(imgBase64)

	if imgData == nil or #imgData <= 0 then
		sysLog('读取截图数据失败')
		return nil
	end

	local host      = 'quant.tomorrowstar.net:3000'               -- 域名
--	local host	 	= '192.168.31.250:3000'
--	local host	 	= '172.16.0.209:3000'
	local path      = '/post/image' -- 请求路径
	local url       = 'http://' .. host .. path        -- URL地址
	local method    = "POST"                           -- 请求方法
	local params    = {}                               -- URL参数项，除特殊情况请不要修改
	local post_data = 'image='..imgData                -- 窗体数据，请按照 key=value 的方式编码
	local headers   = {
			['host']           = host,
	        ['Content-Type']   = 'application/x-www-form-urlencoded',
	        ['Content-Length'] = #post_data,
	}

	local http = bb.http
	local response_body = {}
	local res, code = http.request {  
	    url     = url,
	    method  = method,
	    headers = headers,
	    source  = ltn12.source.string(post_data),
		sink    = ltn12.sink.table(response_body)
	}

--	sysLog(tostring(res))
	if res == 1 and #response_body > 0 then
		local data = json.decode(response_body[1])
		sysLog('发现滑动长度：'..tostring(data))
		return tonumber(data)
	else 
		return 0
	end
	
end


local function slide(bias)
	local x=700
	local y=920
	local id = createHUD()---创建HUD用于显示点击位置圆点
	showHUD(id,"",1,"0xffff0000","d.png",0,x-25,y-25,50,50)---d.png为圆点图片，可以用PS做一个
	mSleep(50)
	hideHUD(id)
	
	bias = bias-150
	
--	touchDown(1, x, y)
--	mSleep(500)
--	touchMove(1, x+bias-100, y)
--	mSleep(100)
--	touchMove(1, x+bias-50, y)
--	mSleep(100)
	touchMove(1, x+bias, y)
	mSleep(500)
	touchUp(1, x+bias, y)  
end

local ocr = require("ocr.BaiduOCR")
local f = {}
f.init = function ()
	return f
end


--旧的方法
function crackCaptcha2()
	x, y = findColorInRegionFuzzy(0x105c86, 95, 625, 879, 784, 955, 0, 0)
	if x > -1 then
		printScreen('滑动解锁')
		local bias = getImage(624,370,1513,839) -- 验证码图片区域
		if(bias~=0) then
			printScreen('识别成功'..tostring(bias))
			slide(bias)
		else 
			printScreen('识别失败')
			slide(300)
		end
		mSleep(3000)
	end
end

function crackCaptcha()
	while(true) do
		mSleep(3000)
		x, y = findColorInRegionFuzzy(0x105c86, 95, 625, 879, 784, 955, 0, 0)
		if x > -1 then
			printScreen('滑动解锁')
			touchDown(1, 700, 920)
			mSleep(200)
			local bias = getImage(624,370,1513,839) -- 验证码图片区域
			if(bias~=0) then
				printScreen('识别成功'..tostring(bias))
				slide(bias)
			else 
				printScreen('识别失败')
				slide(300)
			end
		else
			break
		end
	end	
end

f[1] = function (...)	
	while(true) do
		x, y = findColorInRegionFuzzy(0x105c86, 95, 625, 879, 784, 955, 0, 0)
		if x > -1 then
			printScreen('滑动解锁')
			touchDown(1, 700, 920)
			mSleep(200)
			local bias = getImage(624,370,1513,839) -- 验证码图片区域
			if(bias~=0) then
				printScreen('识别成功'..tostring(bias))
				slide(bias)
			else 
				printScreen('识别失败')
				slide(300)
			end
			mSleep(3000)
		else
			break
		end
	end	
end


return f





