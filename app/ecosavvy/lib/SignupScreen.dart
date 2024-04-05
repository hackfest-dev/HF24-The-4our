import 'package:flutter/material.dart';
import 'package:researchear/captcha.dart';

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
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();
  TextEditingController nomineeAadhaarController = TextEditingController();
  TextEditingController nomineeDobController = TextEditingController();

  List<String> userData = [
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
                      "What is your permanent address?",
                      "Enter here",
                      Icons.home,
                      addressController,
                      4,
                    ),
                    buildPage(
                      "What is your date of birth?",
                      "Select here",
                      Icons.calendar_today,
                      dobController,
                      5,
                      isDatePicker: true,
                    ),
                    buildPage(
                      "What is your nominee's name?",
                      "Enter here",
                      Icons.person_add,
                      nomineeNameController,
                      6,
                    ),
                    buildPage(
                      "What is your nominee's Aadhaar number?",
                      "Enter here",
                      Icons.person_add,
                      nomineeAadhaarController,
                      7,
                    ),
                    buildPage(
                      "What is your nominee's date of birth?",
                      "Select here",
                      Icons.calendar_today,
                      nomineeDobController,
                      8,
                      isDatePicker: true,
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
                if (_pageController.page != 8) {
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
                if (_pageController.page != 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
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
      {bool isDatePicker = false}) {
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

  void saveData(BuildContext context) {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String pan = panController.text.trim();
    String address = addressController.text.trim();
    String dob = dobController.text.trim();
    String nomineeName = nomineeNameController.text.trim();
    String nomineeAadhaar = nomineeAadhaarController.text.trim();
    String nomineeDob = nomineeDobController.text.trim();

    // Function to handle navigation back to the corresponding field
    void navigateBack(int index) {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    // Check if any field is empty
    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        pan.isEmpty ||
        address.isEmpty ||
        dob.isEmpty ||
        nomineeName.isEmpty ||
        nomineeAadhaar.isEmpty ||
        nomineeDob.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'Please fill in all the fields.',
              style: TextStyle(color: Colors.red),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  navigateBack(0); // Navigate back to the first field
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
      return;
    }

    // Data is valid, you can proceed with saving it
    userData[0] = name;
    userData[1] = email;
    userData[2] = phone;
    userData[3] = pan;
    userData[4] = address;
    userData[5] = dob;
    userData[6] = nomineeName;
    userData[7] = nomineeAadhaar;
    userData[8] = nomineeDob;

    // Optionally, you can display a success message or perform any other action
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => CaptchaScreen(),
      ),
    );
  }
}
