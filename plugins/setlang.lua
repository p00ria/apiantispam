local triggers = {
	'^/(lang)$',
	'^/(lang) (%a%a)$'
}

local action = function(msg, blocks, ln)
	if msg.chat.type ~= 'private' and not is_mod(msg) then
		api.sendReply(msg, make_text(lang[ln].not_mod), true)
		return nil
	end   
	
	if blocks[1] == 'lang' and not blocks[2] then
	    local i = 1
	    local message = ''
	    for k,v in pairs(config.available_languages) do
	        message = message..i.. ' - _'..v..'_\n'
	        i = i + 1
	    end
	    api.sendReply(msg, make_text(lang[ln].setlang.list, message), true)
	else
	    local selected = blocks[2]
	    local new = ''
	    for k,v in pairs(config.available_languages) do
	        if selected == v then
	            new = selected
	        end
        end
        if new == '' then
            api.sendReply(msg, make_text(lang[ln].setlang.error), true)
        else
            client:set('lang:'..msg.chat.id, new)
            api.sendReply(msg, make_text(lang[ln].setlang.success, new), true)
            mystat('langchanged')
	    end
	end
end

return {
	action = action,
	triggers = triggers
}