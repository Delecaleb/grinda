import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderModel {
  String firstName, lastName, email, phone, profilePics, jobTitle, description, distance;
  double longitude, latitude;

  ServiceProviderModel(
      {
      required this.distance,
      required this.description,
      required this.email,
      required this.jobTitle,
      required this.profilePics,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.latitude,
      required this.longitude
      });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> mapdata) {
    return ServiceProviderModel(
        distance: mapdata['distance'].toString(),
        description: mapdata['short_detail'],
        jobTitle: mapdata['job_title'],
        email: mapdata['email'],
        profilePics: mapdata['profile_pics'],
        firstName: mapdata['first_name'],
        lastName: mapdata['last_name'],
        phone: mapdata['phone'],
        longitude: double.parse(mapdata['current_longitude']),
        latitude: double.parse(mapdata['current_latitude'])
        );
  }
}

