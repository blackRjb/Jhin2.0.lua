local myHero = GetMyHero()
if GetObjectName(GetMyHero()) ~= "Jhin" then return end
require('Inspired')

local JhinMenu = MenuConfig("Jhin", "Jhin")
JhinMenu:Menu("Combo", "Combo")
JhinMenu.Combo:Boolean("useQ", "Use Q", true)
JhinMenu.Combo:Boolean("useW", "Use W If Enemy Is Marked", true)
JhinMenu.Combo:Boolean("useE", "Use E", true)
JhinMenu.Combo:Key("Combo1", "Combo", string.byte(" "))

JhinMenu:Menu("Harass", "Harass")
JhinMenu.Harass:Boolean("HQ", "Use Q", true)
JhinMenu.Harass:Boolean("HW", "Use W", true)
JhinMenu.Harass:Key("Harass1", "Harass", string.byte("C"))

JhinMenu:Menu("Items", "Items")
JhinMenu.Items:Boolean("useCut", "Bilgewater Cutlass", true)
JhinMenu.Items:Boolean("useBork", "Blade of the Ruined King", true)
JhinMenu.Items:Boolean("useGhost", "Youmuu's Ghostblade", true)

JhinMenu:Menu("Ksecure", "Ksecure")
JhinMenu.Ksecure:Boolean("KsQ", "Use Q", true)
JhinMenu.Ksecure:Boolean("KsW", "Use W", true)

JhinMenu:Menu("Drawings", "Drawings")
JhinMenu.Drawings:Boolean("Q", "Draw Q Range", false)
JhinMenu.Drawings:Boolean("W", "Draw W Range", false)
JhinMenu.Drawings:Boolean("E", "Draw R Range", false)

JhinMenu:Menu("DrawingsD", "DrawingsD")
JhinMenu.DrawingsD:Boolean("Q", "Draw Q Damage", false)
JhinMenu.DrawingsD:Boolean("W", "Draw W Damage", false)
JhinMenu.DrawingsD:Boolean("E", "Draw E Damage", false)
JhinMenu.DrawingsD:Info("info" , "available soon")

JhinMenu:Menu("Misc", "Misc")
JhinMenu.Misc:Info("info", "Auto Heal Soon")
JhinMenu.Misc:Info("info2", "Auto Ignite Soon")

JhinMenu:Menu("Credits", "Credits")
JhinMenu.Credits:Info("info", "By BlackRjb")

------Drawing Range Spell
OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if JhinMenu.Drawings.Q:Value() then DrawCircle(pos,550,1,25,GoS.Pink) end
if JhinMenu.Drawings.W:Value() then DrawCircle(pos,3000,1,25,GoS.Blue) end
if JhinMenu.Drawings.E:Value() then DrawCircle(pos,750,1,25,GoS.Black) end
  end)
------BuffMark
local IsMarked = false

OnUpdateBuff(function(Object,buff) 
if buff.Name == "jhinespotteddebuff" then
IsMarked = true
else
	IsMarked = false
end
	end)
----START
OnTick(function(myHero)
local Target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
local target = GetCurrentTarget()
local CutBlade = GetItemSlot(myHero,3144)
local bork = GetItemSlot(myHero,3153)
local ghost = GetItemSlot(myHero,3142)
local useQ = JhinMenu.Combo.useQ:Value()
local useW = JhinMenu.Combo.useW:Value()
local useE = JhinMenu.Combo.useE:Value()
local HQ = JhinMenu.Harass.HQ:Value()
local HW = JhinMenu.Harass.HW:Value()
local KsQ = JhinMenu.Ksecure.KsQ:Value()
local KsW = JhinMenu.Ksecure.KsW:Value()
-----COMBO
if mainMenu.Combo.Combo1:Value() then

if CutBlade >= 1 and ValidTarget(target,550+50) and mainMenu.Items.useCut:Value() then
		if CanUseSpell(myHero,GetItemSlot(myHero,3144)) == READY then
			CastTargetSpell(target, GetItemSlot(myHero,3144))
		end	
	elseif bork >= 1 and ValidTarget(target,550+50) and mainMenu.Items.useBork:Value() then 
		if CanUseSpell(myHero,GetItemSlot(myHero,3153)) == READY then
			CastTargetSpell(target,GetItemSlot(myHero,3153))
		end
	end

	if ghost >= 1 and ValidTarget(target,GetRange(myHero)+50) and mainMenu.Items.useGhost:Value() then
		if CanUseSpell(myHero,GetItemSlot(myHero,3142)) == READY then
			CastSpell(GetItemSlot(myHero,3142))
		end
	end
if useQ and CanUseSpell(myHero,_Q) == READY and GetBuffData(myHero, "JhinPassiveReload") and ValidTarget(target, 550) then
CastTargetSpell(target, _Q)
end
if useW and CanUseSpell(myHero,_E) == READY and GetBuffData(myHero, "JhinPassiveReload") and ValidTarget(target, 750) then
CastTargetSpell(target, _E)
end
if mainMenu.Combo.useW:Value() then
if IsMarked == true and CanUseSpell(myHero,_W) == READY and ValidTarget(target, 3000) then
local WPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),1400,250,940,220,false,true)
		if WPred.HitChance == 1 then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	end
elseif CanUseSpell(myHero,_W) == READY and ValidTarget(target, 3000) then
local WPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),1400,250,940,220,false,true)
		if WPred.HitChance == 1 then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
end
end
------HARASS
if JhinMenu.Harass.Harass1:Value()

if HQ and CanUseSpell(myHero,_Q) == READY and GetBuffData(myHero, "JhinPassiveReload") and ValidTarget(target, 550) then
CastTargetSpell(target, _Q)
end
if HW and CanUseSpell(myHero,_E) == READY and GetBuffData(myHero, "JhinPassiveReload") and ValidTarget(target, 750) then
CastTargetSpell(target, _E)
end
if JhinMenu.Harass.HW:Value() then
if IsMarked == true and CanUseSpell(myHero,_W) == READY and ValidTarget(target, 3000) then
local WPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),1400,250,940,220,false,true)
		if WPred.HitChance == 1 then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	end
elseif CanUseSpell(myHero,_W) == READY and ValidTarget(target, 3000) then
local WPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),1400,250,940,220,false,true)
		if WPred.HitChance == 1 then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	end
end
-----KSECURE
if ksQ and CanUseSpell(myHero,_Q) == READY and GetHP(target) < getdmg("Q", target) and ValidTarget(target, 550) then
CastTargetSpell(target, _Q)
	end
if ksW and CanUseSpell(myHero,_W) == READY and GetHP(target) < getdmg("W", target) and ValidTarget(target, 3000) then
CastTargetSpell(target, _W)
	end
-----Auto Heal
-----Auto Ignite
-----Drawings Damage

PrintChat(string.format("<font color='#1244EA'>Jhin V1.0:</font> <font color='#FFFFFF'> By BlackRjb Loaded, Have A Good Game ! </font>")) 
 
