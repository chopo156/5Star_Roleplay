local cfg = {}

cfg.force_out_fee = 1000
cfg.repair = false
cfg.radius = 10

cfg.garage_types = {
["Personal"] = { --Add all personal garage cars
	_config = {map_entity = {"PoI", {blip_id = 357, blip_color = 26, marker_id = 1, scale = {4.0,4.0,1.0}, color={5, 229, 246,125}}}},
------------- COMPACTS -------------
    ["blista"] = {"Blista", ""},
    ["brioso"] = {"Brioso R/A", ""},
    ["dilettante"] = {"Dilettante", ""},
    ["issi2"] = {"Issi", ""},
    ["panto"] = {"Panto", ""},
    ["prairie"] = {"Prairie", ""},
    ["rhapsody"] = {"Rhapsody", ""},

------------- COUPE -------------
    ["cogcabrio"] = {"Cognoscenti Cabrio", ""},
    ["exemplar"] = {"Exemplar", ""},
    ["F620"] = {"F620", ""},
    ["felon"] = {"Felon", ""},
    ["felon2"] = {"Felon GT", ""},
    ["jackal"] = {"Jackal", ""},
    ["oracle"] = {"Oracle", ""},
    ["oracle2"] = {"Oracle XS", ""},
    ["sentinel"] = {"sentinel",  ""},
    ["sentinel2"] = {"Sentinel XS", ""},
    ["windsor"] = {"Windsor", ""},
    ["windsor2"] = {"Windsor Drop", ""},
    ["zion"] = {"Zion", ""},
    ["zion2"] = {"Zion Cabrio", ""},

------------- SPORT -------------
    ["ninef"] = {"9F", ""},
    ["ninef2"] = {"9F Cabrio", ""},
    ["alpha"] = {"Alpha", ""},
    ["banshee"] = {"Banshee", ""},
    ["bestiagts"] = {"Bestia GTS", ""},
    ["blista"] = {"Blista Compact", ""},
    ["buffalo"] = {"Buffalo", ""},
    ["buffalo2"] = {"Buffalo S", ""},
    ["carbonizzare"] = {"Carbonizzare", ""},
    ["comet2"] = {"Comet", ""},
    ["coquette"] = {"Coquette", ""},
    ["tampa2"] = {"Drift Tampa", ""},
    ["feltzer2"] = {"Feltzer", ""},
    ["furoregt"] = {"Furore GT", ""},
    ["fusilade"] = {"Fusilade", ""},
    ["jester"] = {"Jester", ""},
    ["jester2"] = {"Jester (Racecar)", ""},
    ["kuruma"] = {"Kuruma", ""},
    ["lynx"] = {"Lynx", ""},
    ["massacro"] = {"Massacro", ""},
    ["massacro2"] = {"Massacro (Racecar)", ""},
    ["omnis"] = {"Omnis", ""},
    ["penumbra"] = {"Penumbra", ""},
    ["rapidgt"] = {"Rapid GT", ""},
    ["rapidgt2"] = {"Rapid GT Convertible", ""},
    ["schafter3"] = {"Schafter V12", ""},
    ["sultan"] = {"Sultan", ""},
    ["surano"] = {"Surano", ""},
    ["tropos"] = {"Tropos", ""},
    ["verlierer2"] = {"Verkierer",""},

------------- SPORT CLASSIC -------------	
    ["casco"] = {"Casco", ""},
    ["coquette2"] = {"Coquette Classic", ""},
    ["jb700"] = {"JB 700", ""},
    ["pigalle"] = {"Pigalle", ""},
    ["stinger"] = {"Stinger", ""},
    ["stingergt"] = {"Stinger GT", ""},
    ["feltzer3"] = {"Stirling", ""},
    ["ztype"] = {"Z-Type",""},

------------- SUPER -------------
    ["adder"] = {"Adder", ""},
    ["banshee2"] = {"Banshee 900R", ""},
    ["bullet"] = {"Bullet", ""},
    ["cheetah"] = {"Cheetah", ""},
    ["entityxf"] = {"Entity XF", ""},
    ["sheava"] = {"ETR1", ""},
    ["fmj"] = {"FMJ", ""},
    ["infernus"] = {"Infernus", ""},
    ["osiris"] = {"Osiris", ""},
    ["le7b"] = {"RE-7B", ""},
    ["reaper"] = {"Reaper", ""},
    ["sultanrs"] = {"Sultan RS", ""},
    ["t20"] = {"T20", ""},
    ["turismor"] = {"Turismo R", ""},
    ["tyrus"] = {"Tyrus", ""},
    ["vacca"] = {"Vacca", ""},
    ["voltic"] = {"Voltic", ""},
    ["prototipo"] = {"X80 Proto", ""},
    ["zentorno"] = {"Zentorno",""},

------------- MUSCLE -------------
    ["blade"] = {"Blade", ""},
    ["buccaneer"] = {"Buccaneer", ""},
    ["Chino"] = {"Chino", ""},
    ["coquette3"] = {"Coquette BlackFin", ""},
    ["dominator"] = {"Dominator", ""},
    ["dukes"] = {"Dukes", ""},
    ["gauntlet"] = {"Gauntlet", ""},
    ["hotknife"] = {"Hotknife", ""},
    ["faction"] = {"Faction", ""},
    ["nightshade"] = {"Nightshade", ""},
    ["picador"] = {"Picador", ""},
    ["sabregt"] = {"Sabre Turbo", ""},
    ["tampa"] = {"Tampa", ""},
    ["virgo"] = {"Virgo", ""},
    ["vigero"] = {"Vigero", ""},
	
------------- OFF-ROAD -------------
    ["bifta"] = {"Bifta", ""},
    ["blazer"] = {"Blazer", ""},
    ["brawler"] = {"Brawler", ""},
    ["dubsta3"] = {"Bubsta 6x6", ""},
    ["dune"] = {"Dune Buggy", ""},
    ["rebel2"] = {"Rebel", ""},
    ["sandking"] = {"Sandking", ""},
    ["monster"] = {"The Liberator", ""},
    ["trophytruck"] = {"The Liberator", ""},

------------- SUV'S -------------
    ["baller"] = {"Baller", ""},
    ["cavalcade"] = {"Cavalcade", ""},
    ["granger"] = {"Grabger", ""},
    ["huntley"] = {"Huntley", ""},
    ["landstalker"] = {"Landstalker", ""},
    ["radi"] = {"Radius", ""},
    ["rocoto"] = {"Rocoto", ""},
    ["seminole"] = {"Seminole", ""},
    ["xls"] = {"XLS", ""},

------------- VANS -------------
    ["bison"] = {"Bison", ""},
    ["bobcatxl"] = {"Bobcat XL", ""},
    ["gburrito"] = {"Gang Burrito", ""},
    ["journey"] = {"Journey", ""},
    ["minivan"] = {"Minivan", ""},
    ["paradise"] = {"Paradise", ""},
    ["rumpo"] = {"Rumpo", ""},
    ["surfer"] = {"Surfer", ""},
    ["youga"] = {"Youga", ""},
	
------------- SEDANS -------------
    ["asea"] = {"Asea", ""},
    ["asterope"] = {"Asterope", ""},
    ["cognoscenti"] = {"Cognoscenti", ""},
    ["cognoscenti2"] = {"Cognoscenti(Armored)", ""},
    ["cognoscenti3"] = {"Cognoscenti 55", ""},
    ["zentorno"] = {"Cognoscenti 55(Armored)", ""},
    ["fugitive"] = {"Fugitive", ""},
    ["glendale"] = {"Glendale", ""},
    ["ingot"] = {"Ingot", ""},
    ["intruder"] = {"Intruder", ""},
    ["premier"] = {"Premier", ""},
    ["primo"] = {"Primo", ""},
    ["primo2"] = {"Primo Custom", ""},
    ["regina"] = {"Regina", ""},
    ["schafter2"] = {"Schafter", ""},
    ["stanier"] = {"Stanier", ""},
    ["stratum"] = {"Stratum", ""},
    ["stretch"] = {"Stretch", ""},
    ["superd"] = {"Super Diamond", ""},
    ["surge"] = {"Surge", ""},
    ["tailgater"] = {"Tailgater", ""},
    ["warrener"] = {"Warrener", ""},
    ["washington"] = {"Washington", ""},

------------- MOTORCYCLES -------------
    ["AKUMA"] = {"Akuma", ""},
    ["bagger"] = {"Bagger", ""},
    ["bati"] = {"Bati 801", ""},
    ["bati2"] = {"Bati 801RR", ""},
    ["bf400"] = {"BF400", ""},
    ["carbonrs"] = {"Carbon RS", ""},
    ["cliffhanger"] = {"Cliffhanger", ""},
    ["daemon"] = {"Daemon", ""},
    ["double"] = {"Double T", ""},
    ["enduro"] = {"Enduro", ""},
    ["faggio2"] = {"Faggio", ""},
    ["gargoyle"] = {"Gargoyle", ""},
    ["hakuchou"] = {"Hakuchou", ""},
    ["hexer"] = {"Hexer", ""},
    ["innovation"] = {"Innovation", ""},
    ["lectro"] = {"Lectro", ""},
    ["nemesis"] = {"Nemesis", ""},
    ["pcj"] = {"PCJ-600", ""},
    ["ruffian"] = {"Ruffian", ""},
    ["sanchez"] = {"Sanchez", ""},
    ["sovereign"] = {"Sovereign", ""},
    ["thrust"] = {"Thrust", ""},
    ["vader"] = {"Vader", ""},
    ["vindicator"] = {"Vindicator", ""},
	
------------- BICYCLES -------------
    ["tribike"] = {"Tribike", ""},
    ["BMX"] = {"BMX", ""},

------------- CUSTOM VEHICLE -------------
	--["NAME"] = {"NAME", PRICE, "OTHER"},
  }   
}  

-- {garage_type,x,y,z}
cfg.garages = {
  {"Personal",496.84872436523,-1702.2165527344,29.400569915771},           --9154 Home
  {"Personal",29.737417221069,6608.1298828125,32.449081420898},            --1061 Home
  {"Personal",21.527744293213,6662.0151367188,31.526556015015},            --1064 Right Home
  {"Personal",-16.541193008423,6646.1723632813,31.122365951538},           --1064 Left Home
  {"Personal",-1419.9432373047,-953.91223144531,7.1907114982605},          --8096 Home
  {"Personal",-52.544006347656,6621.3139648438,29.926094055176},           --1065 Home
  {"Personal",-121.88333892822,6559.2016601563,29.522762298584},           --1067 Home
  {"Personal",-223.41320800781,6433.9736328125,31.196853637695},           --1070 Home
  {"Personal",-234.38906860352,6421.5517578125,31.224311828613},           --1071 Right Home
  {"Personal",-264.26895141602,6405.7641601563,30.991609573364},           --1071 Left Home
  {"Personal",-359.65185546875,6328.9819335938,29.833236694336},           --1073 Home
  {"Personal",-394.5798034668,6311.4809570313,29.049533843994},            --1074 Home
  {"Personal",-432.11526489258,6262.2421875,30.316009521484},              --1075 Home
  {"Personal",-437.36111450195,6205.1220703125,29.577142715454},           --1076 Home
  {"Personal",-355.02105712891,6222.8623046875,31.48913192749},            --1043 Home
  {"Personal",1402.6547851563,1119.2086181641,114.83771514893},            --5024 Home
  {"Personal",353.79058837891,437.42718505859,146.67221069336},            --6078 Home
  {"Personal",131.85389709473,567.29656982422,183.6120300293},             --6084 Home
  {"Personal",-787.56195068359,-803.17205810547,20.619293212891},          --8081 Home
  {"Personal",-189.04183959961,502.77462768555,134.39668273926},           --6095 Home
  {"Personal",-555.23834228516,665.25360107422,145.05113220215},           --6107 Home
  {"Personal",-306.98831176758,-712.33026123047,28.506399154663},          --8067 Home
  {"Personal",-438.33377075195,-105.37420654297,39.358779907227},          --7230 Home
  {"Personal",-637.91369628906,56.808868408203,43.867321014404},           --7149 Home
  {"Personal",-632.65539550781,152.00862121582,57.249423980713},           --7068 Home
  {"Personal",-14.0709400177,-642.19812011719,35.724166870117},            --8026 Home
  {"Personal",-1526.9700927734,89.449264526367,56.571918487549},           --7042 Home (OWNERS) 
}

return cfg
