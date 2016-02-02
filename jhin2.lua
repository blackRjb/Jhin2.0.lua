if GetObjectName(GetMyHero()) ~= "Jhin" then return end

require('Inspired')

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

if Ignite ~= nil then
JhinMenu:Menu("Misc", "Misc")
JhinMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true) 
JhinMenu.Misc:Boolean("AutoHeal", "Auto Heal", true)
end

------Drawing range and damage
OnDraw(function(myHero)
local pos = GetOrigin(myHero)

if JhinMenu.Drawings.Q:Value() then 
 	DrawCircle(pos,590,1,25,GoS.Pink) 
end

if JhinMenu.Drawings.W:Value() then 
	DrawCircle(pos,2700,1,25,GoS.Blue) 
end

end)

----MISC IGNITE

for i,enemy in pairs(GetEnemyHeroes()) do
   	
        if Ignite and JhinMenu.Misc.AutoIgnite:Value() then
          if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
        end
end

----local function 
local function CastE()
	local Pred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),750,999999,ERange,100,true,true)
   if EPred.Hitchance == 1 then
   	CastSkillShot(_E,EPred.PredPos)
   end
end

local function CastW()
	local Pred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),3000,999999,WRange,100,true,true)
     if WPred.HitChance == 1 then                
        CastSkillShot(_W,WPred.PredPos)
     end
end

 -----COMBO
OnTick(function(myHero)
	
Target= GetCurrentTarget()
  
 if IOW:Mode() == "Combo" then
 
  if CanUseSpell(myHero,_W) and ValidTarget(target, 3000) and WPred.HitChance ==1 and JhinMenu.Combo.W:Value() then
  	CastSkillShot(_W,WPred.PredPos)
  end
  
  if CanUseSpell(myHero,_E) and ValidTarget(target, 750) and WPred.HitChance ==1 and JhinMenu.Combo.E:Value() then
  	CastSkillShot(_E,EPred.PredPos)
  end
  
  if CanUseSpell(myHero,_Q) and ValidTarget(target, 550) and JhinMenu.Combo.Q:Value() then
        CastTargetSpell(target,_Q)
  end
 end

 -----HARASS
 if IOW:Mode() == "Harass" then
   if CanUseSpell(myHero,_Q) and ValidTarget(target, 550) and JhinMenu.Combo.Q:Value() then
     CastTargetSpell(target,_Q)
   end

   if CanUseSpell(myHero,_W) and ValidTarget(target, 3000) and JhinMenu.Combo.W:Value() and WPred.HitChance == 1 then  
	CastSkillShot(_W,WPred.PredPos)
   end

   if CanUseSpell(myHero,_E) and ValidTarget(target, 750) and JhinMenu.Combo.E:Value() and  EPred.HitChance == 1 then
	CastSkillShot(_E,EPred.PredPos)
   end
 end

end)
 
 -----KSECURE--> soon
 

PrintChat(string.format("<font color='#1244EA'>Jhin:</font> <font color='#FFFFFF'> By BlackRjb Loaded, Have A Good Game ! </font>")) 
 
