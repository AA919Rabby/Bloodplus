import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButton extends StatelessWidget {
  String label;
  Color color;
  Color ?labelColor;
  VoidCallback? onTap;
  VoidCallback? onPressed;
  CustomButton({
    required this.color,
    required this.label,
    this.onTap,
    this.onPressed,
    this.labelColor,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? onTap,
      child: Container(
        height: 46,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AllThemes.lightGrey.withOpacity(0.03),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            label,style: GoogleFonts.poppins(
            color: labelColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          ),
        ),
      ),
    );
  }
}

