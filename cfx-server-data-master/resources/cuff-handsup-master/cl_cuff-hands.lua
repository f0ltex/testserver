local handcuff = false

--[[ HANDCUFF SCRIPT ]]--
RegisterNetEvent("Handcuff")
AddEventHandler("Handcuff", function()
	local lPed = GetPlayerPed(-1)
	if DoesEntityExist(lPed) then
		if IsEntityPlayingAnim(lPed, "mp_arresting", "idle", 3) then
			ClearPedSecondaryTask(lPed)
			SetEnableHandcuffs(lPed, false)
			SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
			handcuff = false
		else
			RequestAnimDict("mp_arresting")
			while not HasAnimDictLoaded("mp_arresting") do
				Citizen.Wait(100)
			end

			TaskPlayAnim(lPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
			SetEnableHandcuffs(lPed, true)
			SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
			handcuff = true
		end
	end
end)
--]]

--[[---------------------]]--

--[[ HANDSUP SCRIPT ]]--
RegisterNetEvent("Handsup")
AddEventHandler("Handsup", function()
	local lPed = GetPlayerPed(-1)
	if DoesEntityExist(lPed) then
		if not IsEntityPlayingAnim(lPed, "mp_arresting", "idle", 3) then
			RequestAnimDict("random@mugging3")
			while not HasAnimDictLoaded("random@mugging3") do
				Citizen.Wait(100)
			end
			
			if IsEntityPlayingAnim(lPed, "random@mugging3", "handsup_standing_base", 3) then
				ClearPedSecondaryTask(lPed)
				SetEnableHandcuffs(lPed, false)
				SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
				TriggerEvent("chatMessage", "", {255, 0, 0}, "Your have put your hands down.")
			else
				TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetEnableHandcuffs(lPed, true)
				SetCurrentPedWeapon(lPed, GetHashKey("WEAPON_UNARMED"), true)
				TriggerEvent("chatMessage", "", {255, 0, 0}, "Your hands are up.")
			end
		else
			TriggerEvent("chatMessage", "You are handcuffed..")
		end
	end
end)
--]]

--[[---------------------]]--

--[[ Other Functions ]]--

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if handcuff and not IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "mp_arresting", "idle", 3) then
			Citizen.Wait(3000)
			Citizen.Trace("BACKUP CUFFING TRIGGERED")
			TaskPlayAnim(GetPlayerPed(PlayerId()), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "mp_arresting", "idle", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			SetPedPathCanUseLadders(GetPlayerPed(PlayerId()), false)
			if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
				DisableControlAction(0, 59, true)
			end
		end

		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@mugging3", "handsup_standing_base", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
				DisableControlAction(0, 59, true)
			end
		end
	end
end)

--]]