if GetObjectName(GetMyHero()) ~= "Jhin" then return end

require('Inspired')

local JhinMenu = MenuConfig("Jhin", "Jhin")

JhinMenu:Menu("Combo", "Combo")
JhinMenu.Combo:Boolean("Q", "Use Q", true)
JhinMenu.Combo:Boolean("W", "Use W", true)
JhinMenu.Combo:Boolean("E", "Use E", true)
JhinMenu.Combo:Key("Combo1", "Combo", string.byte(" "))

JhinMenu:Menu("Harass", "Harass")
JhinMenu.Harass:Boolean("Q", "Use Q", true)
JhinMenu.Harass:Boolean("W", "Use W", true)
JhinMenu.Harass:Key("Harass1", "Harass", string.byte("C"))

JhinMenu:Menu("Ksecure", "Ksecure")
JhinMenu.Ksecure:Boolean("kQ", "Use Q", true)
JhinMenu.Ksecure:Boolean("kW", "Use W", true)
JhinMenu.Ksecure:Boolean("kE", "Use E", false)

JhinMenu:Menu("Drawings", "Drawings")
JhinMenu.Drawings:Boolean("Q", "Draw Q Range", true)
JhinMenu.Drawings:Boolean("W", "Draw W Range", true)

JhinMenu:Menu("Misc", "Misc")
JhinMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true) 
JhinMenu.Misc:Boolean("AutoHeal", "Auto Heal", false)

------Drawing Range Spell

OnDraw(function(myHero)
	
local pos = GetOrigin(myHero)

if JhinMenu.Drawings.Q:Value() then 
 	DrawCircle(pos,550,1,25,GoS.Pink) 
end

if JhinMenu.Drawings.W:Value() then 
	DrawCircle(pos,3000,1,25,GoS.Blue) 
end

end)

----MISC IGNITE

function ignite()
for i,enemy in pairs(GetEnemyHeroes()) do
    local Ignite = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
        if Ignite and JhinMenu.Misc.AutoIgnite:Value() then
          if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
        end
end
end


function CastE(unit)
  local EPred = GetPredictionForPlayer(StartVector3D, target, GetMoveSpeed(target), 1400,999999,750,100,true,true)
   if EPred.Hitchance == 1 then
    CastSkillShot(_E,EPred.PredPos)
   end
end

function CastW(unit)
  local WPred = GetPredictionForPlayer(startVector3D, target, GetMoveSpeed(target), 1400, 250, 3000, 220, false, true)
     if WPred.HitChance == 1 then                
        CastSkillShot(_W,WPred.PredPos)
     end
end

 -----COMBO
OnTick(function(myHero)

local Target = GetCurrentTarget()
local myHeroPos = GetOrigin(myHero)
local ignite
local Q = JhinMenu.Combo.Q:Value()
local W = JhinMenu.Combo.W:Value()
local E = JhinMenu.Combo.E:Value()
local HQ = JhinMenu.Harass.Q:Value()
local HW = JhinMenu.Harass.W:Value()
local HE = JhinMenu.Harass.E:Value()
local KsQ = JhinMenu.Ksecure.Q:Value()
local KsW = JhinMenu.Ksecure.W:Value()
local KsE = JhinMenu.Ksecure.E:Value()

if JhinMenu.Combo.Combo1:Value() then
 
 if Q and CanUseSpell(myHero,_Q) == READY and ValidTarget(target, 550) then
        CastTargetSpell(target,_Q)
 end
 
 if E and CanUseSpell(myHero,_E) == READY and ValidTarget(target, 750) then
  
  	CastE(Target)
 end
 
 if W and CanUseSpell(myHero,_W) and ValidTarget(target, 3000) then
   	CastW(Target)
 end
end

 -----HARASS
 if JhinMenu.Harass.Harass1:Value() then
   
  if HQ and CanUseSpell(myHero,_Q) == READY and ValidTarget(target, 550) then
     CastTargetSpell(target,_Q)
  end

  if HW and CanUseSpell(myHero,_W) == READY and ValidTarget(target, 3000) then  
	CastW(Target)
  end

  if HE and CanUseSpell(myHero,_E) == READY and ValidTarget(target, 750) then
	CastE(Target)
  end
 end

 
 -----KSECURE
 if KsQ and CanUseSpell(myHero,_Q) == READY and GetHp(target) < getdmg("Q", target) and ValidTarget(target, 550) then 
 	CastTargetSpell(target,_Q)
 end
 
 if KsW and CanUseSpell(myHero,_Q) == READY and GetHP(target) < getdmg("W", target) and ValidTarget, 3000) then
 	CastW(target)
 end
 
 if KsE and CanUseSpell(myHero,_E) == READY and GetHP(target) < getdmg("E", target) and ValidTarget, 750) then 
 	CastE(target)
 end
 
end)

PrintChat(string.format("<font color='#1244EA'>Jhin:</font> <font color='#FFFFFF'> By BlackRjb Loaded, Have A Good Game ! </font>")) 
 
