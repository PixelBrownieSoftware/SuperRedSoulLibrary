local Basic, super = Class(Wave)
local yOff 
local perc
local originalPos
local pointsOrder ={3,5,4,1,2,5,3,2,4}

function Basic:onStart()
    self.time = 35
    self.attacker = self:getAttackers()[1]
    yOff = self.attacker.y
    perc = yOff
    originalPos = yOff
    local max_y = 300 
    local min_y = 90
    local disc = max_y - min_y
    local div = 5
    local index = 1
    self.timer:every(3, function()
        perc = 0
        local y_div = pointsOrder[index]
        yOff = min_y + ((y_div / 5) * disc)
        index = index + 1
        print(y_div)
        if index == table.getn(pointsOrder) then
            index = 1
        end
    end)
    self.timer:every(1.15, function()
        -- Our X position is offscreen, to the right
        local x = SCREEN_WIDTH - 20
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(Game.battle.arena.top + 30, Game.battle.arena.bottom - 30)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("deflectBullet", x, y, math.rad(180), 5.5)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
    end)
end

function Basic:onEnd()
    self.attacker.y = originalPos
end

function Basic:update()
    super:update(self)
    if self.attacker ~= nil then
        perc = perc + (DTMULT * 0.01)
        self.attacker.y = Utils.lerp(self.attacker.y, yOff, perc)
    end
end

return Basic