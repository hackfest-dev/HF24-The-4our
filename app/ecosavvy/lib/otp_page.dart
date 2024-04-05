import 'package:ecosavvy/defaultScreen.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please enter the OTP sent to your phone',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white), // Set text color to white
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Row(
                    children: [
                      SizedBox(
                        width: 50.0,
                        child: TextField(
                          focusNode: _focusNodes[i],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white), // Set text color to white
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .white), // Set border color to white
                            ),
                          ),
                          onChanged: (String value) {
                            if (value.isNotEmpty && i < 3) {
                              _focusNodes[i + 1].requestFocus();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10.0), // Add a gap between each box
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF5803AD), // Set button color to purple
              ),
              child: Text(
                'Verify',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
