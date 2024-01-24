import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:grinda/services.dart/service_handler.dart';
import 'package:grinda/utils/styles.dart';
import 'package:grinda/views/home.dart';

import 'models/service_provider_models.dart';

class UserRating extends StatefulWidget {
  ServiceProviderModel serviceProvider;
  String userId;
  UserRating({required this.serviceProvider, required this.userId, super.key});

  @override
  State<UserRating> createState() => _UserRatingState();
}

class _UserRatingState extends State<UserRating> {
  final serviceHandler = ServiceHandler();
  bool rated = false;
  double userRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                SizedBox(height: 40,),
                Container(
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 138, 240, 189),
                    radius: 100,
                    child: Image.asset(
                      'assets/craftman.png',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text('Task Completed', style: titleHeader,),
                SizedBox(height: 20,),
                Text('Rate your experience with ${widget.serviceProvider.firstName} ${widget.serviceProvider.lastName} and the quality of service offered you', style: TextStyle(height: 2), textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                Container(
                  child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                      rated = true;
                      userRating = rating;
                  });
                },
              )
                ),
              SizedBox(height: 30,),
              rated ? ElevatedButton(
                onPressed: ()=>serviceHandler.RateServiceProvider(widget.userId, widget.serviceProvider, userRating)
                .then((responseValue){
                  Get.snackbar('', responseValue['message']);
                  if(responseValue['status']=='Done'){
                    Get.offAll(()=>HomeScreen());
                  }
                }), 
              child: Text('Continue')):Text(''),
            ],
          ),
        ),
      ),
    );
  }
}