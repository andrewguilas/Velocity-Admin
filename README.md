# Velocity Admin

## Character

1. `char (player1, player2)` - Changes player 1's appearance to player 2 appearance who is or is not in the game.

2. `loadchar (player)` - Resets the character, backpack, playerGui.

3. `re (player)` - Respawns a player.

4. `invis (player)` - Makes a player invisible.

5. `uninvis/vis (player)` - Makes a player visible.

6. `ff (player)` - Gives a player a forcefield.

7. `unff (player)` - Removes a player's forcefield if any.

8. `hat (player, ID)` - Adds an accessory to the player.

9.  `name (player, Name)` - Changes the player's name over their head.

10. `unname (player)` - Changes the player's name to their default name.

11. `sword (player)` - Gives a player a sword.

12. `unequip (player)` - Unequipps the tools the player is holding if any.

## Humanoid

13. `freeze/lock (player)` - Sets the player's walkspeed and jump power to 0.

14. `unfreeze/unlock (player)` - Sets the player's walkspeed and jump power to their previous stats before being frozen.

15. **[LIVE]** `speed (player, number)` - Changes a player's walkspeed.

16. **[LIVE]** `jump (player)` - Makes a player jump.

17. **[LIVE]** `jumppower (player, number)` - Changes a player's jump power.

18. **[LIVE]** `heal (player, number)` - Heals a player's health by an amount.

19. `god (player)` - Sets the player's health to infinite.

20. `ungod (player)` - Sets the player's health to the previous health before being goded.

21. **[LIVE]** `health (player, number)` - Changes a player's Health.

22. **[LIVE]** `maxhealth (player, number)` - Changes a player's max health.

23. **[LIVE]** `kill (player)` - Kills a player.

24. **[LIVE]** `damage (player, number)` - Damages a player.

## Player

25. **[LIVE]** `kick (player, reason)` - Kicks a player from the game.

26. `ban (player, length, reason)` - Bans a player from that specific place.

27. `pban (player, length, reason` - Bans a player from all places.

28. `age (player` - Returns the player's account age.

29. `id (player)` - Returns the player's user ID.

30. `isfriendwith (player1, player2)` - Checks if player 1 is friends with player 2.

31. `isingroup (player, groupID)` - Checks if the player is in a group.

32. `role (player, group ID)` - Returns the player's role in a group.

33. `rank (player, group ID` - Returns the player's rank in a group.

## Game

34. `m (text)` - Announces a message to the entire server.

35. `pm (player, text)` - Announces a message to a specific player.

36. **[LIVE]** `respawntime (duration)` - Changes the default respawn time for all Players.

37. **[LIVE]** `brightness (number)` - Changes the game's brightness.

38. **[LIVE]** `time` - Changes the game's clock time.

39. `defaultjumppower (number)` - Changes the default jump power when a player joins the game.

40. `defaultspeed (number)` - Changes the default walk speed when a player joins the game.

41. `defaultcharacterloads (number)` - If true, characters of players who join the game won't load in.

42. `useemotes (bool)` - If true, new players won't be able to use emotes.