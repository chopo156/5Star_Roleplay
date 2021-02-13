# vRP Hud Inventory

## Description
  Basic vRP script that provides an HUD type inventory instead of a menu one. This is based on the ```esx_inventoryhud``` script, even though the client and server lua code has completely been redone. The js code has been kept mostly the same.

  The inventory can be opened by pressing ```F3```. Feel free to edit the script if you'd like to open it from any menu of your liking.

  It can be integrated with every script that uses the ```vRP.openChest``` function by using the ```vRPin.openChest``` one. Some minor code modifications may be needed to get it to work properly.

  The item's pictures directory is ```html\img\items```. Don't forget to add them to the ```fxmanifest.lua``` file and restart the server afterwards.

## Pictures
<details><summary>SHOW</summary>
<p>

![Image1](https://i.postimg.cc/NMZDGgws/image.png)
![Image2](https://i.postimg.cc/SNFdwNrV/image.png)
![Image3](https://i.postimg.cc/HnQwpX2z/image.png)
</p>
</details>

## Dependencies
 #### Mandatory
 * [Changes](#changes-to-vrp-mandatory) - Mandatory modifications to vRP;
 
 #### Optionals
 * [vRP_cards]() - Cards for players to buy stuff with them;

## Installation
  1. [IMPORTANT!] Install the dependencies first;
  2. Move the [vrp_hud_inventory](#vrp-items) folder to your ```resources``` directory;
  3. Add "```start vrp_hud_inventory```" to your server.cfg file;
  4. Make any changes you like to the config file;
  5. Enjoy!
  
## Changes to vRP (mandatory)
  * Add some necessary functions to the ```vrp\modules\inventory.lua``` file as below:
    <details><summary>SHOW</summary>
    
    ```lua
    function vRP.getItemChoiceHud(idname)
      local args = vRP.parseItem(idname)
      local item = vRP.items[args[1]]
      local choices = {}
      if item ~= nil then
        -- compute choices
        local cchoices = vRP.computeItemChoices(item,args)
        if cchoices then -- copy computed choices
          for k,v in pairs(cchoices) do
            choices[k] = v
          end
        end
      end

      return choices
    end

    function vRP.trash(user_id, idname, amount)
      local player = vRP.getUserSource(user_id)
      if user_id ~= nil then
        local amount = parseInt(amount)
        local trigger = 0

        for v,k in pairs(cfgItem.seizable_items) do
          if (idname == k) then
            trigger = 1
            
          end
        end
      
        if trigger == 0 then
          if (vRP.tryGetInventoryItem(user_id,idname,amount,false)) then
            vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
          end
        else
          if (vRP.hasPermission(user_id, "police.announce")) then
            if vRP.tryGetInventoryItem(user_id,idname,amount,false) then
              vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
            end
          else
            vRPclient.notify(player,{"~r~You cannot throw away illegal items!"})
          end
        end
      end
    end

    function vRP.giveItemHud(player, idname, amount)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        -- get nearest player
        vRPclient.getNearestPlayer(player,{10},function(nplayer)
          if nplayer ~= nil then
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
                -- weight check
                local new_weight = vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(idname)*amount
                if new_weight <= vRP.getInventoryMaxWeight(nuser_id) then
                  if vRP.tryGetInventoryItem(user_id,idname,amount,true) then
                    vRP.giveInventoryItem(nuser_id,idname,amount,true)

                    vRPclient.playAnim(player,{true,{{"mp_common","givetake1_a",1}},false})
                    vRPclient.playAnim(nplayer,{true,{{"mp_common","givetake2_a",1}},false})
                  else
                    vRPclient.notify(player,{lang.common.invalid_value()})
                  end
                else
                  vRPclient.notify(player,{lang.inventory.full()})
                end
            else
              vRPclient.notify(player,{lang.common.no_player_near()})
            end
          else
            vRPclient.notify(player,{lang.common.no_player_near()})
          end
        end)
      end
    end

    function vRP.getItemChoiceHud(idname)
      local args = vRP.parseItem(idname)
      local item = vRP.items[args[1]]
      local choices = {}
      if item ~= nil then
        -- compute choices
        local cchoices = vRP.computeItemChoices(item,args)
        if cchoices then -- copy computed choices
          for k,v in pairs(cchoices) do
            choices[k] = v
          end
        end
      end

      return choices
    end
    ```
    </details>
    
  * Add the function below to the ```vrp\modules\basic_garage.lua``` file:
    <details><summary>SHOW</summary>
    
    ```lua
    function vRP.getCfgInventoryHud()
      return cfg_inventory
    end
    ```
    </details>

  * Add the code below to the ```vrp\base.lua``` file:
    <details><summary>SHOW</summary>
    
    ```lua
    vRPin = Proxy.getInterface("vrp_hud_inventory")
    ```
    </details>

## License
  ```
  vRP Hud Inventory
  Copyright (C) 2020  CPietro - Discord: @TBGaming#9941

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as published
  by the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
  ```
