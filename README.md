# Velocity Admin

Velocity Admin is an open sourced admin system designed for speed and minimalism. Key features include... 
- Auto completion 
- Easy external use. 
  
**This system is no longer being worked on** due to personal reasons. However, development is planned to resume in the future. Planned features include... 
- AI directed autocompletion (stores command usage throughout Roblox)
- Smart field detection (warns user if the argument for the command they are typing does not match the command argument)
- Bind commands to input
- Customizable command layouts & themes to each individual user
- Custom admin levels
- More player arguments (teams, user ID's)
- Usable in chat & as a menu
- Compressed into one folder

## Info

### Keybinds
- `\` to open/close UI
- `esc` to close UI
- `tab`/`return` to use autocompletion
- `up`/`down` to use different fields

### Player Arguments
- me
- all
- others
- [USERNAME]

### Definitions
- Player: Someone who is in the server.
- User: Anyone user on Roblox.

## Commands

### Fun: Commands that provide no competitive advantage.

1. `hat <player, accessoryid>` - Adds an accessory to the player with the given Roblox accessory ID.
2. `removehats <player>` - Removes all the accessories on the player.
3. `char <player> <user>` - Changes player's appearance to user's.
4. `name <player, name>` - Changes the player's name over their head.
5. `unname <player>` - Changes the player's name to their default name.

### Moderation: Commands for moderation and administrative purposes.

#### Character

6. `re <player>` - Respawns the player.
7. `invis <player>` - Makes the player invisible.
8. `vis <player>` - Makes the player visible.
9. `ff <player>` - Gives the player a forcefield.
10. `unff <player>` - Removes the player's forcefield.
11. `sword <player>` - Gives the player a sword.
12. `f3x <player>` - Gives the player f3x.
13. `unequipall <player>` - Unequipps the tools the player is holding.
14. `cleartools <player>` - Removes all the tools the player is holding or is in their backpack.
15. `freeze <player>` - Makes the player immovable.
16. `unfreeze <player>` - Makes the player movable.
17. `speed <player, number>` - Changes the player's walkspeed.
18. `jump <player>` - Makes the player jump.
19. `jumppower <player, number>` - Changes the player's jump power.
20. `heal <player, number>` - Heals the player's health by an amount.
21. `god <player>` - Sets the player's health to infinite.
22. `ungod <player>` - Sets the player's health to the previous health before being goded.
23. `health <player, number>` - Changes the player's health to an amount.
24. `maxhealth <player, number>` - Changes the player's max health to an amount.
25. `kill <player>` - Kills the player.
26. `damage <player, number>` - Damages the player by an amount.

#### Player

23. `kick <player, reason (optional)>` - Kicks the player from the game with a reason.
24. `ban <player, length, reason>` - Bans the player from the server for a duration with a reason.
25. `pban <player, length, reason` - Bans a player from all places for a duration.
26. `unban <player` - Unbans the player from all servers.
27. `age <player` - Returns the player's account age.
28. `id <player>` - Returns the player's user ID.
29. `isfriendswith <player, user>` - Checks if the player is friends with the user.
30. `isingroup <player, groupID>` - Checks if the player is in the group.
31. `rank <player, group ID` - Returns the player's rank & role in a group.

#### Game: Commands for controling the game.

32. `lock <text (optional)>` - Locks the server preventing incoming people from joining with a reason.
33. `unlock` - Unlocks the server so incoming people can join.
34. `shutdown <delay>` - Shuts down the server in a duration.~~
35. `brightness <number>` - Changes the game's brightness.
36. `time` - Changes the game's clock time.
37. `respawntime <duration>` - Changes the default respawn time for all players.
38. `defaultjumppower <number>` - Changes the default jump power.
39. `defaultspeed <number>` - Changes the default walk speed.
40. `defaultcharacterloads <bool>` - If true, characters won't load in.
41. `useemotes <bool>` - If true, new players won't be able to use emotes.