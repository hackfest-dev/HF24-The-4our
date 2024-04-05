import 'package:flutter/material.dart';

class Typewriter extends StatefulWidget {
  final String text1;
  final String text2;

  Typewriter({required this.text1, required this.text2});

  @override
  _TypewriterState createState() => _TypewriterState();
}

class _TypewriterState extends State<Typewriter> with SingleTickerProviderStateMixin {
  late String currentText;
  late String nextText;
  String displayedText = '';
  int index = 0;
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    currentText = widget.text1;
    nextText = widget.text2;
    _typeText();

    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  _typeText() async {
    if (index < currentText.length) {
      setState(() {
        displayedText = currentText.substring(0, index + 1);
      });
      index++;
      await Future.delayed(Duration(milliseconds: 50));
      _typeText();
    } else {
      await Future.delayed(Duration(seconds: 2));
      _eraseText();
    }
  }

  _eraseText() async {
    if (displayedText.isNotEmpty) {
      setState(() {
        displayedText = displayedText.substring(0, displayedText.length - 1);
      });
      await Future.delayed(Duration(milliseconds: 50));
      _eraseText();
    } else {
      String temp = currentText;
      currentText = nextText;
      nextText = temp;
      index = 0;
      _typeText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(displayedText,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22
          ),),
        AnimatedBuilder(
          animation: _cursorController,
          builder: (BuildContext context, Widget? child) {
            return _cursorController.value < 0.5 ? Container(
              height: 20.0, // Adjust height as needed
              width: 8.0,   // Adjust the width for thickness
              color: Colors.white,
            ) : SizedBox(width: 8.0, height: 20.0); // Adjust the size of the SizedBox to match the cursor width
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }
}
