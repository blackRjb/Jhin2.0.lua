if GetObjectName(GetMyHero()) ~= "Jhin" then return end

require('Inspired')
require('DeftLib')

local JhinMenu = MenuConfig("Jhin", "Jhin")

JhinMenu:Menu("Combo", "Combo")
JhinMenu.Combo:Boolean("Q", "Use Q", true)
JhinMenu.Combo:Boolean("W", "Use W", true)
JhinMenu.Combo:Boolean("E", "Use E", true)
JhinMenu.Combo:Slider("Mana", "If Mana % >", 30, 0, 75, 1)

JhinMenu:Menu("Harass", "Harass")
JhinMenu.Harass:Boolean("Q", "Use Q", true)
JhinMenu.Harass:Boolean("W", "Use W", true)
JhinMenu.Harass:Slider("Mana", "if mana >", 30, 0, 75, 1)

JhinMenu:Menu("Ksecure", "Ksecure")
JhinMenu.Ksecure:Boolean("Q", "Use Q", true)
JhinMenu.Ksecure:Boolean("W", "Use W", true)
JhinMenu.Ksecure:Boolean("E", "Use E", false)

JhinMenu:Menu("Drawings", "Drawings")
JhinMenu.Drawings:Boolean("Q", "Draw Q Range", true)
JhinMenu.Drawings:Boolean("W", "Draw W Range", true)
JhinMenu.Drawings:Boolean("E", "Draw E Range", false)
JhinMenu.Drawings:Boolean("R", "Draw R Range", true)
JhinMenu.Drawings:Boolean("DrawDmg", "Draw Damage", true)

if Ignite ~= nil then
JhinMenu:Menu("Misc", "Misc")
JhinMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true) 
JhinMenu.Misc:Boolean("AutoHeal", "Auto Heal", true)
end

------Drawing range and damage
OnDraw(function(myHero)
local pos = GetOrigin(myHero)

if JhinMenu.Drawings.Q:Value() then 
 DrawCircle(pos,1150,1,25,GoS.Pink) 
end

if JhinMenu.Drawings.W:Value() then 
 DrawCircle(pos,1000,1,25,GoS.Blue) 
end

if JhinMenu.Drawings.R:Value() then 
 DrawCircle(pos,1450,1,25,GoS.Green) 
end

if JhinMenu.Drawings.DrawDmg:Value() then
local target = GetCurrentTarget()
	if CanUseSpell("Q")== READY then 
	  DrawDmgOverHpBar(target,GetCurrentHP(target),DPS,0,0xff00ff00)
	end
	if CanUseSpell("W")== READY then
	  DrawDmgOverHpBar(target,GetCurrentHP(target),DPS,0,0xff00ff00)
	end
	if CanUseSpell("E")== READY then
	  DrawDmgOverHpBar(target,GetCurrentHP(target),DPS,0,0xff00ff00)
	end
        if CanUseSpell("R")== READY then
          DrawDmgOverHpBar(target,GetCurrentHP(target),DPS,0,0xff00ff00)
        end
end

end)

----MISC IGNITE

for i,enemy in pairs(GetEnemyHeroes()) do
   	
        if Ignite and JhinMenu.Misc.AutoIgnite:Value() then
          if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
        end

----->Auto Heal Soon
 -----COMBO
OnTick(function(myHero)
Target= GetCurrentTarget()
local function combo
  local function CastW(unit)
	local Pred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),3000,999999,WRange,100,true,true)
     if WPred.HitChance == 1 then                
        CastSkillShot(_W,WPred.PredPos)
    end
  end

local function CastE(unit)
	local Pred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),750,999999,ERange,100,true,true)
   if EPred.Hitchance == 1 then
   	CastSkillShot(_E,EPred.PredPos)
   end
  end

   if IsReady(_Q) and QReady and ValidTarget(target, 550) and JhinMenu.Combo.Q:Value() then
        CastTargetSpell(target,_Q)
   end


 -----HARASS
local function Harass

local target = GetCurrentTarget
 
   if IsReady(_Q) and QReady and ValidTarget(target, 550) and JhinMenu.Combo.Q:Value() then
     CastTargetSpell(target,_Q)
   end

   if IsReady(_W) and WReady and ValidTarget(target, 3000) and JhinMenu.Combo.W:Value() and WPred.HitChance == 1 then  
	CastSkillShot(_W,WPred.PredPos)
   end

   if IsReady(_E) and EReady and ValidTarget(target, 750) and JhinMenu.Combo.W:Value() and  EPred.HitChance == 1 then
	CastSkillShot(_E,EPred.PredPos)
   end


end)
 
 -----KSECURE--> soon
 

PrintChat(string.format("<font color='#1244EA'>Jhin:</font> <font color='#FFFFFF'> By BlackRjb Loaded, Have A Good Game ! </font>")) 
 
