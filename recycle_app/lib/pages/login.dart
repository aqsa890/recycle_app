import 'package:flutter/material.dart';
import 'package:recycle_app/services/auth.dart';
import 'package:recycle_app/services/widget_support.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                // Ensures scroll for small screens
                child: Column(
                  children: [
                    Image.asset(
                      'images/login.png',
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20.0),
                    Image.asset(
                      "images/recycle1.png",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Reduce. Reuse. Recycle",
                      style: AppWidget.healinetextstyle(18),
                    ),
                    Text('Repeat!', style: AppWidget.greentextstyle(32.0)),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Every item you recycle makes a difference',
                        textAlign: TextAlign.center,
                        style: AppWidget.normaltextstyle(20.0),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text('Get Started', style: AppWidget.greentextstyle(20.0)),
                  ],
                ),
              ),
            ),
            // Google Sign-In button fixed at bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () {
                  AuthMethods().signInWithGoogle(context);
                },
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 250, // 🔽 Adjust width as needed
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Image.asset(
                            'images/google.png',
                            height: 24,
                            width: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'Sign in with Google',
                            style: AppWidget.whitetextstyle(16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
