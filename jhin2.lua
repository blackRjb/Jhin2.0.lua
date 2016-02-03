if GetObjectName(GetMyHero()) ~= "Jhin" then return end

require('Inspired')

local JhinMenu = MenuConfig("Jhin", "Jhin")

JhinMenu:Menu("Combo", "Combo")
JhinMenu.Combo:Boolean("Q", "Use Q", true)
JhinMenu.Combo:Boolean("W", "Use W", true)
JhinMenu.Combo:Boolean("E", "Use E", true)
JhinMenu.Combo:Slider("Mana", "If Mana % >", 30, 0, 75, 1)
JhinMenu.Combo:Key("Combo1", "Combo", string.byte(" "))

JhinMenu:Menu("Harass", "Harass")
JhinMenu.Harass:Boolean("Q", "Use Q", true)
JhinMenu.Harass:Boolean("W", "Use W", true)
JhinMenu.Harass:Slider("Mana", "if mana >", 30, 0, 75, 1)
JhinMenu.Harass:Key("Harass1", "Harass", string.byte("C"))

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

------Drawing range (Soon Dmg)
OnDraw(function(myHero)

local pos = GetOrigin(myHero)

if JhinMenu.Drawings.Q:Value() then 
 	DrawCircle(pos,550,1,25,GoS.Pink) 
end

if JhinMenu.Drawings.W:Value() then 
	DrawCircle(pos,3000,1,25,GoS.Blue) 
end

end)

----LOCAL MISC IGNITE

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

----LOCAL SPELL FUNCTION 
function CastE(unit)
  local EPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),750,999999,ERange,100,true,true)
   if EPred.Hitchance == 1 then
    CastSkillShot(_E,EPred.PredPos)
   end
end

function CastW(unit)
  local WPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),3000,999999,WRange,100,true,true)
     if WPred.HitChance == 1 then                
        CastSkillShot(_W,WPred.PredPos)
     end
end

 -----COMBO
OnTick(function(myHero)
	
Target= GetCurrentTarget()
 ignite()
 if iow:Mode == Combo then 
  if JhinMenu.Combo.Combo1:Value() then
 
   if CanUseSpell(myHero,_W) and ValidTarget(target, 3000) and JhinMenu.Combo.W:Value() then
   	CastW(Target)
   end
   
   if CanUseSpell(myHero,_E) and ValidTarget(target, 750) and JhinMenu.Combo.E:Value() then
  	CastE(Target)
   end
  
   if CanUseSpell(myHero,_Q) and ValidTarget(target, 550) and JhinMenu.Combo.Q:Value() then
        CastTargetSpell(target,_Q)
   end
  end
 end

 -----HARASS
if iow:Mode ==Harass then
 if JhinMenu.Harass.Harass1:Value() then
   
   if CanUseSpell(myHero,_Q) and ValidTarget(target, 550) and JhinMenu.Combo.Q:Value() then
     CastTargetSpell(target,_Q)
   end

   if CanUseSpell(myHero,_W) and ValidTarget(target, 3000) and JhinMenu.Combo.W:Value() then  
	CastW(Target)
   end

   if CanUseSpell(myHero,_E) and ValidTarget(target, 750) and JhinMenu.Combo.E:Value() then
	CastE(Target)
   end
 end
end
end)
 
 -----KSECURE--> soon
 

PrintChat(string.format("<font color='#1244EA'>Jhin:</font> <font color='#FFFFFF'> By BlackRjb Loaded, Have A Good Game ! </font>")) 
 
