-- script by devilkkw
-- edited by flowtheci

-- Don't touch this
local radar = 
{
	shown = false, 
	freeze = false, 
	info = "~g~Radar~n~Active", 
-- Touch this if u want
	minSpeed = 5.0,
	maxSpeed = 75.0,
}
-- The distance to check in front of the player for a vehicle
local distanceToCheckFront = 50.0


function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/1, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustPressed(1, 311) and GetLastInputMethod( 0 ) and not IsPauseMenuActive() and not blockinput and (IsPedInAnyPoliceVehicle(GetPlayerPed(-1)))then -- K
			if radar.shown then radar.shown = false else radar.shown = true end		
                Wait(75)
	    end
		if IsControlJustPressed(1, 311) and GetLastInputMethod( 0 ) and not IsPauseMenuActive() and not blockinput then -- K
		    if radar.shown then radar.shown = false end
				Wait(75)
		end
		if IsControlJustPressed(1, 38)then -- E
			if radar.freeze then radar.freeze = false else radar.freeze = true end
		end
		if radar.shown then
			if radar.freeze == false then
					local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
					local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, distanceToCheckFront, 0.0)
					local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( vehicle, 0.0, distanceToCheckFront, 0.0 )
					local veh = getVehicleInDirection(coordA, coordB)
				if veh ~= nil then

					local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh));
					local plate = GetVehicleNumberPlateText(veh)
					local vehSpeedMph = GetEntitySpeed(veh)*2.236936
				    if model == "rocoto" then model = "ROCOTO" end
				    if model == "CARNOTFOUND" then model = "" end
					
					if vehSpeedMph > radar.minSpeed then			  
						if vehSpeedMph < radar.maxSpeed then 
							radar.info = string.format("| ~b~Model:~w~ %s ~n~| ~b~Plate:~w~ %s ~n~| ~y~Mph:~g~ %s",model,plate,math.ceil(vehSpeedMph))
						else
							radar.info = string.format("| ~b~Model:~w~ %s ~n~| ~b~Plate:~w~ %s ~n~| ~y~Mph:~r~ %s",model,plate,math.ceil(vehSpeedMph))
						end
							if vehSpeedMph > radar.maxSpeed then
							PlaySoundFrontend(-1,  "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 0,0,1)	
						end
							if vehSpeedMph > radar.maxSpeed then
							radar.freeze = true
						end
					end
				end
			end
            drawTxt(0.360,0.900,0.187,0.215,0.365,radar.info,255,255,255,255)		
		end
	end  
end)

-- From point A to B -- Use GetOffsetFromEntityInWorldCoords for distance
function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end