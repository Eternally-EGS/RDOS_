x = x - Speed
image_angle = Rot;
if (LifeTime > 0) { LifeTime -- }
if (LifeTime <= 0) { instance_destroy(self) LifeTime = 0 }