import 'package:blood_donate/ui/auths/login.dart';
import 'package:blood_donate/ui/screens/add_blood.dart';
import 'package:blood_donate/ui/screens/bottomnav_screen.dart';
import 'package:blood_donate/ui/screens/home_screen.dart';
import 'package:blood_donate/ui/screens/searchs_screen.dart';
import 'package:blood_donate/ui/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class ScreensController extends GetxController {

  final auth=FirebaseAuth.instance;

  @override
  void onInit() {
    checkUser();
    super.onInit();
  }

  checkUser(){
    if(auth.currentUser==null){
     Future.delayed(Duration(seconds: 3),(){
       Get.offAll(()=>Login());
     });
    }else{
      Future.delayed(Duration(seconds: 3),(){
        Get.offAll(()=>BottomnavScreen());
      });
    }
  }


}