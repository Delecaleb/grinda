import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  int? id;
  String referralId, userToken, address, city,country, createdAt, email, firstName, kycFileName, kycIdType, kycStatus, otherName, phone, profilePicture, walletBalance, password;
      
  UserModel({ required this.referralId,required this.userToken, required this.firstName, required this.otherName, required this.email, required this.phone, required this.address, required this.city, required this.password,required this.kycStatus, required this.walletBalance, required this.profilePicture, required this.createdAt, required this.kycFileName, required this.kycIdType, required this.country,
  });

  toJson() {
    return {
      "address": address,"referral_id":referralId, "city": city, "country": country, "createdAt": createdAt, "email": email, "firstName": firstName, "kycFileName": kycFileName, "kycIdType": kycIdType, "kycStatus": kycStatus, "otherName": otherName, "phone": phone, "profilePicture": profilePicture, "walletBalance": walletBalance, "password": password, "userToken":userToken
    };
  }

  factory UserModel.fromSnapshot(Map<String, dynamic> mapData) {
    return UserModel(
          referralId:mapData['referer_code'], firstName: mapData['first_name'], otherName: mapData['other_name'], email: mapData['email'], phone: mapData['phone'],  address: mapData['address1'], city: mapData['city'], password: mapData['password'], kycStatus: mapData['kyc_status'], walletBalance: mapData['account_balance'], profilePicture: mapData['profile_pics'], createdAt: mapData['created_at'], kycFileName: mapData['kycFileName'], kycIdType: mapData['kycIdType'], country: mapData['country'], userToken: mapData['user_token']
        );
  }
}

