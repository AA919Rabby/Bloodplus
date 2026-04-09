import 'package:blood_donate/logic/controllers/auth_controller.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BloodAuth extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final VoidCallback? onTap;

   BloodAuth({
    super.key,
    this.onSuffixTap,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.readOnly, this.onTap,
  });
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style:  GoogleFonts.poppins(
        color: AllThemes.lightText,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 3),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // suffixIcon: suffixIcon != null
        //     ? IconButton(
        //   icon: Icon(suffixIcon, color: AllThemes.lightText),
        //   onPressed: onSuffixTap,
        // )
        //     : null,
        floatingLabelStyle: GoogleFonts.poppins(color: Colors.black),
        hintStyle:GoogleFonts.poppins(color: authController.bloodData.isEmpty?
        AllThemes.lightGrey:AllThemes.lightText,fontSize: 16,fontWeight: FontWeight.w400,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:  BorderSide(color: AllThemes.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AllThemes.lightText,width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:  BorderSide(color:AllThemes.lightText, width: 1),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
    );
  }
}