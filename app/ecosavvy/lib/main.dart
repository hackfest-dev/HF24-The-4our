import 'package:ecosavvy/defaultScreen.dart';
import 'package:ecosavvy/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecosavvy',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(), // Use SplashPage as the initial screen
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getToken(), // Load the token asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the token to load, show a loading indicator
          return CircularProgressIndicator();
        } else {
          // Once the token is loaded, check if it's available
          if (snapshot.hasData && snapshot.data != null) {
            // Token is available, navigate to HomeScreen
            return HomeScreen();
          } else {
            // Token is not available, navigate to LoginPage
            return LoginPage();
          }
        }
      },
    );
  }

  // Function to load the token from SharedPreferences
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
