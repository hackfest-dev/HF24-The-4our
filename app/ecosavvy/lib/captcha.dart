import 'dart:math';

import 'package:flutter/material.dart';
import 'package:researchear/DefaultScreen.dart'; // Import your home screen or any other screen

class CaptchaScreen extends StatefulWidget {
  @override
  _CaptchaScreenState createState() => _CaptchaScreenState();
}

class _CaptchaScreenState extends State<CaptchaScreen> {
  List<int> generatedNumbers = [];
  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generatedNumbers = generateRandomNumbers();
  }

  List<int> generateRandomNumbers() {
    Random random = Random();
    List<int> numbers = [];
    for (int i = 0; i < 5; i++) {
      numbers
          .add(random.nextInt(10)); // Generate a random number between 0 and 9
    }
    return numbers;
  }

  bool verifyInput(List<int> generatedNumbers, String input) {
    if (input.length != 5) {
      return false; // Length mismatch, input is incorrect
    }

    List<int> userInput = input
        .split('')
        .map((String char) => int.tryParse(char) ?? -1)
        .toList(); // Convert input string to a list of integers

    for (int i = 0; i < userInput.length; i++) {
      if (userInput[i] != generatedNumbers[i]) {
        return false; // Incorrect input
      }
    }

    return true; // Input matches generated numbers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the numbers you see:',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: generatedNumbers.map((int number) {
                return Text(
                  number.toString(),
                  style: TextStyle(
                    fontSize: Random().nextDouble() * 40 +
                        9, // Random font size between 20 and 50
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5803AD),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: TextField(
                controller: inputController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 5, // Maximum length of 5 digits
                style: TextStyle(
                    color: Colors.white), // Change color of entered text
                decoration: InputDecoration(
                  hintText: 'Enter numbers',
                  hintStyle:
                      TextStyle(color: Colors.white), // Adjust hint text color
                  filled: true,
                  fillColor:
                      Color.fromARGB(97, 99, 99, 99), // Adjust fill color
                  border: OutlineInputBorder(
                    // Add border with contrasting color
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(color: Colors.white), // Adjust border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Add focused border with desired color
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color:
                            Color(0xFF5803AD)), // Adjust focused border color
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, // Hide hint text when focused
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF5803AD))),
              onPressed: () {
                bool isCorrect =
                    verifyInput(generatedNumbers, inputController.text);
                setState(() {
                  generatedNumbers =
                      generateRandomNumbers(); // Regenerate random numbers
                  inputController.clear(); // Clear the input field
                });
                if (isCorrect) {
                  // Redirect to home screen if input is correct
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } else {
                  // Show error message or handle incorrect input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Incorrect input. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
