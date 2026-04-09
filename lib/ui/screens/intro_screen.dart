import 'package:blood_donate/logic/controllers/screens_controller.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';



class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});
  final screensController=Get.put(ScreensController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AllThemes.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/bd.jpg',
              height: size.height*0.27,
              width: size.width*0.28,
              fit: BoxFit.contain,
            ),
            Text('BloodPLus',style: GoogleFonts.poppins(
              fontSize:size.height*.03,
              fontWeight: FontWeight.bold,
              color: AllThemes.lightBg,
              letterSpacing: 2,
            )),
          ],
        ),
      ),
    );
  }
}
