import 'package:blood_donate/logic/controllers/home_controller.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchtextfield extends StatelessWidget {
  Searchtextfield({super.key});
  final homeController = Get.find<HomeController>(); // Use find if already put

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .08,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AllThemes.lightBg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          homeController.updateSearchQuery(value);
        },
        style: GoogleFonts.poppins(
          color: AllThemes.lightText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 20, right: 10, left: 12),
          border: InputBorder.none,
          hintText: 'Search city...',
          hintStyle: GoogleFonts.poppins(
            color: AllThemes.lightText.withOpacity(0.5),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: AllThemes.red,
            size: size.height * .035,
          ),
          suffixIcon: Obx(() => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: homeController.selectedBloodQuery.value.isEmpty
                  ? 'All'
                  : homeController.selectedBloodQuery.value,
              icon: Icon(
                Icons.arrow_drop_down_sharp,
                color: AllThemes.red,
                size: size.height * .04,
              ),
              borderRadius: BorderRadius.circular(15),
              items: <String>['All', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  homeController.updateBloodFilter(val == 'All' ? '' : val);
                }
              },
            ),
          )),
        ),
      ),
    );
  }
}