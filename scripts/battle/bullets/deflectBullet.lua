local DeflectBullet, super = Class("DeflectableBullet" )

function DeflectBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super:init(self, x, y, "bullets/smallbullet")
    self.color = {1,1,0}
    self.collider = CircleCollider(self, 4, 4, 2)
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function DeflectBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super:update(self)
end

return DeflectBullet