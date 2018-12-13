# Star Fighter 68000

![Yet Another Platformer](https://github.com/aburguera/SFIGHTER/blob/master/SFIGHTER.PNG)

A very basic shooter videogame coded in MC68000 assembly language using the EASy68K environment. It is aimed at providing students an example of low complexity code.

* [Video of game](https://youtu.be/p0CgxJbSc5U)

## Executing the game

This game is coded in MC68000 asembly language but it relies on the graphics simulated by EASy68K. If you want to play the game you need the EASy68K assembler and simulator available at www.easy68k.com.

Please take into account that the provided code is NOT complete, since it is part of a lab assignment. The missing part is SYSTEM.X68. If you want to execute this game you first have to complete SYSTEM.X68. Instructions on how to complete it are within the file itself. The game will NOT run unless a properly programmed SYSTEM.X68 is coded.

Providing that you have properly coded SYSTEM.X68, you just have to open MAIN.X68 from EASy68K editor and run it.

## About the code

The program is simple enough to be fully understood from the code and the comments. Nevertheless, some basic explanation of the main aspects is provided next:

The aim of this program is to provide a fully functional example using the concept of agents. An agent is any element that is coded according to the following rules:

* It does not use global memory. All its variables are either in the stack or, if persistence is required, relative to A0.
* It has an initialization subroutine that must be called prior to any other action.
* It has an update subroutine that updates the agent logic.
* It has a plot subroutine that plots the agent.

Providing these conditions are met, the agent can simply be placed within an agent list (subroutine AGLADD). Placing it within the list forces a call to the agent initialization. Then, at every game loop, the agent list manager (AGENTLST) will call the update and the plot subroutines of all the agents whenever is necessary.

Also, an agent can remove any other agent (including himself) from the agent list. That is, it can "kill" other agents or himself. Moreover, an agent can also add new agents to the list. That is, it can "create" other agents.

For example, in the game, the player shots are agents defined in SHOT.X68 and are as follows:

* Their coordinates are initialized, modified and queried always relative to A0.
* The initialization simply copies the player coordinates into the shot coordinates, so that shots begin at the player location.
* The update does three tasks:
  * Increases the shot X coordinate, so that it moves rightwards.
  * Checks if the X coordinate is out of the screen. If so, the shot "kills" himself.
  * Checks if the shot collides with an enemy. If so, the enemy and the shot are "killed" and a set of explosion agents are "created".
* The plot simply plots two rectangles at the shot coordinates.

The agent structure relies on a very simple underlying Dynamic Memory Manager (DMM), defined in SYSTEM.X68. That is what makes it possible for an agent to be instantiated several times within the agent list. Since the DMM reserves memory for every new agent, and the agent list manager provides within A0 a pointer to this area every time it calls an agent subroutine, every agent has its own local memory space.

## Credits

Game design, graphics and coding:

* Antoni Burguera Burguera