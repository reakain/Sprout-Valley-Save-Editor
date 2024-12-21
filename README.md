# Sprout-Valley-Save-Editor
I just wanted to be lazy about experience gain.

Made with Godot 3.5 LTS, and based on the [Itch.io version of Sprout Valley](https://zefrost.itch.io/sprout-valley). I used the version released in December 2023, and cannot guarantee functionality with more recent versions. Primarily, I don't know how the item database might have changed as new items have been introduced, which changes the structure of the save file. I also cannot guarantee functionality with the Steam version of the game.

The latest version of the compiled save editor can be found in the [releases](https://github.com/reakain/Sprout-Valley-Save-Editor/releases).

Current version will let you load your save file, save it to plain text, or edit and re-encrypt and save it back to it's original spot. It *should* open the file selector directly into your Sprout Valley save file location. If it does not for some reason, you can manually navigate to the save file location:

On Windows: %APPDATA%\Godot\app_userdata\Sprout Valley

On GNU/Linux: $HOME/.godot/app_userdata/Sprout Valley

Experience level up values are as shown below. Should set your experience to just below these thresholds and then level up in game:
 - 1 star: 200
 - 2 star: 600
 - 3 star: 1200 
 - 4 star: 2000
 - 5 star: 3000

The save editor also allows for:
 - Add items to your inventory or storage (use the item drop down selectors)
 - Change the quantity of a specific item
 - Remove money (it doesn't add money for... reasons??)

When developing this, I used [GDRE](https://github.com/bruvzg/gdsdecomp) to decompile Sprout Valley and get the encription key for the save file. It was found in res/src/Utils/SaveState.gd so if newer versions of the game change the passphrase, that's a method to find it.