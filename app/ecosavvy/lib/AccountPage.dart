import 'package:ecosavvy/Account/about_us.dart';
import 'package:ecosavvy/Account/help_center.dart';
import 'package:ecosavvy/Account/legal_a.dart';
import 'package:ecosavvy/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Card(
                color: Color(0xff444444),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Name: John Doe",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Email: john.doe@example.com",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile("Personal Info", Icons.person_rounded, () {
                    // Handle onTap action for "Personal Info" list tile
                  }),
                  // Divider(color: Colors.white),
                  // _buildListTile("Notification", Icons.notifications_rounded,
                  //     () {
                  //   // Handle onTap action for "Notification" list tile
                  // }),
                  Divider(color: Colors.white),
                  _buildListTile("Security", Icons.security_rounded, () {
                    // Handle onTap action for "Security" list tile
                  }),
                  Divider(color: Colors.white),
                  _buildListTile("Help Center", Icons.help_rounded, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpCenterPage()),
                    );
                  }),
                  Divider(color: Colors.white),
                  _buildListTile("About Us", Icons.info_rounded, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()),
                    );
                  }),
                  Divider(color: Colors.white),
                  _buildListTile("Legal Agreements", Icons.assignment_rounded,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LegalAgreementsPage()),
                    );
                  }),
                  Divider(color: Colors.white),
                  _buildListTile("Sign Out", Icons.logout_rounded, ()async {
                  // Remove token from shared preferences
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove('token');

                  // Navigate back to the first screen
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your LoginScreen
                        (route) => false,);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, void Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }
}
