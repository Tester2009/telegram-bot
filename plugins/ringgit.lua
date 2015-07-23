do
-- written by Muhammad Aliff Muazzam. muhammadaliffmuazzam@gmail.com . https://www.facebook.com/Tester2009. https://github.com/alepcat1710. http://aliff.muazzam.my .
-- From German-Malaysian Institute (GMI). Training for Advanced Technology.
-- July 23, 2015. 

-- look here for time formatting http://www.lua.org/pil/22.1.html
-- source: http://pastebin.com/tkjpamfy
local offset = "+8.00" --put your timezone value
local function format_time(timestamp, format, tzoffset, tzname)
   if tzoffset == "local" then  -- calculate local time zone (for the server)
      local now = os.time()
      local local_t = os.date("*t", now)
      local utc_t = os.date("!*t", now)
      local delta = (local_t.hour - utc_t.hour)*60 + (local_t.min - utc_t.min)
      local h, m = math.modf( delta / 60)
      tzoffset = string.format("%+.4d", 100 * h + 60 * m)
   end
   tzoffset = tzoffset or "GMT"
   format = format:gsub("%%z", tzname or tzoffset)
   if tzoffset == "GMT" then
      tzoffset = "+0000"
   end
   tzoffset = tzoffset:gsub(":", "")
 
   local sign = 1
   if tzoffset:sub(1,1) == "-" then
      sign = -1
      tzoffset = tzoffset:sub(2)
   elseif tzoffset:sub(1,1) == "+" then
      tzoffset = tzoffset:sub(2)
   end
   tzoffset = sign * (tonumber(tzoffset:sub(1,2))*60 +
tonumber(tzoffset:sub(3,4)))*60
   return os.date(format, timestamp)
end

	local function get_ringgit()
		local access_key = ""
		local url = "http://apilayer.net/api/live?access_key="..access_key.."&currencies=MYR&source=USD&format=1" -- get your own access_key at https://currencylayer.com/
		local b,c = http.request(url)
		if c ~= 200 then return nil end
		local duit = json:decode(b)
		local money = duit.quotes.USDMYR
		local date = format_time(os.time(), "!%Y-%m-%d", offset)
		local info = "Date: "..date.."\n\n1USD == "
		return info.."RM"..money
	end


local function run(msg, matches)
  return get_ringgit()
end

return {
  description = "Check ringgit (MYR) value based USD",
  usage = "!ringgit: Return ringgit value based USD",
  patterns = {
  "^!ringgit$"
  },
  run = run
}
end
