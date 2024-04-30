To run the program, open UTBandit.pde file and run the program. Click on the "How To Play Button" to view directions. Read the directions on the screen, click back to start the game.

The objective of UT bandit is to collect keys around a map of UT to “unlock” the UT Tower. Player must navigate through all the rooms, defeat all the enemies, and collect all 5 keys before getting access to the UT Tower. Once the UT Tower is accessed, the player wins the game.

Player navigation: 
1. Use WASD to move around the map 
2. To enter a room, navigate to the circle AND click on the circle 
3. Click to shoot enemies
4. After defeating all enemies, simply walk over the key that appears on the screen to collect it.
5. Once you have collected all the keys, walk over to the UT Tower and click on the circle to win the game.


FOR TESTING PURPOSES: 

In order to quickly see the win screen, navigate to the main file, UTBandit.pde.

At the top of the file, comment in the code under the comment "// DEBUGGING MODE", and comment out the code under "// REGULAR USER MODE".
In debugging mode, the user can essentially navigate to the UT Tower immediately to display win screen and replay screens.

To test the "Game Over" or losing screens/functionality, you may navigate to Player.pde and follow the same process to alter the player health. You may simply walk into a room and allow the enemies to kill you quickly.

If you would like to customize a game to test with different rooms active, here is the array breakdown:
boolean[] roomsCompleted = {false, false, false, false, false, false};
== {GDC, PMA, STADIUM, MOODY CENTER, PCL, UT TOWER};
False means a room has not been completed and a key has not been collected for that room. True means the opposite.
