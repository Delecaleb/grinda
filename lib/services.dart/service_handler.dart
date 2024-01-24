import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../models/completed_orders_models.dart';
import '../models/service_provider_models.dart';
import '../models/user_model.dart';
class ServiceHandler{
  static final mainUri = "https://smart-school.online/grindas/users_function.php";

  Future<dynamic> createUser(UserModel user) async {
  Map<String, dynamic> map = user.toJson(); // Assuming UserModel has a `toJson` method to convert it to a Map
  map['action'] = 'create_account';

  http.Response response = await http.post(Uri.parse(mainUri), body: map);

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData;
  } else {
    throw "Connection error";
  }
}

  Future LoginUser(userId, password)async{
    var map = Map<String, dynamic>();
    
    map['user_id']=userId;
    map['password']=password;
    map['action']='login_user';

    http.Response response = await http.post(Uri.parse(mainUri), body: map);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      return responseData;
    }else{
      throw "connection error";
    }
  }

  Future ResetPassword(email)async{
    var map = Map<String, dynamic>();
    
    map['email']=email;
    map['action']='reset_password';

    http.Response response = await http.post(Uri.parse(mainUri), body: map);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      return responseData;
    }else{
      throw "connection error";
    }
  }
  
  Future acceptServiceProvider(userId,serviceProvider,service)async{
    var map = Map<String, dynamic>();
    
    map['service_user']=userId;
    map['service_provider']=serviceProvider;
    map['service']=service;
    map['action']='notify_service_provider';
    map['title']='New Gig Alert';
    map['message']='I need a $service service';

    http.Response response = await http.post(Uri.parse(mainUri), body: map);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      return responseData;
    }else{
      throw "connection error";
    }
  }

  /// To check service providers acceptance off the sent request
  Future checkAcceptance(userId,serviceProvider)async{
    var map = Map<String, dynamic>();
    
    map['service_user']=userId;
    map['service_provider']=serviceProvider;
    map['action']='checkAcceptance';

    http.Response response = await http.post(Uri.parse(mainUri), body: map);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      return responseData;
    }else{
      throw "connection error";
    }
  }

  Future <List<ServiceProviderModel>>GetServiceProvider(service, latitude,longitude, distance)async{
    var map = Map<String, dynamic>();
    map['service'] = service;
    map['latitude'] = latitude.toString();
    map['longitude'] = longitude.toString();
    map['distance'] = distance.toString();
    map['action'] = 'get_nearest_service_provider';

    http.Response response = await http.post(Uri.parse(mainUri), body: map);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      print(response.body);
      // return responseData.map((e)=>ServiceProviderModel.fromJson(e)).toLIst;
      List<ServiceProviderModel> providerList = [];
    for (var providerData in responseData) {
      providerList.add(ServiceProviderModel.fromJson(providerData));
    }
     return providerList;
    }else{
      throw "connection error";
    }
  }

  Future UploadKYCfile(File filePath, String user)async{
  var uri = Uri.parse(mainUri);
  var request = http.MultipartRequest('POST', uri);

  var fileStream = http.ByteStream(Stream.castFrom(filePath.openRead()));
  var length = await filePath.length();

  var multipartFile = http.MultipartFile('file', fileStream, length,
      filename: filePath.path.split('/').last);

  request.files.add(multipartFile);

  request.fields['user'] = user;
  request.fields['action'] = 'upload_kyc_file';

  var response = await http.Response.fromStream(await request.send());

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    
    return responseData;
  } else {
    throw "Connection error";
  }
 
  }

  Future UploadDpFile(File filePath, String user)async{
  var uri = Uri.parse(mainUri);
  var request = http.MultipartRequest('POST', uri);

  var fileStream = http.ByteStream(Stream.castFrom(filePath.openRead()));
  var length = await filePath.length();

  var multipartFile = http.MultipartFile('file', fileStream, length,
      filename: filePath.path.split('/').last);

  request.files.add(multipartFile);

  request.fields['user'] = user;
  request.fields['action'] = 'upload_dp_file';

  var response = await http.Response.fromStream(await request.send());

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    
    return responseData;
  } else {
    throw "Connection error";
  }
 
  }

  Future UploadProveOfAddress(File filePath, String user)async{
  var uri = Uri.parse(mainUri);
  var request = http.MultipartRequest('POST', uri);

  var fileStream = http.ByteStream(Stream.castFrom(filePath.openRead()));
  var length = await filePath.length();

  var multipartFile = http.MultipartFile('file', fileStream, length,
      filename: filePath.path.split('/').last);

  request.files.add(multipartFile);

  request.fields['user'] = user;
  request.fields['action'] = 'upload_prove_ofaddress';

  var response = await http.Response.fromStream(await request.send());

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    
    return responseData;
  } else {
    throw "Connection error";
  }
 
  }

  Future GetKYCStatus(String user)async{
    var map = Map<String, dynamic>();
    map['user_id'] = user;
    map['action'] = 'get_kyc_status';

    http.Response response = await http.post(Uri.parse(mainUri), body: map);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      
     return responseData;
    }else{
      throw "connection error";
    } 
  }

  Future GetCurrentData(String user)async{
    var map = Map<String, dynamic>();
    map['user_id'] = user;
    map['action'] = 'get_cur_data';

    http.Response response = await http.post(Uri.parse(mainUri), body: map);

    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      
     return responseData;
    }else{
      throw "connection error";
    } 
  }

   Future<List<CompletedOrdersModel>> GetCompletedOrders(user_id) async {
  var map = Map<String, dynamic>();
  map['user_id'] = user_id;
  map['action'] = 'get_completed_orders';

  http.Response response = await http.post(Uri.parse(mainUri), body: map);
  if (response.statusCode == 200) {
    List responseData = json.decode(response.body);
    print(responseData);

    return responseData.map((mapdata) => CompletedOrdersModel.fromJson(mapdata)).toList();
    
  } else {
    throw "Connection Error";
  }
}

Future RateServiceProvider(user_id, ServiceProviderModel serviceProvider, rating) async {
  var map = Map<String, dynamic>();
  map['service_user'] = user_id;
  map['action'] = 'rate_service_provider';
  map['service_provider'] = serviceProvider.email;
  map['service'] = serviceProvider.jobTitle;
  map['rating'] = rating.toString();

  http.Response response = await http.post(Uri.parse(mainUri), body: map);
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    print(responseData);
    return responseData;

  } else {
    throw "Connection Error";
  }
}

Future getPaymentHistory(userid)async{
  var map = Map<String, dynamic>();
  map['user_id'] = userid;

  http.Response response = await http.post(Uri.parse(mainUri), body: map);
  if(response.statusCode==200){
    final responseData = json.decode(response.body);
    print(responseData);
    return(responseData);
  }else{
    throw "Connection Error";
  }
}
}