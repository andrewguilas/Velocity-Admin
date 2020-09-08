# Table of Contents

[https://github.com/Vex87/Velocity-Admin/blob/master/Commands.md#Fun](Fun)
- [https://github.com/Vex87/Velocity-Admin/blob/master/Commands.md##Hat](Hat)
- [https://github.com/Vex87/Velocity-Admin/blob/master/Commands.md##Removehats](Removehats)
- [https://github.com/Vex87/Velocity-Admin/blob/master/Commands.md##Char](Char)
- [https://github.com/Vex87/Velocity-Admin/blob/master/Commands.md##Name](Name)
- [https://github.com/Vex87/Velocity-Admin/blob/master/Commands.md##Unname](Unname)

# Fun

## Hat

### Description
Fun command. Adds an accessory to the player with the given Roblox accessory ID.

### Parameters

| Name | Type | Default | Description |
| - | - | - | - |
| Player | String | | The player you want to give the accessory to |
| ID | Number | | The Roblox ID of the accessory.  |

### Responses

| Name | Type | Description | Solution |
| - | - | - | - |
|  Player argument Missing | Error  | There is nothing listed for the player argument  | Insert the player's name  | 
| ID argument Missing | Error | There is nothing listed for the ID argument | Insert the Roblox asset ID |
| `Player` is not a valid player | Error | Could not locate the specified player | Insert a valid player name |
| `Player`'s character does not exist | Error | The player's character could not be located | Check if the player's character has loaded in |
| Error Retrieving Asset | Error | The accesorry could not be located or retrieved | Insert a valid Roblox asset ID |
| `Player` was given accessory `ID` | Success | The accessory was given to the player |

## Removehats

### Description
Removes all the accessories on the player.

### Parameters

| Name | Type | Default | Description |
| - | - | - | - |
| Player | String | | The player you want to remove all the accessories of |

### Responses

| Name | Type | Description | Solution |
| - | - | - | - |
|  Player argument Missing | Error  | There is nothing listed for the player argument  | Insert the player's name  | 
| `Player` is not a valid player | Error | Could not locate the specified player | Insert a valid player name |
| `Player`'s character does not exist | Error | The player's character could not be located | Check if the player's character has loaded in |
| Removed the follow accessories from `Player`... `Accessories` | Success | Lists the accessories that were removed from the player |
| No accessories detected for `Player` | Success | No accesories were detected onthe player |

## Char

### Description
Changes player's appearance to user's.

### Parameters

| Name | Type | Default | Description |
| - | - | - | - |
| Player | String | | The player which will have their character changed |
| User | String/Number | | The username or user ID of the user player's character will be turned into |

### Responses

| Name | Type | Description | Solution |
| - | - | - | - |
|  Player argument Missing | Error  | There is nothing listed for the player argument  | Insert the player's name  | 
|  User argument Missing | Error  | There is nothing listed for the user argument  | Insert the username or user ID  | 
|  Error finding username of `UserId` | Error  | Could not get the username of the User ID provided  | Insert a valid user ID  | 
|  Error finding UserId of `username` | Error  | Could not get the user ID of the username provided  | Insert a valid username  | 
|  User is not a valid argument type | Error  | The type of argument for user is not a support type  | Insert a username or user ID  | 
| ID argument Missing | Error | There is nothing listed for the ID argument | Insert the Roblox asset ID |
| `Player` is not a valid player | Error | Could not locate the specified player | Insert a valid player name |
| `Player`'s character was changed to `Username` (UserId: `UserId`)  | Success | The player's character was changed to user |

## Name

### Description
Changes the player's name over their head.

### Parameters

| Name | Type | Default | Description |
| - | - | - | - |
| Player | String | | The player you want to change the name of. |
| ID | Number | "" | The chosen name (no word limit). If blank, the player's name will be set to their default username. (Optional) |

### Responses

| Name | Type | Description | Solution |
| - | - | - | - |
|  Player argument Missing | Error  | There is nothing listed for the player argument  | Insert the player's name  | 
|  Could not filter name | Error  | There was an error requesting Roblox to filter the text  | Try again or insert in appropriate text | 
| `Player` is not a valid player | Error | Could not locate the specified player | Insert a valid player name |
| `Player`'s character does not exist | Error | The player's character could not be located | Check if the player's character has loaded in |
| `Player`'s name was changed to `Name` | Success | The player's name was changed | 
| `Player`'s custom name was removed. Now using the player name | Success | The player's name was set to their default username |

## Unname

### Description
Changes the player's name to their default name.

### Parameters

| Name | Type | Default | Description |
| - | - | - | - |
| Player | String | | The player you want to reset the name of. |

### Responses

| Name | Type | Description | Solution |
| - | - | - | - |
|  Player argument Missing | Error  | There is nothing listed for the player argument  | Insert the player's name  | 
| `Player` is not a valid player | Error | Could not locate the specified player | Insert a valid player name |
| `Player`'s character does not exist | Error | The player's character could not be located | Check if the player's character has loaded in |
| `Player`'s custom name was removed. Now using the player name | Success | The player's name was set to their default username |