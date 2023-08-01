import 'package:cloud_firestore/cloud_firestore.dart';

class OnboardModel {
  final image;
  String title, subTitle;
  OnboardModel(
      {required this.image, required this.subTitle, required this.title});
}

class UserModel {
  int? id;
  String userToken, address, city,country, createdAt, email, firstName, kycFileName, kycIdType, kycStatus, otherName, phone, profilePicture, walletBalance, password;
      
  UserModel({required this.userToken, required this.firstName, required this.otherName, required this.email, required this.phone, required this.address, required this.city, required this.password,required this.kycStatus, required this.walletBalance, required this.profilePicture, required this.createdAt, required this.kycFileName, required this.kycIdType, required this.country,
  });

  toJson() {
    return {
      "address": address, "city": city, "country": country, "createdAt": createdAt, "email": email, "firstName": firstName, "kycFileName": kycFileName, "kycIdType": kycIdType, "kycStatus": kycStatus, "otherName": otherName, "phone": phone, "profilePicture": profilePicture, "walletBalance": walletBalance, "password": password, "userToken":userToken
    };
  }

  factory UserModel.fromSnapshot(Map<String, dynamic> mapData) {
    return UserModel(
        firstName: mapData['first_name'], otherName: mapData['other_name'], email: mapData['email'], phone: mapData['phone'],  address: mapData['address1'], city: mapData['city'], password: mapData['password'], kycStatus: mapData['kyc_status'], walletBalance: mapData['account_balance'], profilePicture: mapData['profile_pics'], createdAt: mapData['created_at'], kycFileName: mapData['kycFileName'], kycIdType: mapData['kycIdType'], country: mapData['country'], userToken: mapData['user_token']
        );
  }
}

class ServiceProviderModel {
  String firstName, lastName, email, phone, profilePics, jobTitle, description, distance;

  ServiceProviderModel(
      {
      required this.distance,
      required this.description,
      required this.email,
      required this.jobTitle,
      required this.profilePics,
      required this.firstName,
      required this.lastName,
      required this.phone});

  factory ServiceProviderModel.fromJson(Map<String, dynamic> mapdata) {
    return ServiceProviderModel(
        distance: mapdata['distance'].toString(),
        description: mapdata['short_detail'],
        jobTitle: mapdata['job_title'],
        email: mapdata['email'],
        profilePics: mapdata['profile_pics'],
        firstName: mapdata['first_name'],
        lastName: mapdata['last_name'],
        phone: mapdata['phone']);
  }
}

class CompletedOrdersModel{
  String serviceProvider, serviceRendered, dateCompleted, amountCharged;
  CompletedOrdersModel({required this.serviceProvider, required this.serviceRendered, required this.dateCompleted, required this.amountCharged});

  factory CompletedOrdersModel.fromJson(Map<String, dynamic> mapdata){
    return CompletedOrdersModel(serviceProvider: mapdata['first_name'], serviceRendered: mapdata['service_rendered'], dateCompleted: mapdata['date_created'], amountCharged: mapdata['amount_charged']);
  } 
}