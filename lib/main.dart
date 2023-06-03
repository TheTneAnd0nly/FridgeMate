import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FridgeMate',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TheSockDrawer',
          style: TextStyle(
            fontFamily: 'Script',
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.pink[900],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call a function to capture image from the webcam
          captureImageFromWebcam();
        },
        child: const Text('Capture'),
      ),
    );
  }

  void captureImageFromWebcam() {
    // Code to capture an image from the webcam

    // Code to send the captured image to Google Cloud Vision for analysis

    // Code to update the virtual sock drawer with the results
  }
}
