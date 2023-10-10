local SuperRedSoul, super = Class(Soul)

local sheildOn = false
local canSheild = true
local sheildTimer = 0.4
local sheildDelay = 0.5

function SuperRedSoul:init(x, y)
    super:init(self, x, y)
end


function SuperRedSoul:onCollide(bullet)
    if sheildOn == false then
        bullet:onCollide(self)
    end
end

function endSheild()
    sheildOn = false
    canSheild = false
    Game.battle.timer:after(sheildDelay, function() canSheild = true end)
end

function SuperRedSoul:doMovement()
    super:doMovement(self)
    local speed = self.speed

    -- Do speed calculations here if required.

    if Input.down("confirm") and sheildOn == false and canSheild == true then 
        -- Do insta sheild
        sheildOn = true
        local shield
        self.inv_timer = sheildTimer
        shield = Game.battle:addChild(SuperRedSoulSheild(self.x, self.y, self.rotation, self))
        Assets.playSound("super_sheild")
        Game.battle.timer:after(sheildTimer, function() endSheild() end)
    end
end

function SuperRedSoul:update()
    if sheildOn == true then
        self.can_move = false
    else 
        self.can_move = true
    end


    super:update(self)
end

return SuperRedSoul