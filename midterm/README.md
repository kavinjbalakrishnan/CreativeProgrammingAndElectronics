# Pong (v2.0)

**Description**

This version of pong builds upon its pervious version. It takes advantage of the keyTyped() command to detect keyStrokes. This allows the user to pause the game and restart the game whenever they choose. Additionally, it also utilizes the sound library to add a "beep" everytime the user scores a point or succesfully hits the ball using the paddle. As with the previous version, the objective remains the same: prevent the ball from going off the screen using your paddle to score points. The speed of the ball increases over time and the color of the ball also changes to indicate the increased difficulty.

**Discoveries and Obstacles**

I had originally planned on implementing a 2 player pong with multiple balls by using various classes, however it was unsucessful. I tried to control the paddles using different keys, but they did not work as desired and ended up breaking the game. I eventually, gave up after hours of troubleshooting and debugging and returned to my original project.

I also discovered that the mp3 file I used did not load and caused the program to crash. However, when I converted it to a .wav audio file it ran succesfully.
