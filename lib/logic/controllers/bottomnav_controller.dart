import 'package:blood_donate/logic/controllers/home_controller.dart';
import 'package:blood_donate/ui/screens/add_blood.dart';
import 'package:blood_donate/ui/screens/home_screen.dart';
import 'package:blood_donate/ui/screens/searchs_screen.dart';
import 'package:blood_donate/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomnavController extends GetxController{
  final homeController=Get.put(HomeController());

  var tabIndex=0.obs;

  List<Widget> screens=[
    HomeScreen(),
    AddBlood(),
    SearchsScreen(),
    SettingsScreen(),
  ];

 //Tab swap
  changeIndex(int index){
    if (Get.isOverlaysOpen) {
      Get.back();
    }
    homeController.toggleIcon(false);
    tabIndex.value=index;
  }

}