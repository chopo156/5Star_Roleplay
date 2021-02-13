Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")


local cvRP = module("vrp", "client/vRP")
vRP = cvRP() 

local vRPstorerob = class("vRPstorerob", vRP.Extension)


cfg = module("vrp_storerobbery", "cfg/storerobbery")

lang = module("vrp_storerobbery", "cfg/lang/"..cfg.lang)

local cooldown = 0
local ispriority = false
local ishold = false

robb = ""
timer = 0
robbing = false
incircle = false
wanted = false



function vRPstorerob:__construct()
  vRP.Extension.__construct(self)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if robbing then
			if(timer > 0)then
				timer = timer - 1
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		if robbing then
			wanted = robb

			robbery_drawTxt(0.66, 1.44, 1.0,1.1,0.4, string.gsub(lang.robbery.robbing, "{1}", timer), 255, 255, 255, 255)
			local ped = GetPlayerPed(-1)
     			local health = GetEntityHealth(ped)
			local pos2 = cfg.storerobbery[robb].pos
			local dist = cfg.storerobbery[robb].dist
			local ped = GetPlayerPed(-1)
			
            		if health == 120 or health < 120 or (Vdist(pos.x, pos.y, pos.z, pos2[1], pos2[2], pos2[3]) > dist) then
				
				self.remote._cancelRobbery(robb)
				robb = ""
				timer = 0
				robbing = false
				incircle = false
			end
		else
			for k,v in pairs(cfg.storerobbery) do
				if(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) < v.dist) then
					DrawMarker(1, v.pos[1], v.pos[2], v.pos[3] - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 0.5001, 255, 0, 0,255, 0, 0, 0,0)
					
					if(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) < 2.0)then
						if (incircle == false) then
							robbery_DisplayHelpText(string.gsub(lang.robbery.rob, "{1}", v.name))
						end
						incircle = true
						if(IsControlJustReleased(1, cfg.key))then
							robb = k
							timer = v.rob
							robbing = true
							self.remote._startRobbery(robb)
							SetPlayerWantedLevel(PlayerId(), 2, 0)
		    					SetPlayerWantedLevelNow(PlayerId(), 0)

						end
					elseif(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) > 2.0)then
						incircle = false
					end
				end
			end
		end

		Citizen.Wait(0)
	end
end)

end

-- TUNNEL
vRPstorerob.tunnel = {}



function vRPstorerob:robberyComplete()
        self.coma = false
	robb = ""
	timer = 0
	robbing = false
	incircle = false
end


function robbery_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function robbery_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)

    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


vRPstorerob.tunnel = {}
vRPstorerob.tunnel.robberyComplete = vRPstorerob.robberyComplete



vRP:registerExtension(vRPstorerob)
