import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Idea',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Empowering Renewable Energy Investment with Ecosavvy',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Welcome to Ecosavvy, where we revolutionize renewable energy investment in India. Ecosavvy offers a unique platform connecting investors with zero-investment schemes for renewable energy farms. Our goal is to democratize access to clean energy investments while driving sustainable development.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Targeted Problem',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Addressing Energy Accessibility and Sustainability Challenges',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Description',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'India faces energy accessibility and sustainability challenges, with a growing demand for clean energy solutions. Lack of capital and resources often hinder the setup of renewable energy farms, limiting investment opportunities. Ecosavvy targets this problem by offering zero-investment schemes and facilitating renewable energy investments for individuals and companies.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Shreyansh Tiwari',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Yash Kumar',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Jahnavi Enduri',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Ratnesh Kherudkar',
              style: TextStyle(fontSize: 16),
            ),
            // Add more sections for Solution and Impact, Feasibility and Credibility
          ],
        ),
      ),
    );
  }
}
