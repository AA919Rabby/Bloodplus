import 'dart:convert';

import 'package:blood_donate/ui/auths/login.dart';
import 'package:blood_donate/ui/screens/bottomnav_screen.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';



class AuthController extends GetxController {

  //Login
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final loginKey=GlobalKey<FormState>();

  //Register
  final registerUsernameController=TextEditingController();
  final registerEmailController=TextEditingController();
  final registerPasswordController=TextEditingController();
  final registerBloodController=TextEditingController();
  final registerKey=GlobalKey<FormState>();

  //Donate blood controller
  final donateUsernameController=TextEditingController();
  final donatePhoneController=TextEditingController();
  final weightController=TextEditingController();
  final locationController=TextEditingController();
  final donateBloodController=TextEditingController();
  final ageController=TextEditingController();
  final cityController=TextEditingController();
  final donateBloodKey=GlobalKey<FormState>();


  //Request for emergency blood
  final requestUsernameController=TextEditingController();
  final requestPhoneController=TextEditingController();
  final requestWeightController=TextEditingController();
  final requestLocationController=TextEditingController();
  final requestBloodController=TextEditingController();
  final requestAgeController=TextEditingController();
  final requestCityController=TextEditingController();
  final requestBloodKey=GlobalKey<FormState>();

  //TODO edit profile controller
  final editFirstNameController=TextEditingController();
  final editSecondNameController=TextEditingController();
  final editBloodGroup=TextEditingController();
  final editProfileKey=GlobalKey<FormState>();



  //request
  var requestBlood=''.obs;

  var donateBlood=''.obs;
  //select blood donation amount
  var amount=1.obs;
  //todo For request emergency blood
  var requestAmount=1.obs;
 //city for donate
  var city=''.obs;
  //TODO city for blood request
  var requestCity=''.obs;
  var requestBloodGroup=''.obs;

  var isVisible = false.obs;
  var bloodData=''.obs;
  var selectedImage=''.obs;

  var isLoading=false.obs;


  final auth=FirebaseAuth.instance;
  final db=FirebaseFirestore.instance;


  //Image select
  pickImage(ImageSource source)async{
    final image=await ImagePicker().pickImage(source: source,imageQuality: 50);
    if(image!=null){
      selectedImage.value=image.path;
      Get.back();
    }else{
      Get.snackbar("Oop's", 'No image selected',
      backgroundColor: AllThemes.red,
        colorText: AllThemes.lightBg,
      );
    }
  }


  //Amount increase select
  increase(){
    amount.value++;
  }
  //Amount decrease
  decrease(){
    if(amount.value>1){
      amount.value--;
    }
  }

//TODO request blood

  requestIncrease(){
    requestAmount.value++;
  }

  requestDecrease(){
    if(requestAmount.value>1){
      requestAmount.value--;
    }
  }

  requestCityAdd(String c){
    requestCity.value=c;
    requestCityController.text=c;
  }

  requestBloodRequest(String bg) {
    requestBloodGroup.value = bg;
    requestBloodController.text=bg;
  }


  //Password suffixicon
  void changeVisibility() {
    isVisible.value = !isVisible.value;
  }

  //Selected city for donate
  cityAdd(String c){
    city.value=c;
    cityController.text=c;
  }

  //blood selection
  selectBlood(String bg) {
    bloodData.value = bg;
    registerBloodController.text=bg;
    editBloodGroup.text=bg;
  }

//donate blood during register
  donateBloodRequest(String db){
    donateBlood.value=db;
    donateBloodController.text=db;
  }


//User register
register()async{
    try{
      isLoading.value=true;
      UserCredential credential=await auth.createUserWithEmailAndPassword(
          email:registerEmailController.text.trim(), password: registerPasswordController.text.trim());
      if(credential.user!.uid.isNotEmpty){
        await db.collection('users').doc(credential.user!.uid).set({
          'username':registerUsernameController.text.trim(),
          'email':registerEmailController.text.trim(),
          'password':registerPasswordController.text.trim(),
          'blood':registerBloodController.text.trim(),
          'uid':credential.user!.uid,
          'createdAt':Timestamp.now(),
        });
      }
      Get.off(()=>Login());
      Get.snackbar("Congratulations", 'Registration is successful',
        backgroundColor: AllThemes.green,
        colorText: AllThemes.lightBg,
      );
      registerUsernameController.clear();
      registerEmailController.clear();
      registerPasswordController.clear();
      registerBloodController.clear();
    }catch(e){
      Get.snackbar("Error", '$e',
      backgroundColor: AllThemes.red,
        colorText: AllThemes.lightBg,
      );
    }finally{
      isLoading.value=false;
    }
}

//login
login()async{
    try{
      isLoading.value=true;
      await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim());
      Get.offAll(()=>BottomnavScreen(),duration: Duration(milliseconds: 300),
      transition: Transition.fadeIn,curve: Curves.easeIn,
      );
      emailController.clear();
      passwordController.clear();
    }catch(e){
      Get.snackbar("Error", '$e',
        backgroundColor: AllThemes.red,
        colorText: AllThemes.lightBg,
      );
    }finally{
      isLoading.value=false;
    }
}


//Send blood donation request
sendDonation()async{
try{
  isLoading.value=true;
  if(auth.currentUser!.uid.isNotEmpty){
    DocumentSnapshot userDoc = await db.collection('users').doc(auth.currentUser!.uid).get();

    var userData = userDoc.data() as Map<String, dynamic>?;
    String userProfileImage = "";
    if (userData != null && userData.containsKey('imageUrl')) {
      userProfileImage = userData['imageUrl'] ?? "";
    }

    await db.collection('donators').add({
      'username':donateUsernameController.text.trim(),
      'phone':donatePhoneController.text.trim(),
      'weight':weightController.text.trim(),
      'location':locationController.text.trim(),
      'blood':donateBloodController.text.trim(),
      'age':ageController.text.trim(),
      'city':cityController.text.trim(),
      'uid':auth.currentUser!.uid,
      'createdAt':Timestamp.now(),
      'amount':amount.value,
      'imageUrl':userProfileImage,
    });
    await db.collection('users').doc(auth.currentUser!.uid).update({
      'amount':amount.value,
    });
    Get.snackbar("Congratulations", 'You are in the donation list',
      backgroundColor: AllThemes.green,
      colorText: AllThemes.lightBg,
    );
    donateUsernameController.clear();
    donatePhoneController.clear();
    weightController.clear();
    locationController.clear();
    donateBloodController.clear();
    ageController.clear();
    cityController.clear();
    amount.value=1;
  }
}catch(e){
  Get.snackbar("Error", '$e',
    backgroundColor: AllThemes.red,
    colorText: AllThemes.lightBg,
  );
}finally{
  isLoading.value=false;
}
}


//request for blood
  emergencyBlood()async{
    try{
      isLoading.value=true;
      if(auth.currentUser!.uid.isNotEmpty){
        DocumentSnapshot userDoc = await db.collection('users').doc(auth.currentUser!.uid).get();

        var userData = userDoc.data() as Map<String, dynamic>?;
        String userProfileImage = "";
        if (userData != null && userData.containsKey('imageUrl')) {
          userProfileImage = userData['imageUrl'] ?? "";
        }

        await db.collection('emergencyBlood').add({
          'username':requestUsernameController.text.trim(),
          'phone':requestPhoneController.text.trim(),
          'weight':requestWeightController.text.trim(),
          'location':requestLocationController.text.trim(),
          'blood':requestBloodController.text.trim(),
          'age':requestAgeController.text.trim(),
          'city':requestCityController.text.trim(),
          'uid':auth.currentUser!.uid,
          'createdAt':Timestamp.now(),
          'amount':requestAmount.value,
          'imageUrl':userProfileImage,
        });
        Get.snackbar("Congratulations", 'Your was successfully upload',
          backgroundColor: AllThemes.green,
          colorText: AllThemes.lightBg,
        );
        requestUsernameController.clear();
        requestPhoneController.clear();
        requestWeightController.clear();
        requestLocationController.clear();
        requestBloodController.clear();
        requestAgeController.clear();
        requestCityController.clear();
        requestAmount.value=1;
      }
    }catch(e){
      Get.snackbar("Error", '$e',
        backgroundColor: AllThemes.red,
        colorText: AllThemes.lightBg,
      );
    }finally{
      isLoading.value=false;
    }
  }

//Cloudinary for uploading images


uploadCloudinary()async{
    if(selectedImage.value.isEmpty){
      return null;
    }
    try{
      final cloudName=dotenv.get('CLOUDINARY_CLOUD_NAME').trim();
      final uploadPreset=dotenv.get('CLOUDINARY_UPLOAD_PRESET').trim();
      var request=await http.MultipartRequest('POST',Uri.parse(
          'https://api.cloudinary.com/v1_1/$cloudName/image/upload'),);
       request.fields['upload_preset']=uploadPreset;
       request.files.add(
         await http.MultipartFile.fromPath('file', selectedImage.value),
       );
       var response=await request.send();
       if(response.statusCode==200 || response.statusCode==201){
         var responseData=await response.stream.toBytes();
         var responseString=String.fromCharCodes(responseData);
         var jsonRes=jsonDecode(responseString);
         return jsonRes['secure_url'];
       }
    }catch(e){
      Get.snackbar("Error", '$e',
        backgroundColor: AllThemes.red,
        colorText: AllThemes.lightBg,
      );
    }
}



  //TODO for phone calls
  makeCall(String phoneNumber) async {
    final launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      Get.snackbar("Error", "Could not launch dialer",
          backgroundColor: AllThemes.red, colorText: AllThemes.lightBg);
    }
  }



  //TODO open google for for location
  openMap(String location,String city)async{
    String query=Uri.encodeComponent('$location,$city');
    final url=Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    if(await canLaunchUrl(url)){
      await launchUrl(url,mode: LaunchMode.externalApplication);
    }else{
      Get.snackbar("Error", "Could not launch map",
          backgroundColor: AllThemes.red, colorText: AllThemes.lightBg);
    }
  }


//TODO edit profile
editProfile()async{
    try{
      isLoading.value=true;
       String? imageUrl=await uploadCloudinary();
       //Merge the name
       String fullName="${editFirstNameController.text.trim()} ${editSecondNameController.text.trim()}";
       if(auth.currentUser!.uid.isNotEmpty){
         Map<String, dynamic> updateData = {
           'username': fullName,
           'blood': bloodData.value.trim(),
           'updatedAt': Timestamp.now(),
         };
         if (imageUrl != null && imageUrl.isNotEmpty) {
           updateData['imageUrl'] = imageUrl;
         }
         await db.collection('users').doc(auth.currentUser!.uid).update(updateData);
         Get.snackbar("Congratulations", 'Your profile was successfully updated',
         backgroundColor: AllThemes.green,
         colorText: AllThemes.lightBg,
         );
         editFirstNameController.clear();
         editSecondNameController.clear();
         editBloodGroup.clear();
         bloodData.value = '';
         selectedImage.value = '';
       }
    }catch(e){
      Get.snackbar("Error", '$e',
        backgroundColor: AllThemes.red,
        colorText: AllThemes.lightBg,
      );
    }finally{
      isLoading.value=false;
    }
}



//TODO Getting user profile from firebase
Stream<DocumentSnapshot> getUserData(){
    return db.collection('users').doc(auth.currentUser!.uid).snapshots();
}


//Todo get emergency donor request
  Stream<QuerySnapshot> getEmergencyRequest(){
    return db.collection('emergencyBlood')
        .orderBy('createdAt',descending: true)
        .snapshots();
}


//Todo get donor request
Stream<QuerySnapshot> getDonor(){
    return db.collection('donators')
        .orderBy('createdAt',descending: true)
  .snapshots();
 }


//TODO get user donate
Stream<QuerySnapshot> userDonate(){
    return db.collection('emergencyBlood')
        .where('uid',isEqualTo: auth.currentUser!.uid)
        .orderBy('createdAt',descending: true)
        .snapshots();
}









//Logout user
logoutUSer()async{
   try{
     await auth.signOut();
     Get.offAll(()=>Login());
   }catch(e){
     Get.snackbar("Error", '$e',
       backgroundColor: AllThemes.red,
       colorText: AllThemes.lightBg,
     );
   }
}

//Delete user account
deleteUser()async{
    try{
      await db.collection('users').doc(auth.currentUser!.uid).delete();
      await auth.currentUser!.delete();
      Get.offAll(()=>Login());
    }catch(e){
      Get.snackbar("Error", '$e',
        backgroundColor: AllThemes.red,
        colorText: AllThemes.lightBg,
      );
    }
}






}