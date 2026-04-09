import 'package:blood_donate/logic/controllers/bottomnav_controller.dart';
import 'package:blood_donate/logic/controllers/screens_controller.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class BottomnavScreen extends StatelessWidget {
  BottomnavScreen({super.key});
  final bottomnavController=Get.put(BottomnavController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>bottomnavController.screens[bottomnavController.tabIndex.value]),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AllThemes.lightBg,
          color: AllThemes.red,
          buttonBackgroundColor: AllThemes.red,
          height: 60,
          animationDuration: Duration(milliseconds: 300),
        onTap: (index){
          bottomnavController.changeIndex(index);
        },
          items: [
        Icon(Icons.home,color: AllThemes.lightBg,),
        Icon(Icons.add_box_rounded,color: AllThemes.lightBg,),
        Icon(Icons.search,color: AllThemes.lightBg,),
        Icon(Icons.settings,color: AllThemes.lightBg,),
      ],
      ),
    );
  }
}
