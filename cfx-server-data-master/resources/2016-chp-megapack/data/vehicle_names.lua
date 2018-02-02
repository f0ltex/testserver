	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	-- CVPI w/ liberty
	AddTextEntry('0x54830233', 'hp1')
	-- 2015 charger
	AddTextEntry('0x519EF9F7', 'hp2')
	-- 2014 explorer
	AddTextEntry('0x43605D7A', 'hp3')
	-- 2014 slicktop explorer
	AddTextEntry('0x61A019F9', 'hp4')
	-- ford expedition
	AddTextEntry('0xD3487D4C', 'hp5')
	-- 2016 explorer
	AddTextEntry('0x7C264F05', 'hp6')
	-- cvpi w/ vector
	AddTextEntry('0x65E42281', 'hp7')
	-- 2009 charger
	AddTextEntry('0x9EB8142C', 'hp8')
	-- ford f350
	AddTextEntry('0xFA81CBBE', 'hp9')
	-- cvpi slicktop
	AddTextEntry('0x7DB7A427', 'hp10')