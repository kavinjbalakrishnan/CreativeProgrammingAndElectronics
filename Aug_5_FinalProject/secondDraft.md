# Project Proposal

**Description**

My final project will be a 2-player pong game that makes use of buttons and controls from the arduino to control the game pieces in Processing. The game is inspired by the traditional 2-player pong or air hockey. It would look very similar to the previous pong game I created before and would also make use of sound effects. I want each player to be able to control the paddles using buttons as well as have the ability to change either the speed of the ball or number of balls using the potentiometer.

**Components**

 - Buttons: control the movement of the paddle for each player
 - Potentiometer: control either the speed of the ball or the number of balls
 - Arduino buzzer or built in computer speaker: play sound effects
 
**Risks**
 
The riskiest part of my project is the fact that I have not been able to get a working version of the 2-player pong game, so I anticipate that there will be many challenges and obstacles that I will encounter. Additionally, I also have to find a way to convert the arduino inputs into csv values so I can pass these values to Processing over the serial port. 

**Plans**

I plan to divide up my Processing program into various classes for different components such as the ball and the paddles. This way, I can use object-specific methods to control these entities. Addtionally, I also plan to have a completely functional Processing program before I attempt the arduino implementation.
