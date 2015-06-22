do

local function get_fact()
		local url = "https://api.instagram.com/v1/users/353770979/media/recent/?access_token=390954741.087a6c7.0e92dc2ec6844cce9b0ff05d739d301a"
		local b,c = https.request(url)
		if c ~=200 then return nil end
		local fact = json:decode(b)
		-- random max json table size
		local i = math.random(#fact.data)
		local link_image = fact.data[i].images.low_resolution.url
		local title = fact.data[i].caption.text

		if link_image:sub(0,2) == '//' then
			 link_image = msg.text:sub(3, -1)
			end
			return link_image, title
		end

		local function send_title(cb_extra, success, result)
		if success then
			 send_msg(cb_extra[1], cb_extra[2], ok_cb, false)
			end
		end

		local function run(msg, matches)
			local receiver = get_receiver(msg)
			local url, title = get_fact()
			send_photo_from_url(receiver, url, send_title, {receiver, title})
			return false
		end

		return {
			description = "8fact for Telegram. Customized by @Tester2009",
			usage = "!8fact: Send random image from 8fact",
			patterns = {"^!8fact$"},
			run = run
		}

end
