import 'package:ecosavvy/AccountPage.dart';
import 'package:ecosavvy/HomePage.dart';
import 'package:ecosavvy/PortfolioPage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PortfolioPage(),
    AccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        backgroundColor: Color(0xff252525),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.energy_savings_leaf_outlined),
            label: 'Invest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Home',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.white54,
        onTap: _onItemTapped,
      ),
    );
  }
}
