# ProgrammingExcercise

System Requirements:

•	Mac OSX
•	Xcode 6.0 and above
•	iPhone Simulator 4S and above

How to run the project?

If you want to run the app on a simulator

1.	Download the zip file from Github.
2.	Unzip the files.
3.	Go to the folder containing the file.
4.	Open ProgrammingExcercise.xcworksapce
5.	If you want to run the application using the simulator click on iPhone 6 simulator from the “Set the active Scheme” on the left hand corner of Xcode.
6.	The simulator will pop up and run the application.
7.	Turn on the location services as soon as the Simulator launches.  Go to Debug>Simulate Location>Choose any location (or click on the Simulate Location button on the Debug area bar).
8.	Click on allow for location services authorization.
(NOTE: the app will use a static latitude and longitude if you want to run the application on the simulator. You will still be asked to give authorization to the app to use the location services)

If you want to run the app on a device use the following instructions -

[NOTE: To use the app on the iOS Device go to the –(void)loadVenues method in MasterController.m and uncomment the lines which is mentioned in the method and comment the line above it which provides the static latLon value.]

1.	Download the zip file from Github.
2.	Unzip the files.
3.	Go to the folder containing the file.
4.	Open ProgrammingExcercise.xcworksapce
5.	If you want to run the application using the device click on the iOS Device attached to the Mac from the “Set the active Scheme” on the left hand corner of Xcode.
6.	The app will appear on your devices screen.
7.	Click on allow for location services authorization.

Approach to the project:

Foursquare has a webservice that allows the user to connect and retrieve a list of restaurants near the user’s current location. RestKit is an easy-to-use framework that prevents writing the webservice APIs like XML and JSON parsing.

I have used the CoreLocation and MapKit framework to locate the user’s current location and then display the location of the coffee shops near the user.

Features of the application:

1.	Contact the coffee shop by tapping on the number provided alongside the Coffee shop. (Cannot use call facility on simulator)
2.	By tapping on the row with the coffee shop’s name the user will be redirected to a map view where the user can see the location of he coffee shop on the map. 


