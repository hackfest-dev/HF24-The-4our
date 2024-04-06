import 'package:ecosavvy/defaultScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Add this import statement
import 'package:http/http.dart' as http; // Add this import statement
import 'package:shared_preferences/shared_preferences.dart';

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController = PageController(initialPage: 0);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();
  TextEditingController nomineeAadhaarController = TextEditingController();
  TextEditingController nomineeDobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> userData = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ]; // To store entered data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    buildPage(
                      "What is your name?",
                      "Enter here",
                      Icons.person,
                      nameController,
                      0,
                    ),
                    buildPage(
                      "What is your email address?",
                      "Enter here",
                      Icons.email,
                      emailController,
                      1,
                    ),
                    buildPage(
                      "What is your phone number?",
                      "Enter here",
                      Icons.phone,
                      phoneController,
                      2,
                    ),
                    buildPage(
                      "What is your Pan card number?",
                      "Enter here",
                      Icons.credit_card,
                      panController,
                      3,
                    ),
                    buildPage(
                      "What is your Aadhaar number?",
                      "Enter here",
                      Icons.person_add,
                      aadharController,
                      4,
                    ),
                    buildPage(
                      "What is your permanent address?",
                      "Enter here",
                      Icons.home,
                      addressController,
                      5,
                    ),
                    buildPage(
                      "What is your date of birth?",
                      "Select here",
                      Icons.calendar_today,
                      dobController,
                      6,
                      isDatePicker: true,
                    ),
                    buildPage(
                      "What is your nominee's name?",
                      "Enter here",
                      Icons.person_add,
                      nomineeNameController,
                      7,
                    ),
                    buildPage(
                      "What is your nominee's Aadhaar number?",
                      "Enter here",
                      Icons.person_add,
                      nomineeAadhaarController,
                      8,
                    ),
                    buildPage(
                      "What is your nominee's date of birth?",
                      "Select here",
                      Icons.calendar_today,
                      nomineeDobController,
                      9,
                      isDatePicker: true,
                    ),
                    buildPage(
                      "What is your password?",
                      "Enter here",
                      Icons.lock,
                      passwordController,
                      10,
                      isPassword:
                          true, // Set isPassword to true for password field
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 135, 33, 243),
                ), // Provide a color here
              ),
              onPressed: () {
                if (_pageController.page != 10) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Assuming you have a method to save data
                  saveData(context);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ), // Adjust spacing between text and icon as needed
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF5803AD)),
              ),
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String question, String hintText, IconData iconData,
      TextEditingController controller, int index,
      {bool isDatePicker = false, bool isPassword = false}) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              iconData,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 20),
            Text(
              question,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            if (isDatePicker)
              ElevatedButton(
                onPressed: () => _selectDate(context, controller),
                child: Text('Select Date'),
              )
            else
              TextFormField(
                controller: controller,
                obscureText: isPassword, // Set obscureText based on isPassword
                style:
                    TextStyle(color: Colors.white), // Set text color to white
                cursorColor: Color(0xFF5803AD), // Set cursor color
                readOnly: false, // Set the text field as not read-only
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(209, 170, 131, 209),
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: Colors.white), // Set hint text color to white
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2.0, color: Color(0xFF5803AD)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.white), // Set border color to white
                  ),
                ),
              ),
            // Display the selected date if available
            if (!isDatePicker && controller.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  controller.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        // Format the selected date as desired
        String formattedDate = "${picked.year}-${picked.month}-${picked.day}";
        // Set the selected date to the controller
        controller.text = formattedDate;
      });
    }
  }

  void saveData(BuildContext context) async {
    // Your existing code to retrieve user data
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String pan = panController.text.trim();
    String aadhar = aadharController.text.trim();
    String address = addressController.text.trim();
    String dob = dobController.text.trim();
    String nomineeName = nomineeNameController.text.trim();
    String nomineeAadhaar = nomineeAadhaarController.text.trim();
    String nomineeDob = nomineeDobController.text.trim();
    String password = passwordController.text.trim();

    // Create a map to hold the user data
    Map<String, dynamic> userDataMap = {
      "name": name,
      "email": email,
      "phoneNumber": phone,
      "panNumber": pan,
      "aadhar": aadhar,
      "permantAddress": address,
      "dateOfBirth": dob,
      "nomineeName": nomineeName,
      "nomineeAadhaar": nomineeAadhaar,
      "nomineeDob": nomineeDob,
      "password": password,
    };

    // Send a POST request to the server
    var url = Uri.parse('http://172.16.17.4:3000/investor/signup');
    var response = await http.post(
      url,
      body: jsonEncode(userDataMap), // Encode user data as JSON
      headers: {'Content-Type': 'application/json'}, // Set headers
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Parse the response body (assuming it's JSON)
      var responseBody = jsonDecode(response.body);

      // Extract the token from the response
      var token = responseBody['token'];

      // Save the token using SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token); // Save the token

      // Optionally, navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      // Request failed, show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'Failed to sign up. Please try again later.',
              style: TextStyle(color: Colors.red),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF5803AD),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
