do
 local function run(msg, matches)
 	if matches[1] == "specificID" then
 	local result = run_command('nmap '..matches[2])
 	return 'ID matches !\n\n' ..result
else
		return 'ID not matches !'
	end
 end

 return {
 description = "Execute network mapper",
 usage = "!nmap [specificID] [COMMAND]",
 patterns = {
 "^!nmap (specificID) (.*)$"
 },
 run = run,
 }
end
