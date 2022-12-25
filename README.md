# Neverwinter Nights Enhanced Edition - Memory Rod
Made this item to help me in replaying this old gem. This time, as a Witty Rapier Abjuration Pale Master Wizard (mediocre, I know). It's a bit tedious to radial cast my buffs every single time after a rest / dying. Read: I rest and die A LOT.

I'd like to have a usable device that memorize the spells I put into it and have my character casts them on item activation. It's a simple, quirky, and dumb tool. No complicated checks or anything.

Taught myself a bit of scripting and here goes, my first item mod. It's not a custom model item, no model download is necessary. It's using tag based scripting, so hopefully it won't conflict with other modules.

![mrod-1](https://user-images.githubusercontent.com/7840931/209477171-ec1864d5-4e4b-4477-b40b-adb4c193e564.png)
  
  
## Dynamic Description
The item's description is dynamically updated as it memorize the spells you cast into it. You can examine the item and see in the description the list of memorized spells. Note that all of these spells will be cast with your player character as target. Handle with care.
  
## Memory Reset
Upon pickup, it'll reset all of it's memorized spells. Clean state. So, when you need to have a new array of spells memorized, just drop and pick it up again.
  
![mrod-2](https://user-images.githubusercontent.com/7840931/209477314-1bc3de94-cdf1-4e86-ac7e-11c17dbe80b5.png)
  
## Memorize Spells
Simply cast your spells to it and the item will memorize them. Updating it's description so that it's easier for you to keep track on what are being memorized.
  
![mrod-3](https://user-images.githubusercontent.com/7840931/209477417-265ef01a-282d-4a6a-aae7-6e732cd83950.png)
  
## Activation
On activation, the item will queue the spell casting actions. The casting character need to be a valid caster for the action to queue. Means that you need to have the spells ready in your spellbook. It's not a free cast (not a cheat tool), it's also not a quick cast (dumb, right?).

## Installation
I've included 3 downloadables to choose from. Depending on how you want to get it into your system.
- override.zip - Place it into your override folder and call it via DM command.
- erf.zip - Import and unpack it in your toolset.
- erf-modules-override.zip - Load a custom module, grab the rod, and save character.
  
## Issues
Will fix and update them both in GitHub and NwN-Vault if you or me encounter one. Throw in a comment in Vault or Github issues and let me know what you think. Have fun!
