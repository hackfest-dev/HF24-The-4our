import 'package:flutter/material.dart';

class LegalAgreementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "About Us",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to Ecosavvy! By using our platform, you agree to abide by our Terms of Service. These terms govern your use of Ecosavvy and outline your rights and responsibilities as a user.',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'At Ecosavvy, we take your privacy seriously. Our Privacy Policy outlines how we collect, use, and protect your personal information when you use our platform. By using Ecosavvy, you consent to the terms outlined in our Privacy Policy.',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Cookie Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Ecosavvy uses cookies to enhance user experience and provide personalized content. Our Cookie Policy explains how we use cookies and similar technologies on our platform. By using Ecosavvy, you consent to the use of cookies as described in our Cookie Policy.',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'End User License Agreement (EULA)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'The End User License Agreement (EULA) governs your use of any software provided by Ecosavvy. By downloading, installing, or using our software, you agree to be bound by the terms outlined in the EULA.',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
