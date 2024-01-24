import 'package:cloud_firestore/cloud_firestore.dart';

class OnboardModel {
  final image;
  String title, subTitle;
  OnboardModel(
      {required this.image, required this.subTitle, required this.title});
}
