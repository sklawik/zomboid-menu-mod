```important info before using and looking at this```
Project Zomboid doesn't have any official complete documentation, no templates and each game update something from Lua api breaks.

To have complete control over development you need to recompile the game code and see Java source code to solve future problems.

You can use this repo as a template for a B42 mod. Please do not expect this to have enough logic for you to understand what is going on, you can edit lua files and see what happens and learn that way.

This repo attempts to change main menu background to famous Rick Grimes from The Walking Dead. It should work on Build 42.

Recommendations:
If you get an error you may see black screen, no dev console will work and you are forced to close the game.
If you are on linux or using Windows Subsystem for Linux, or MacOS or just anything unix-like try to watch the logs folder for errors:

```bash
watch -n 1 cat ~/Zomboid/console.txt
```