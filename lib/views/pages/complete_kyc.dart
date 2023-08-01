import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grinda/controllers/controllers.dart';
import 'package:grinda/controllers/login_controller.dart';
import 'package:grinda/services.dart/service_handler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

final userProfileController = Get.put(UserDetailsController());

final userEmail = userProfileController.userDetails['email'].toString();
final userStorage = GetStorage();
final serviceController = ServiceHandler();
class KycRegistrationController extends GetxController {
 
  var uploadComplete = Rx(false);
  var isUploading = Rx(false);

  Future <void> uploadIdCard(File _editedImg)async{
  final filename = Path.basename(_editedImg.path);
  serviceController.UploadKYCfile(_editedImg, userEmail).then((response){
    Get.snackbar('Message', response['msg']);
    if(response['upload_status'].toLowerCase()=='done'){
      isUploading.value = false;
      uploadComplete.value = true;
    }
    });
}
  
  var _temImagefile = Rxn<File>();
 
  pickImage()async{
  final _image = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front, maxHeight: 1000, maxWidth: 1000);
  if (_image==null)return;

    final _imagePath = File(_image.path);
  

  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: _imagePath.path,
    aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Grindas Crop Image',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
    ]
  );

  _temImagefile.value = croppedFile != null ? File(croppedFile.path) : null;

  
}

}

class CompleteKyc extends StatelessWidget {
  final KycRegistrationController controller = Get.put(KycRegistrationController());
  final KYCDataController kycDataController = Get.put(KYCDataController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete KYC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: kycDataController.kycData.value['kyc_uploaded'] !='' && kycDataController.kycData.value['kyc_uploaded'] !=null &&  kycDataController.kycData.value['kyc_uploaded']==true ? 
        /// kyc file has been uploaded
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.white,
              width: Get.width,
              child: Text('KYC File Uploaded', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),         
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.white,
              margin: EdgeInsets.symmetric( vertical: 10),
              child: CachedNetworkImage(
                imageUrl: kycDataController.kycData.value['kyc_file'],

              ),
            ),
            ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text('KYC Status', style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(kycDataController.kycData.value['kyc_status']),
                  )
          ],
        )
        :
        /// kyc file has not been uploaded yet
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            
            /// 
            Text('Submit Documents', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
            Text('We need to verify your information to use this service.' ,textAlign: TextAlign.center,),
            
            SizedBox(height: 15,),
            Obx(() {
                return InkWell(
                   onTap: () => controller.pickImage(),
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1)
                    ),
                    child:  controller._temImagefile.value != null
                      ? Image.file(controller._temImagefile.value!)
                      :userStorage.read('kycUrl') !=null ? Image.network(userStorage.read('kycUrl')) : Image.asset('assets/selfie.png'),
                  ),
                );
              }
            ),
            userStorage.read('kycUrl') !=null ? Text('KYC STATUS : ${userProfileController.userDetails['kycStatus'].toString()}') :
            Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller._temImagefile.value != null ? 
                    ElevatedButton(
                      onPressed: () => controller.uploadIdCard(controller._temImagefile.value!),
                      child: Text('Upload Image'),
                    ) : Text(''),
                    controller.isUploading.value ?
                    Expanded(child: ElevatedButton(
                      onPressed: null,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    )
                     ):Text('') ,
                  ],
                );
              }
            ),

            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(4)
              ),
              child: Obx(() {
                  return ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text('KYC Status', style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(kycDataController.kycData.value['kyc_status']),
                  );
                }
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(4)
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                leading: Icon(Icons.credit_card),
                title: Text('Select ID Type', style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text("Driver's License, National ID, Voter's card, Passport"),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 238, 238),
                borderRadius: BorderRadius.circular(4)
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                leading: Icon(Icons.camera_front_outlined),
                title: Text('Upload Identity Card',style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('Take selfie with your ID holding to your chest'),
               
              ),
            ),
            SizedBox(height: 10,),
            kycDataController.kycData.value['kyc_status'].toLowerCase() !='pending' && kycDataController.kycData.value['kyc_status'].toLowerCase() !='pending' ? 
             Text('') 
             :
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 48, 196, 87),
                borderRadius: BorderRadius.circular(4)
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                leading: Icon(Icons.camera_alt, color: Colors.white,),
                title: Text('Take a Selfie', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 20)),
                onTap: () => controller.pickImage(),               
              ),
            ),
            SizedBox(height: 10,),
            
          ],
        ),
      ),
    );
  }
}
