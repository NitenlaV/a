local version = 0.1
-[[Sript created by iVatinj please don't modify this code without
my permission, and don't upload it on an other site, don't take 
the credits of this code ♥
]]-	

myHero = GetMyHero()

local ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 750, DAMAGE_PHYSICAL, false, true) -- A modif' au cas ou

function OnLoad()

	PrintChat("Welcome, this script is an alpha, bugs will be fixed asap")
	if (myHero.charName ~= "Alistar") then return end
	cap = Config:addParam --Modif' possibles
	Config = scriptConfig("Le script d'Alistar","Alistar")
	cap("drawCircle", "Afficher la portee du A", SCRIPT_PARAM_ONOFF, false)
	cap("drawCircle1", "Afficher la portee du Z", SCRIPT_PARAM_ONOFF,false)
	cap("printHP","Afficher la sante basse",SCRIPT_PARAM_ONOFF, true)
	cap("combo","Combo automatique",SCRIPT_PARAM_ONOFF,true)
	cap("insec","Flash combo",SCRIPT_PARAM_ONOFF, false)
	cap("autob","Back auto",SCRIPT_PARAM_ONOFF,false)
end

function vars()
	abilityLevel = 0 
	abilitySequence = {1,3,2,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}
	Qpret = (myHero:CanUseSpell(_Q) == READY)
	Wpret = (myHero:CanUseSpell(_W) == READY)
	Epret = (myHero:CanUseSpell(_E) == READY)
	Hpret = (Heal ~= nil and myHero:CanUseSpell(Heal) == READY)
	Fpret = (Flash ~= nil and myHero:CanUseSpell(Flash) == READY)
	B = (Back ~= nil and myHero:CanUseSpell(Back) == READY) --Peut etre pas le bon nom de spell
	h = (myHero.health)
end
function back()
if h < 350 and ts.target = nil then

	CastSpell(Back)

end
end
function OnTick()
--[[
Il peut subsister des bugs quant à l'utilisation Flash > Combo 
Le combo aussi peut bug
]]--
	ts:update()
	if Epret and h < 250 then
	
			CastSpell(_E)
			
	end
	
	if Hpret ~= nil and h < 250 then
	
		CastSpell(Heal, myHero)
	end
	if	(Config.autob) then
	
	back()
	
	end
	if (Config.combo) then 
	
	combo() 
	
	end
	
	if (Config.insec) and 
	
		if Fpret then 
		
		CastSpell(Flash,ts.target)
		
		combo()
	end
end
if (myHero.level > abiltyLevel) then

	abilityLevel=abilityLevel+1
     LevelSpell(getSpellSlot(abilitySequence[abilityLevel]))

end
end
function getSpellSlot(value)
    if value == 1 then return SPELL_1
    elseif value == 2 then return SPELL_2
    elseif value == 3 then return SPELL_3
    elseif value == 4 then return SPELL_4
    end
end
	
function combo()
		if  Qpret and (ts.target ~= nil) and Zpret and (myHero.mana > 170) and (myHero.health > 700) then
							CastSpell(_Z,ts.target.x,ts.target.y)
							CastSpell(_Q,ts.target)
		end
end				
function OnDraw()
	if (Config.printHP) then 
		if h < 375 then
			DrawText("Sante faible",20,1450,150,0xCC0000)
		end
	end
	if (Config.drawCircle) then
		DrawText("Portee du A", 20, 1450,250,0x9933FF)
		DrawCircle(myHero.x,myHero.y,myHero.z,365,0x9933FF)
	end
	if (Config.drawCircle1) then 
	DrawText("Portee du Z", 20, 1450,200,0x99CC00)
	DrawCircle(myHero.x,myHero.y,myHero.z,650,0x99CC00)
	end
end