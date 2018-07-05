# MBRACE-mobile-App

The MBRACE mobile app system is a mobile platform for displaying and analyzing oyster data retrieved by the MBRACE water system.

## Building

Make sure you are running the latest version of Xcode.

In order to build, complete the following steps:

• Download/clone the project.
• Open up the project in xcode.
• Set up the charts framework (Details in the section below).
• Build and run the project.

## Charting

The MBRACE mobile app uses the `Charts` framework to display data via different graphs and charts.
The project currently uses the time based line graph to display graph information, but this `Charts` library can be maximized to give this platform the most it can get by graphing.

The `Charts` framework github can be found at https://github.com/danielgindi/Charts.

In order to successfully build the project, you must complete the following steps:

• Download/clone the github project at the link above.
• Find the `Charts.xcodeproj` inside of the project directory.
• Drag the `Charts.xcodeproj` under the `MBRACE-mobile-app` executable in xcode so that the file hierarchy looks similar to whats below:

```
MBRACE-mobile-app
|	Charts.xcodeproj
|	MBRACE-mobile-app
|	|	main.storyboard
|	|	...
|	Products
```

• Make sure the `Charts` framework is added to the list of Embedded Binaries and Linked Frameworks and Libraries.
• Done :)

## Contributing

In order to contribute, please clone the repository, make changes, and submit a pull request.
Your changes will be reviewed by the owner or one of the project administrators. 

Please do not polute the project with unnecessary code and information.

## Ownership

Kamal Ali
Technology Dept.
Jackson State University