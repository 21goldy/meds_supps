import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
import '../constants.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: kBoxDecoration,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'medSupps',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Satisfy',
                      fontSize: 50,
                    ),
                  ),
                  Icon(
                    Icons.add,
                    size: 80.0,
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 200,
              ),
              SizedBox(
                width: 150,
                child: RoundedButton(
                    title: 'Get Started',
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    fontSize: 18.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
