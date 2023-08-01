import 'package:flutter/material.dart';

class RateUser extends StatelessWidget {
  const RateUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // image section

            // text section
            Text("Your Opinion Is Essential"),
            Text('How will you rate {Dele} and the quality of service {he} rendered to you'),

            // rating

            // submit button
            TextButton(onPressed: null, child: Text('Submit'))
            ],            
          ),
        ),      
    );
  }
}