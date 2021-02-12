local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")

async(function()
  vRP.loadScript("vrp2_inventoryhud", "inventory/server")
end)
