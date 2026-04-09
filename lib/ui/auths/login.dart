import 'package:blood_donate/logic/controllers/auth_controller.dart';
import 'package:blood_donate/ui/auths/register.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:blood_donate/ui/widgets/custom_auth.dart';
import 'package:blood_donate/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class Login extends StatelessWidget {
  Login({super.key});
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AllThemes.red,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * .2,
              width: double.infinity,
              decoration: BoxDecoration(color: AllThemes.red),
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: size.height * .05,
                        fontWeight: FontWeight.w500,
                        color: AllThemes.lightBg,
                      ),
                    ),
                    Text(
                      'Welcome back 👋',
                      style: GoogleFonts.poppins(
                        fontSize: size.height * .02,
                        fontWeight: FontWeight.w300,
                        color: AllThemes.lightBg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AllThemes.lightBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),

                child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.easeOutBack,
                    builder: (context,value,child){
                      return Opacity(
                        opacity: value.clamp(0.0, 1.0),
                        child: Transform.scale(
                            scale: 0.85 + (0.15 * value),
                            child:  Padding(
                              padding: const EdgeInsets.only(
                                left: 25,
                                right: 25,
                                top: 50,
                                bottom: 40,
                              ),
                              child: Form(
                                key: authController.loginKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Login textfield
                                    CustomAuth(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'Required';
                                        }if(GetUtils.isEmail(value)==false) {
                                          return 'Invalid email';
                                        }
                                        return null;
                                      },
                                      controller: authController.emailController,
                                      hintText: 'Enter your email',
                                      prefixIcon: Icon(
                                        Icons.alternate_email_rounded,
                                        color: AllThemes.lightText,
                                      ),
                                    ),
                                    SizedBox(height: size.height * .027),
                                    Obx(
                                          () => CustomAuth(
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return 'Required';
                                              }if(value.length<8){
                                                return 'Password must be at least 8 characters';
                                              }return null;
                                            },
                                            controller: authController.passwordController,
                                        hintText: 'Enter your password',
                                        suffixIcon: authController.isVisible.value
                                            ? Icons.lock_open_sharp
                                            : Icons.lock_outline,
                                        onSuffixTap: () => authController.changeVisibility(),
                                        obscureText: authController.isVisible.value
                                            ? false
                                            : true,
                                        prefixIcon: Icon(
                                          Icons.key,
                                          color: AllThemes.lightText,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * .03),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Forget password?',
                                          style: GoogleFonts.poppins(
                                            fontSize: size.height * .016,
                                            fontWeight: FontWeight.w500,
                                            color: AllThemes.lightText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * .02),
                                   Obx(()=> authController.isLoading.value?Center(
                                     child: CircularProgressIndicator(color: AllThemes.red,),
                                   ):CustomButton(
                                     onTap: (){
                                       if(authController.loginKey.currentState!.validate()) {
                                         authController.login();
                                       }
                                     },
                                     color: AllThemes.red,
                                     label: 'Login',
                                     labelColor: AllThemes.lightBg,
                                   ),),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account?",
                                          style: GoogleFonts.poppins(
                                            fontSize: size.height * .016,
                                            fontWeight: FontWeight.w500,
                                            color: AllThemes.lightGrey,
                                          ),
                                        ),
                                        SizedBox(width: size.height * .02),
                                        GestureDetector(
                                          onTap: (){
                                            Get.off(()=>Register(),duration: Duration(milliseconds: 500),
                                                transition: Transition.fadeIn,
                                                curve: Curves.easeIn
                                            );
                                          },
                                          child: Text(
                                            "Register",
                                            style: GoogleFonts.poppins(
                                              fontSize: size.height * .018,
                                              fontWeight: FontWeight.w500,
                                              color: AllThemes.lightText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * .02),
                                  ],
                                ),
                              ),
                            ),
                        ),
                      );
                    })


              ),
            ),
          ],
        ),
      ),
    );
  }

}
