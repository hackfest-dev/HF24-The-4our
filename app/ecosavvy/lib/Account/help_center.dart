import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Help Center",
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
              'Welcome to the Help Center!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'FAQs (Frequently Asked Questions)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Q: How do I invest in renewable energy farms through Ecosavvy?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            Text(
              'A: To invest in renewable energy farms, you can follow these steps:\n1. Sign up on the Ecosavvy platform.\n2. Browse available investment opportunities.\n3. Choose a farm that suits your preferences.\n4. Follow the instructions to complete the investment process.',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Q: How can I contact customer support?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            Text(
              'A: You can contact our customer support team via email at support@ecosavvy.com or by phone at +1234567890. Our team is available to assist you with any questions or concerns you may have.',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'If you need further assistance or have any inquiries, please feel free to reach out to us:',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              'Email: support@ecosavvy.com',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            Text(
              'Phone: +1234567890',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
