import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help ?'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(children: [
          Text('Help text ?.'),
          SizedBox(height: 20,),
          Text("Help text ?"),
          SizedBox(height: 20,),
          Text("Help text ?."),
          SizedBox(height: 20,),
          Text('Help text ?.'),
          SizedBox(height: 20,),
          Text("Help text ?.")
        ]),
      ),
    );
  }
}