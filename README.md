# Rhea-Phoebe-CDI-Alphebetizer

I created this script to help manage CDI file sorting for the Rhea and Phoebe drive emulator boards for the Sega Saturn.
The Rhea/Phoebe product works by inserting an SD card with each game separated into numbered folders, and pressing a PCB-mounted button to cycle through the games.
I found it frustrating creating the folder structure, and then placing each image file into them.
What was even more frustrating than that was adding or removing games later without knowing where to add them to keep them alphabetized, as well as having to shift the games into the next folder.

To use this script:
1. Dump all of your Sega Saturn CDIs onto the SD card you plan to use (you can keep them in whatever folder structure you prefer, the script recursively grabs the files and moves them to a tmp directory)
2. Run the script
3. All of your files will be placed into a /tmp folder at the root and all other folder structure is removed
4. Remove duplicate files, rename your files, if needed. When you sort the games by name in Explorer, this is how they will be sorted.
5. Press Enter to finish the script, and your files will be sorted and a text file containing the list of the games and what folder they're contained in will be created in the root of the SD card (named 'FullGameListing.txt')

Concerns:
1. It is MANDATORY to enable Powershell scripts to be run on your PC, so open a Powershell prompt as Administrator and enter:
  set-executionpolicy remotesigned
2. If you have your games named the same filename (ex. disc.cdi) and only uniquely identified by the folder, you will run into issues. This script works assuming you have named the file itself as the game.
3. Having an open Windows Explorer window viewing the SD card can sometimes cause the script to lock the computer when the drive is being accessed, this is mitigated by closing all open Explorer windows that are accessing it. Warnings are provided during runtime.
4. If you wish to use RMENU or other GUI menu alternatives that require being located in the first folder to function, then create a file called "00001.cdi" on your SD card, run through the script, and then replace the file with your RMENU image by following the appropriate instructions.
