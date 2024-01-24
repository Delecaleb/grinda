
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grinda/services.dart/service_handler.dart';

import '../models/service_provider_models.dart';

class GeolocatorController extends GetxController {
  final serviceSearchController= TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final serviceshandler = ServiceHandler();
  Rx<Position?> position = Rx<Position?>(null);
   Rx<String?> address = Rx<String?>(null);
  @override
  void onInit() {
    super.onInit();
    // getUserCurrentPosition();
  }

  Future<void> getUserCurrentPosition() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition();
      position.value = currentPosition;
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
  address.value = '${placemark.subLocality} ${placemark.subThoroughfare}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country},';
      }
    } catch (e) {
      print(e);
    }
  }

Future<List<ServiceProviderModel>> getClosestServiceProvider(services) async {
  // Get user's current location
  final currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final userLocation = GeoPoint(currentLocation.latitude, currentLocation.longitude);

  final distance = 10.0; // in kilometers

  final latitude = currentLocation.latitude;
  final longitude = currentLocation.longitude;

  // Earth's radius in miles


final nearestProvider = serviceshandler.GetServiceProvider(services, latitude, longitude, distance);

return nearestProvider;

// try{
//       final serviceProviders = await FirebaseFirestore.instance
//       .collection('registered_service_providers')
//       .where('services', arrayContains:  services)
//       // .orderBy('currentLocation', descending: false)
//       .where('currentLocation', isGreaterThanOrEqualTo: GeoPoint(minLat, minLon))
//       .where('currentLocation', isLessThanOrEqualTo: GeoPoint(maxLat, maxLon))

//       .limit(1)
//       .get();
  
 

//   if (serviceProviders.docs.isNotEmpty) {
//     final nearestProvider = serviceProviders.docs.map((e) => ServiceProviderModel.fromSnapshot(e)).toList();
//     return nearestProvider;
//   } else {
//     try {
//   final locationQuery = await FirebaseFirestore.instance
//     .collection('registered_service_providers')
//     .where('services', arrayContains: services)
//     .where('currentLocation', isGreaterThanOrEqualTo: GeoPoint(minLat, minLon))
//     .where('currentLocation', isLessThanOrEqualTo: GeoPoint(maxLat, maxLon))
//     .get();

//   final locationDocs = locationQuery.docs;

//   // Perform additional filtering on the client-side
//   final filteredDocs = locationDocs.where((doc) => doc['servicesDescription'].contains(services)).toList();

//   if (filteredDocs.isNotEmpty) {
//     final nearestProvider = filteredDocs.map((e) => ServiceProviderModel.fromSnapshot(e)).toList();
//     return nearestProvider;
//   } else {
//     return List<ServiceProviderModel>.empty();
//   }
// } catch (e) {
//   // Handle error or exception
//   print('Error: $e');
//   return List<ServiceProviderModel>.empty();
// }

//   }
// }catch(e){
//   print('Error: $e');
//     return List<ServiceProviderModel>.empty();
// }

}

}