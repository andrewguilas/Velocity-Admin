# Velocity Admin

## Character

1. `char (player1, player2)` - Changes player 1's appearance to any user on Roblox: player 2.

2. `re/loadchar (player)` - Respawns the player & resets the character, backpack, and playerGui.

3. `invis (player)` - Makes a player invisible.

4. `vis (player)` - Makes a player visible.

1. `ff (player)` - Gives a player a forcefield.

2. `unff (player)` - Removes a player's forcefield if any.

3. `hat (player, ID)` - Adds an accessory to the player.

4. `removehats (player)` - Removes all the accessory on the player.

5.  `name (player, Name)` - Changes the player's name over their head.

6.  `unname (player)` - Changes the player's name to their default name.

7.  `sword (player)` - Gives the player a sword.

8.  `f3x (player)` - Gives the player building tools.

9.  **[IN PROGRESS]** `unequip (player)` - Unequipps the tools the player is holding if any.

## Humanoid

13. **[TO DO]** `freeze/lock (player)` - Sets the player's walkspeed and jump power to 0.

14. **[TO DO]** `unfreeze/unlock (player)` - Sets the player's walkspeed and jump power to their previous stats before being frozen.

15. `speed (player, number)` - Changes a player's walkspeed.

16. `jump (player)` - Makes a player jump.

17. `jumppower (player, number)` - Changes a player's jump power.

18. `heal (player, number)` - Heals a player's health by an amount.

19. **[TO DO]** `god (player)` - Sets the player's health to infinite.

20. **[TO DO]** `ungod (player)` - Sets the player's health to the previous health before being goded.

21. `health (player, number)` - Changes a player's Health.

22. `maxhealth (player, number)` - Changes a player's max health.

23. `kill (player)` - Kills a player.

24. `damage (player, number)` - Damages a player.

## Player

25. `kick (player, reason)` - Kicks a player from the game.

26. **[TO DO]** `ban (player, length, reason)` - Bans a player from that specific place.

27. **[TO DO]** `pban (player, length, reason` - Bans a player from all places.

28. `age (player` - Returns the player's account age.

29. `id (player)` - Returns the player's user ID.

30. `isfriendwith (player1, player2)` - Checks if player 1 is friends with player 2.

31. `isingroup (player, groupID)` - Checks if the player is in a group.

32. `rank (player, group ID` - Returns the player's rank & role in a group.

## Game

34. **[TO DO]** `m (text)` - Announces a message to the entire server.

35. **[TO DO]** `pm (player, text)` - Announces a message to a specific player.

36. `respawntime (duration)` - Changes the default respawn time for all Players.

37. `brightness (number)` - Changes the game's brightness.

38. `time` - Changes the game's clock time.

39. `defaultjumppower (number)` - Changes the default jump power.

40. `defaultspeed (number)` - Changes the default walk speed.

41. `defaultcharacterloads (bool)` - If true, characters won't load in.

42. `useemotes (bool)` - If true, new players won't be able to use emotes.