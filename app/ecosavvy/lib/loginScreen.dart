import 'dart:math';

import 'package:ecosavvy/Phone_no.dart';
import 'package:ecosavvy/SignupScreen.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _bgColorController;
  late Animation<RelativeRect> _animation;
  late Animation<RelativeRect> _bgColorAnimation;
  double rotation = 0.0;

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // Calculate the rotation angle based on the gyroscope data
      double angle = -atan2(event.y, event.z);
      setState(() {
        rotation = angle;
      });
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _bgColorController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
      end: RelativeRect.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.67, 0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Color.fromARGB(255, 0, 0, 0),
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 1.00,
                        height: MediaQuery.of(context).size.width * 1.00,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/1.jpg',
                              fit: BoxFit.contain,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Welcome to ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'EcoSavvy',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 207, 45),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'The best app to invest in renewable sources of energy in India today!',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PositionedTransition(
            rect: _animation,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Typewriter(
                  //   text1: 'Welcome to ....',
                  //   text2: 'Let\'s Begin with...',
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneNumberPage()),
                            );
                          },
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Color.fromARGB(255, 196, 168, 65),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height:
                                  MediaQuery.of(context).size.height * 0.074,
                              child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Text(
                                      "Sign in",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyPageView()),
                            );
                          },
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Color.fromARGB(255, 92, 244, 138),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height:
                                  MediaQuery.of(context).size.height * 0.074,
                              child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Text(
                                      "Sign up",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    _controller.dispose();
    _bgColorController.dispose();
    super.dispose();
  }

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          screen, // the new screen
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.bounceInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class WaterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Customize this method to draw the water inside the box
    // For simplicity, you can use a path to draw a water-like shape
    final paint = Paint()
      ..color = Color(0xff252525)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRect(Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)))
      ..quadraticBezierTo(
          size.width / 2, size.height * 0.2, size.width, size.height * 0.5)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
