
local lcfg = module("vrp", "cfg/base")
local cfg = module("vrp_storerobbery", "cfg/storerobbery")

-- LANG
Luang = module("vrp", "lib/Luang")
Lang = Luang()
Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

Lang:loadLocale(lcfg.lang, module("vrp_storerobbery", "cfg/lang/"..lcfg.lang) or {})




local vRPstorerob = class("vRPstorerob", vRP.Extension)


function vRPstorerob:__construct()
  vRP.Extension.__construct(self)

end

robbers = {}
lastrobbed = {}


-- EVENT
vRPstorerob.event = {}


function vRPstorerob.event:playerSpawn(user, first_spawn)
    if first_spawn then
        for k, v in pairs(cfg.storerobbery) do
            local gcfg = v._config

            if gcfg then
                local x = gcfg.x
                local y = gcfg.y
                local z = gcfg.z
                local ment = clone(gcfg.map_entity)
                ment[2].title = v.name
                ment[2].pos = {x, y, z - 1}
                vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])
            end
        end
    end
end

-- TUNNEL
vRPstorerob.tunnel = {}

function vRPstorerob.tunnel:cancelRobbery(robb)
  local player = source
	if(robbers[source])then
	robbers[source] = nil
	canceled = true
	vRP.EXT.Audio.remote._removeAudioSource(-1, "Alarm")
	TriggerClientEvent('chatMessage', player, lang.robbery.title_robbery(), {255, 0, 0}, lang.robbery.canceled())
		
	end
end



function vRPstorerob.tunnel:startRobbery(robb, x,y,z)
  local user = vRP.users_by_source[source]

  if user and user:isReady() then
  local canceled = false
  local player = source
  local cops = vRP.EXT.Group:getUsersByPermission(cfg.cops)
  local robbery = cfg.storerobbery[robb]
  if user:hasPermission(cfg.cops) then
  	self.remote._robberyComplete(player)
    vRP.EXT.Base.remote._notify(user.source, lang.robbery.cant_rob())
  else
    if robbery then
	  if #cops >= robbery.cops then
		if lastrobbed[robb] then
		  local past = os.time() - lastrobbed[robb]
		  local wait = robbery.rob + robbery.wait
		  if past <  wait then
		    TriggerClientEvent('chatMessage', player, lang.robbery.title_robbery(), {255, 0, 0}, lang.robbery.wait({wait - past}))
			self.remote._robberyComplete(player)
			canceled = true
		  end
		end
		if not canceled then

		TriggerClientEvent('chatMessage', player, lang.robbery.hold({math.ceil(robbery.rob/60)}))
		  TriggerEvent("cooldownt")
		  lastrobbed[robb] = os.time()
		  robbers[player] = robb

		local x,y,z = vRP.EXT.Base.remote.getPosition(user.source)
		local audio = "https://s0.vocaroo.com/media/download_temp/Vocaroo_s0uuSMNZWD3B.mp3"
		vRP.EXT.Phone:sendServiceAlert(nil, "police" ,x,y,z, lang.robbery.progress({robbery.name})) -- send service alert (call request)
		vRP.EXT.Base.remote._notifyPicture(user.source, "CHAR_CALL911", 1, "WARNING", "Se activo la alarma.", "La policia viene en camino!")
		vRP.EXT.Audio.remote._setAudioSource(-1, "Alarm", audio, 0.1, x,y,z, 80)

		  local savedSource = player
		  SetTimeout(robbery.rob*1000, function()
			vRP.EXT.Audio.remote._removeAudioSource(-1, "Alarm")
			if(robbers[savedSource])then
			  if user then
				local reward = math.random(robbery.min,robbery.max)
				user:tryGiveItem("dirty_money",reward,false) 
				self.remote._robberyComplete(savedSource)
				vRP.EXT.GUI.remote._announce(-1,"http://i.imgur.com/DY6DEeV.png", lang.robbery.complete({robbery.name}).. ""..reward.." fueron robados!")
			  end
			end
		  end)
		end
      else
		self.remote._robberyComplete(player)
        vRP.EXT.Base.remote._notify(user.source, lang.robbery.not_enough({robbery.cops}))
      end
    end
  end
end
end

vRP:registerExtension(vRPstorerob)


