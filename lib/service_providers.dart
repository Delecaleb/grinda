// import 'package:flutter/material.dart';

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String>(
//       future: getClosestServiceProvider('service'), // replace with the correct service name
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text('Nearest service provider: ${snapshot.data}');
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
