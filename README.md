# Super Red Soul by Prownie
 
An extension of the default/red soul where you press Z to activate a shield which can deflect yellow bullets.
It's similar to the turquoise soul from "Scampton the great" with some differences.
When you initiate the shield, as long as it is active, your soul stays in place, but it's also invincible to any bullets. After the shield ends, there will be a cooldown period.
You can see it in action in this video: https://www.youtube.com/watch?v=DbsI_buUkCU

## SuperRedSoul
sheildTimer: How long the shield will last. Default value is 0.4.
sheildDelay: How long the cooldown period will last: Default value is 0.5.

## Enemybattler
If you want the enemy to be affected by a deflected attack, add in a collider for them in the init() function.

## DeflectableBullet
If you want to make a yellow/deflectable bullet, inherit this class. You can also change the way the bullet is deflected via overriding the onCounter(heart) function.

## Inspirations
The Mario & Luigi series: https://en.wikipedia.org/wiki/Mario_%26_Luigi
Sonic 3's insta-shield
Scampton the great (to a lesser extent than the two above)
