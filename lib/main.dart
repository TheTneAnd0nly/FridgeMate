
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

//*******************************************************************************
// Author: Tyler Scotti
// Project: FridgeMate Proto App
// Date: 6/24/24
// Version: 1.0
// Description: This is a prototype app for the FridgeMate Project Testing
//  barcode scanning and the virtual inventory system.
//*******************************************************************************


//Main Loop to run App
void main() {
  runApp(const MyApp());
}

// Define a stateless widget called MyApp as the root of the app
// Below is a constructor for MyApp taking an optional Key for widget identification
class MyApp extends StatelessWidget {
  const MyApp({Key? key});


  @override
  Widget build(BuildContext context) {      // Build method to create the widget's UI.
    return MaterialApp(                     // Return a MaterialApp widget to set up the app's structure and styling
      title: 'FridgeMate Demo App',         // Set the title of the app.
      theme: ThemeData(                     // Define the app's theme.
        primarySwatch: Colors.blue,         // Set the primary color swatch to blue.
      ),
      home: const MyHomePage(title: 'App Home Page'), // Set the initial screen to MyHomePage.
    );
  }
}

//*******************************************************************************
// Define a stateless widget for the home page.
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}); // Constructor, requiring a title.
  final String title;                                // Store the title of the home page.

  @override
  Widget build(BuildContext context) {              // Build method for the home page UI.
    return Scaffold(                                // Scaffold widgets provide basic app structure
      body: DefaultTabController(                   // DefaultTabController to manage tab navigation.
        length: 3,                                  // Set the number of tabs to 3.
        child: Scaffold(                            // Nested Scaffold for tab content.
          body: NestedScrollView(                   // Use a NestedScrollView for scrollable content with a header.
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { // Build the header slivers.
              return <Widget>[                      // Return a list of slivers.
                SliverAppBar(                       // Create a SliverAppBar for the main app bar.
                  expandedHeight: 300.0,            // Set the expanded height of the app bar.
                  floating: false,                  // Don't let the app bar float when scrolling.
                  pinned: true,                     // Pin the app bar to the top.
                  stretch: true,                    // Allow the app bar to stretch when over-scrolled.
                  flexibleSpace: FlexibleSpaceBar(  // Use a FlexibleSpaceBar for a collapsible app bar background.
                    centerTitle: true,              // Center the title in the FlexibleSpaceBar.
                    collapseMode: CollapseMode.parallax, // Use parallax effect for the background.
                    title: const Text("Welcome to FridgeMate", // Set the title text.
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                    background: Image.asset(        // Set the background image.
                      "C:/FridgeMateProject/FridgeMate/assets/Fridgephoto.png",
                      fit: BoxFit.cover,            // Cover the entire background with the image.
                    ),
                  ),
                ),
                SliverPersistentHeader(             // Create a SliverPersistentHeader for the tab bar.
                  delegate: _SliverAppBarDelegate(  // Use a custom delegate to manage the tab bar.
                    const TabBar(                   // Create the TabBar widget.
                      indicatorSize: TabBarIndicatorSize.label, // Set the indicator size to match the label.
                      labelColor: Colors.purple, // Set the label color to purple.
                      unselectedLabelColor: Colors.grey, // Set the unselected label color to grey.
                      tabs: _tabs,                  // Use the _tabs list to define the tabs.
                    ),
                  ),
                  pinned: true,                     // Pin the tab bar to the top.
                ),
              ];
            },
            body: TabBarView(                     // Create the TabBarView to display tab content.
              children: _tabs                     // Map the _tabs list to create tab content.
                  .map((e) => Center(             // Center the content of each tab.
                child: Text("${e.text}", textAlign: TextAlign.center), // Display the tab's text.
              ))
                  .toList(), // Convert the iterable to a list.
            ),
          ),
        ),),
      floatingActionButton: FloatingActionButton( // Add a floating action button.
        onPressed: () {                           // Define the action when the button is pressed.
          Navigator.push(                         // Navigate to the BarcodeScannerScreen.
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
          );
        },
        tooltip: 'Scan Barcode', // Set the tooltip for the button.
        child: const Icon(Icons.camera), // Set the icon for the button.
      ),
    );
  }
}
//*******************************************************************************
const _tabs = [ // Define a list of tabs.
  Tab(icon: Icon(Icons.home_rounded, color: Colors.black), text: "Home"),
  Tab(icon: Icon(Icons.kitchen_rounded, color: Colors.black), text: "Inventory"),
  Tab(icon: Icon(Icons.person, color: Colors.black), text: "Profile"),
];

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate { // Custom delegate for the tab bar.
  _SliverAppBarDelegate(this._tabBar); // Constructor, taking the TabBar as input.

  final TabBar _tabBar; // Store the TabBar.

  @override
  double get minExtent => _tabBar.preferredSize.height; // Minimum height of the tab bar.
  @override
  double get maxExtent => _tabBar.preferredSize.height; // Maximum height of the tab bar.

  @override
  Widget build( // Build the tab bar.
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) { // Determine if the tab bar needs rebuilding.
    return false; // In this case, it doesn't need rebuilding.
  }
}

//*******************************************************************************
class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
      ),
      body: const Center(
        child: Text('Barcode Scanner will be implemented here'),
      ),
    );
  }
}