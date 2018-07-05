# MBRACE-mobile-App

The MBRACE mobile app system is a mobile platform for displaying and analyzing oyster data retrieved by the MBRACE water system.

## Building

Make sure you are running the latest version of Xcode.

In order to build, complete the following steps:

1. Download/clone the project.
2. Open up the project in xcode.
3. Set up the charts framework (Details in the section below).
4. Build and run the project.

## Charting

The MBRACE mobile app uses the `Charts` framework to display data via different graphs and charts.
The project currently uses the time based line graph to display graph information, but this `Charts` library can be maximized to give this platform the most it can get by graphing.

The `Charts` framework github can be found at https://github.com/danielgindi/Charts.

In order to successfully build the project, you must complete the following steps:

1. Download/clone the github project at the link above.
2. Find the `Charts.xcodeproj` inside of the project directory.
3. Drag the `Charts.xcodeproj` under the `MBRACE-mobile-app` executable in xcode so that the file hierarchy looks similar to whats below:

```
MBRACE-mobile-app
|	Charts.xcodeproj
|	MBRACE-mobile-app
|	|	main.storyboard
|	|	...
|	Products
```

4. Make sure the `Charts` framework is added to the list of Embedded Binaries and Linked Frameworks and Libraries.
5. Done :)

## Contributing

In order to contribute, please clone the repository, make changes, and submit a pull request.
Your changes will be reviewed by the owner or one of the project administrators. 

Please do not polute the project with unnecessary code and information.

## Ownership

Kamal Ali
- Technology Dept.
- Jackson State University