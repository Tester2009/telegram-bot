do
-- written by Muhammad Aliff Muazzam. muhammadaliffmuazzam@gmail.com . https://github.com/alepcat1710.
-- From German-Malaysian Institute (GMI). Training for Advanced Technology.
-- July 23, 2015. 

	local function get_ringgit()
		local url = "http://apilayer.net/api/live?access_key=546be9506fd3dcda391f936de0ede149&currencies=MYR&source=USD&format=1"
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
