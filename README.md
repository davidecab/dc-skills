# dc-skills
QBCore Metadata visualization with ox_lib, with levels and experience

Provides just visualization of a player's metadata.
Does not provide exports to increase metadata, you may just use the QBCore Function:

`local increase = 1`

`Player.Functions.SetMetaData('yourskill', (Player.Functions.GetMetaData('yourskill') or 0) + increase)`

Just put it in any server event where you want to give the player some exp.

Then use `/info` to open the menu and see all the skills you have configured in the config.
You also can adjust the amount of experience between levels.

Requires `ox_lib`
