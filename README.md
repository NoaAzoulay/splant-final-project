# Splant
My Flutter application.

# Idea
the idea of this project was to make "plants'-lovers" lives easier.
although i'm a software developer, i really wanted to see how an actual planter would work, so with help of a hardware engeenir we built an actual planter with the following -
# Components:
1. planter with sensors of air-humidity, soil-humidity, uv
2. irrigation system
3. spraying system
4. all components are controlled by a server-controller which activate irrigation when the plant needs it. 
5. firebase firestore database with plants' optimal growing details and conditions

the app gives users the ability to add plants from an existing list to their planters,
then the user can see what are the optimal growing conditions for the specific plant he/she chose, and the current conditions as received from the sensors in the planter.
the user also can activate manually the irrigation and water spraying if he wishes to. 

# How it works?
the controller in the planter gets in json format the sensors measurements every few seconds.
it sends it to a local web server, and via the app, the json file is parsed and the relevant detailes are shown to the user. 
according to the values of soil-humidity that the plant needs, a threshold is defined, and when sensor's data meets the threshold, the irrigation is activated.
all communication between the app and the server is made by http requests.

# Technologics
1. controller - written in C with arduino
2. web server - HTML page, CSS, JavaScript
3. mobile app - written in Dart, using Flutter with android studio IDE



