local SoulSheild, super = Class(Object)

function SoulSheild:init(x, y, angle, heart)
    super:init(self, x, y)
    self.heart = heart
    self.layer = BATTLE_LAYERS["above_bullets"]
    self.rotation = angle
    self:setOrigin(0.5, 0.5)
    self.collider = CircleCollider(self,16,16, 16)
    self.damage = 1
    self.hit_bullets = {}
    self:setSprite("player/heart_sheild/heart_sh")
    self.sprite:setAnimation(function(sprite, wait)
        for i = 1,4 do
            sprite:setFrame(i)
            wait(0.05)
        end
        wait(1/30)
        self:remove()
    end)
end

function SoulSheild:update()
    super:update(self)
    self:setPosition(self.heart.x,self.heart.y)
    
    local bullets = Utils.filter(Game.stage:getObjects(DeflectBullet), function(v)
        if self.hit_bullets[v] then return false end
        return v.onCounter
    end)
    for _,bullet in ipairs(bullets) do
        if self:collidesWith(bullet) then
            self.hit_bullets[bullet] = true
            local result, result_big = bullet:onCounter(self, self.damage)
            
        end
    end
end
function SoulSheild:setSprite(sprite)
    if self.sprite then
        self.sprite:remove()
    end
    self.sprite = Sprite(sprite, 0, 0)
    self:addChild(self.sprite)
    self:setSize(self.sprite:getSize())
end

function SoulSheild:draw()
    super:draw(self)
    if DEBUG_RENDER then
        self.collider:draw(1,0,0)
    end
end

return SoulSheild