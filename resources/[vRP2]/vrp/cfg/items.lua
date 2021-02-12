local cfg = {}

-- (see vRP.EXT.Inventory:defineItem)
-- map of id => {name, description, menu_builder, weight}
--- name: display name, value or genfunction(args)
--- description: value or genfunction(args) (html)
--- menu_builder: (optional) genfunction(args, menu)
--- weight: (optional) value or genfunction(args)
--- iTypes: special, edible, ammo, tint, comp, weapon
--- Icon: icon name
--- Is this iType usable "yes" or "no"
--
-- genfunction are functions returning a correct value as: function(args, ...)
-- where args is a list of {base_idname,args...}
cfg.items = {
  ["gold_ore"] = {"Gold ore","",nil,1,"item","stone", "no"},
  ["gold_processed"] = {"Gold processed","",nil,1.2,"item","stone", "no"},
  ["gold_ingot"] = {"Gold ingot","",nil,12,"item","gold", "no"},
  ["gold_catalyst"] = {"Gold catalyst","Used to transform processed gold into gold ingot.",nil,0.1,"item","chems", "no"},
  ["demineralized_water"] = {"Demineralized water (1L)","",nil,1,"item","chems", "no"},

  --==================--
  --====Base Items====--
  --==================--
  ["bank_money"] = {"Money from a Bank","Marked bills from a bank.",nil,0.0,"item","black_money", "no"},
  ["groceries"] = {"Groceries","All the things you need for cooking at home.",nil,5.0,"item","bag", "no"},
  --====================--
  --====Casino Items====--
  --====================--
  ["casino_chip"] = {"Diamond Casino Chips","",nil,0.0,"item","stone", "no"},
  --=====================--
  --====Illegal Items====--
  --=====================--
  ["dirty_money"] = {"Dirty money","Illegally earned money.",nil,0.0,"item","black_money", "no"},
  ["stolen_credit"] = {"Credit Card Info","handwritten credit card information.",nil,0.01,"item","contract", "no"},
  ["weed"] = {"Fresh Weed", "", nil, 0.02,"item","marijuana", "no"},
  ["weed_processed"] = {"Weed", "Bagged and ready for selling.", nil, 0.01,"item","marijuana", "no"},
  ["upperR"] = {"Upper Receiver", "An upper receiver.",nil, 1.0,"item","WEAPON_PISTOL", "no"},
  ["lowerR"] = {"Lower Receiver", "A lower receiver.",nil, 1.0,"item","WEAPON_PISTOL", "no"},
  ["methpipe"] = {"Methpipe", "A methpipe.", nil, 0.1,"item","stone", "no"},
  --========================--
  --====Burgetshot Items====--
  --========================--
  ["burger_products"] = {"Burgershot products","For company use only.",nil,1.0,"item","stone", "no"},
  --===================--
  --====pizza Items====--
  --===================--
  ["pizza_products"] = {"Pizza by the Slice products","For company use only.",nil,1.0,"item","stone", "no"},
  --======================--
  --====GoPostal Items====--
  --======================--
  ["package"] = {"Package","A Package for delivery.",nil,5.0,"item","stone", "no"},
  --=============================--
  --====Drug Processing Items====--
  --=============================--
  ["demineralized_water"] = {"Demineralized water (1L)","",nil,1,"item","stone", "no"},
  ["hydrochloric_acid"] = {"Hydrochloric acid (1L)","",nil,1,"item","stone", "no"},
  ["cocaleaf"] = {"Coca Leaf", "Leaf of the infamous coca plant",nil, 0.02,"item","stone", "no"},
  ["diesel"] = {"Diesel", "A jerry can of diesel (1L)",nil, 1,"item","stone", "no"},
  ["baggies"] = {"Small baggies","Small Ziplock Baggies.",nil,0.1,"item","stone", "no"},
  ["methlab"] = {"Portable Methlab","Propane bottle, pipes, trays, tools...everything you need except the kitchen sink.",nil,10.0,"item","stone", "no"},
  ["acetone"] = {"Nail Polish Remover","A bottle of acetone based nail polish remover.",nil,0.1,"item","stone", "no"},
  ["lithium"] = {"Lithium Batteries","A pack of lithium batteries,..this is for your flashlight right?.",nil,0.1,"item","stone", "no"},
  --=================================--
  --====Hunting and Fishing Items====--
  --=================================--
  ["meat"] = {"Venison", "Raw venison",nil, 1,"item","stone", "no"},
  ["leather"] = {"Leather", "Deer hide",nil, 1,"item","stone", "no"},
  --=============================--
  --====Weapon Crafting Items====--
  --=============================--
  ["gbarrel"] = {"Gun Barrel", "A gun barrel.",nil, 0.75,"item","stone", "no"},
  ["stock"] = {"Gun Stock", "A wooden gun stock.",nil, 1.0,"item","stone", "no"},
  ["pistol_parts"] = {"Pistol Parts", "Use these parts to craft a pistol.", nil, 1.0,"item","stone", "no"},
  ["shotgun_parts"] = {"Shotgun Parts", "Use these parts to craft a shotgun.", nil, 1.0,"item","stone", "no"},
  ["smg_parts"] = {"SMG Parts", "Use these parts to craft an SMG.", nil, 1.0,"item","stone", "no"},
  ["rifle_parts"] = {"Rifle Parts", "Use these parts to craft a rifle.", nil, 1.0,"item","stone", "no"},
  ["screws"] = {"Screws", "Standard Stainless Steel Machine Screws.",nil, 0.25,"item","stone", "no"},
  ["wood"] = {"Wood", "Some nice, hard wood.",nil, 1,"item","stone", "no"},
  ["bolts"] = {"Bolts", "Standard Stainless Steel Bolts.",nil, 0.25,"item","stone", "no"},
  ["gunp"] = {"Gun Powder", "",nil, 0.5,"item","stone", "no"},
  ["pvc"] = {"PVC", "PVC pipes.",nil, 0.5,"item","stone", "no"},
  ["casing"] = {"Bullet Casing", "",nil,0.1,"item","stone", "no"},
  ["sniper_parts"] = {"Sniper Parts","",nil,1.0,"item","stone", "no"},
  ["autorp"] = {"Automatic Reviever Parts","",nil,1.0,"item","stone", "no"},
  ["gunbpt"] = {"Black Powder Trigger","",nil,0.5,"item","stone", "no"},
  ["lgbarrel"] = {"Long Gunbarrel","",nil,1.0,"item","stone", "no"},
  ["gunbpb"] = {"Black Powder Gunbarrel","",nil,1.0,"item","stone", "no"},
  ["mg_parts"] = {"LMG Parts","",nil,5.0,"item","stone", "no"},
  ["elect_parts"] = {"Electric Parts","",nil,1.5,"item","stone", "no"},
  --==================--
  --====Farm Items====--
  --==================--
  ["seed"] = {"Seed", "Some seeds for farming",nil, 0.5,"item","stone", "no"},
  ["fertilizer"] = {"Fertilizer", "A bag of fertilizer", nil, 2.5,"item","stone", "no"},
  ["bottle"] = {"Bottle", "glass bottle", nil, 0.1,"item","stone", "no"},
  ["crate"] = {"Crate", "A wooden crate for shipping", nil, 0.5,"item","stone", "no"},
  ["barrel"] = {"Barrel", "An empty barrel.", nil, 5.0,"item","stone", "no"},
  ["harvest"] = {"Farm Fresh Harvest", "A crate of freshly harvested crops", nil, 10.0,"item","stone", "no"},
  --===================--
  --====Other Items====--
  --===================--
  ["lighter"] = {"A Lighter","used to lighting things on fire.",nil,0.2,"item","stone", "no"},
  ["coffee"] = {"Coffee", "", nil, 0.2,"item","stone", "no"},
  ["boom_box"] = {"Boom Box", "An old style boom box.", nil, 2.0,"item","stone", "no"},
  ["sour"] = {"Sour Mix", "",nil, 0.5,"item","stone", "no"},
  --=====================--
  --====Special Items====--
  --=====================--

  --==|IMPORTANT|==--
  --Re-defined Stock Items with "Use" Options - Remove from there server defined locations or re-defind them where they are defined
  --Some "special" iTypes are triggered function, you need to disable other functions and redefind them here 
  --eg.. (medkits), Garage(repairKits), Business(dirty_money) --disable these and redefine then here as a Special iType,
  --all special itypes will be triggered in vRP2_Functions then sent to the appropiate Extension
  --This will need to be done for any custom special items in future Extensions as well

  ["money_binder"] = {"Money Binder", "Used to bind cash", nil, 0.00, "special", "cash", "yes"},
  ["repairkit"] = {"Repairkit", "", nil, 1.00, "special", "fixkit", "yes"},
  ["medkit"] = {"Med Kit", "", nil, 0.10, "special", "medikit", "yes"},
  ["money"] = {"Packed money", "Some Rolled Cash", nil, 0.00, "special", "cash", "yes"},
  ["lockpick"] = {"Lockpick", "Used to unlock vehicles", nil, 0.5, "special", "fixtool", "yes"},
  ["bandage"] = {"Bandages", "Used to heal minor wounds.", nil, 0.1, "special", "bandage", "yes"},
}
