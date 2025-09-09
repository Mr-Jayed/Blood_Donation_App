import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                Icons.bloodtype,
                size: 100,
                color: Colors.redAccent,
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to BloodConnect",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text("Login", style: TextStyle(fontSize: 18,color: Colors.white,)),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Colors.redAccent),
              ),
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
