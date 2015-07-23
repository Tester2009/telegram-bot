do
-- written by Muhammad Aliff Muazzam. muhammadaliffmuazzam@gmail.com . https://www.facebook.com/Tester2009. https://github.com/alepcat1710. http://aliff.muazzam.my .
-- From German-Malaysian Institute (GMI). Training for Advanced Technology.
-- July 23, 2015. 

	local function get_ringgit()
		local access_key = ""
		local url = "http://apilayer.net/api/live?access_key="..access_key.."&currencies=MYR&source=USD&format=1" -- get your own access_key at https://currencylayer.com/
		local b,c = http.request(url)
		if c ~= 200 then return nil end
		local duit = json:decode(b)
		local money = duit.quotes.USDMYR
		local info = "1USD == "
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
