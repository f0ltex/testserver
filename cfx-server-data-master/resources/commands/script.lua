TriggerEvent('es:addCommand', 'commands', function(source, args, user)
	TriggerEvent("chatMessage", "", {0, 0, 0}, "Available commands: ")
end, {help = "Show the available commands."})