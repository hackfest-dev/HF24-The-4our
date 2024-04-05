import 'package:flutter/material.dart';
import 'package:researchear/otp_page.dart';

class PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  TextEditingController _phoneNumberController = TextEditingController();
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(10, (_) => TextEditingController());
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.length != 10) {
      return 'Phone number should be 10 digits';
    }
    return null;
  }

  Widget _buildNumberInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(10, (index) {
        return Row(
          children: [
            SizedBox(
              width: 2.0, // Add a gap between each box
            ),
            Container(
              width: 33,
              height: 55,
              child: TextField(
                controller: controllers[index],
                maxLength: 1,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (value) {
                  if (value.length == 1 && index < 9) {
                    FocusScope.of(context).nextFocus();
                  }
                  _updatePhoneNumber();
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  void _updatePhoneNumber() {
    String phoneNumber = '';
    for (int i = 0; i < 10; i++) {
      phoneNumber += controllers[i].text;
    }
    setState(() {
      _phoneNumberController.text = phoneNumber;
    });
  }

  void _redirectToNextPage() {
    if (_phoneNumberController.text.length == 10) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OtpPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid phone number'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please enter your phone number:',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            SizedBox(height: 20.0),
            _buildNumberInputFields(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _redirectToNextPage,
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
