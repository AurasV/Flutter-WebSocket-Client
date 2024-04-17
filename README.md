# Flutter WebSocket Client for Door

A Flutter App made for communicating with a websocket server to get info for when a door and light controlled by a raspberry pi

**It will tell / show when:**

Door Opens -> Text Only

Door Closes -> Text Only

Light On -> Text and Background Color Change

Light Off -> Text and Background Color Change

# Made for: 

# Info

Flutter Version -> Flutter 3.19.5

Tools -> Dart 3.3.3 • DevTools 2.31.1

Framework -> Revision 300451adae

Engine -> Revision e76c956498

# Testing

1) Download Windows or Android compiled version from [Releases](https://github.com/AurasV/Flutter-WebSocket-Client-for-Door/releases)
2) Download Test Server from the [Repository](https://github.com/AurasV/Python-WebSocket-Server-for-Door) -> main.py
3) Run main.py (it will use port 8000)
4) Run the Flutter Application
5) **IF** you're running it on the same machine the app should now be cycling through the states (Door Open / Closed, Light On / Off) 
6) **IF** you're running it on a different machine, make sure they're on the same network and use the settings button at the top right of the flutter app to change the IP you try to connect to the IPv4 address of the machine running the server (on windows you can get it by running ``ipconfig`` in the command prompt and searching for "IPv4 Address" on the currently used network adapter, on Linux you can get it by running ``ifconfig`` in the terminal and searching for "inet" on the currently used network adapter). Now the app should be cycling through the states (Door Open / Closed, Light On / Off)

# Making your own WebSocket Server to use the App with

The App only listens to json data coming from the server

It searches for the "command" part of the json (ignoring everything else) and depending on what it is, it does different things:

- If the command is "push" -> it will take it as the door opening / closing
- If the command is "pull" -> it will take it as the light turning on / off

# Tested On / With
Tested on (and working) on -> Windows 10, Android (Nothing Phone (2) running Nothing OS 2.5.3 -> Android 14)

Tested on (and not working) on -> Edge, Chrome, Web Server

Tested with [Python WebSocket Server](https://github.com/AurasV/Python-WebSocket-Server-for-Door)

# TO DO:

Test on iOS

Add info in the made for section

Maybe add some icons showing the current status (lightbulb and door)

Give the user the option to change the port used

Make separate Windows / Linux / Same machine / Different Machines instructions
