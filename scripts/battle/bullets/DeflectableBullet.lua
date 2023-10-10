local DeflectableBullet, super = Class(Bullet)

function DeflectableBullet:init(x, y, texture)
    super:init(self, x, y, texture)
    self.isDeflected = false
    self.damage = 15
end

function DeflectableBullet:onCounter(heart)
    self.isDeflected = true
    Assets.playSound("impact")
    local part = createParticle(self.x, self.y)
    self.physics.direction =Utils.angle(heart.x,heart.y ,self.x , self.y) 
    self.physics.speed = self.physics.speed * 2
end

function createParticle(x, y)
    local sprite = Sprite("player/parry_smack", x, y)
    sprite:setOrigin(0.5, 0.5)
    sprite:setScale(1.5)
    sprite:setAnimation(function(sprite, wait)
        for i = 1,4 do
            sprite:setScale(1.5 * (i/4))
            wait(0.02)
        end
        wait(1/30)
        sprite:remove()
    end)
    sprite.layer = BATTLE_LAYERS["above_bullets"]
    Game.battle:addChild(sprite)
    return sprite
end

function DeflectableBullet:update()
    super:update(self)
    local sx, sy = self:localToScreenPos()
    if (sx >  SCREEN_WIDTH + self.sprite.width)
    or (sx <             0 - self.sprite.width)
    or (sy > SCREEN_HEIGHT + self.sprite.width)
    or (sy <             0 - self.sprite.width)
    then
        self:remove()
    end
    if self.isDeflected == true then
        local enemies = Utils.filter(Game.stage:getObjects(EnemyBattler), function(e) return e end)
        for _,enemy in ipairs(enemies) do
            if self:collidesWith(enemy) then
                -- [[TODO: damage = everyone's attack stat divided by 3 added together, for now we're just gonna return the damage of the bullet]]
                local dmg = self.damage
                if enemy.health < self.damage then
                    dmg = enemy.health - 1
                end
                local result, result_big = enemy:hurt(dmg, false)
                Assets.playSound("damage")
                self:remove()
            end
        end
    end
end

return DeflectableBullet