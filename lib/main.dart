import 'package:blood_donate/firebase_options.dart';
import 'package:blood_donate/ui/auths/login.dart';
import 'package:blood_donate/ui/auths/register.dart';
import 'package:blood_donate/ui/screens/add_donate.dart';
import 'package:blood_donate/ui/screens/bottomnav_screen.dart';
import 'package:blood_donate/ui/screens/edit_profile.dart';
import 'package:blood_donate/ui/screens/emergency.dart';
import 'package:blood_donate/ui/screens/intro_screen.dart';
import 'package:blood_donate/ui/themes/all_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   scaffoldBackgroundColor: AllThemes.lightBg,
      //   primaryColor: AllThemes.red,
      //   colorScheme: ColorScheme.light(primary: AllThemes.red),
      // ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   scaffoldBackgroundColor: AllThemes.darkBg,
      //   primaryColor: AllThemes.red,
      //   colorScheme: ColorScheme.dark(primary: AllThemes.red),
      // ),
      // themeMode: ThemeMode.system,


      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color(0xFFF2F2F2), // Light greyish-white background
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212), // Pitch black background
      ),

      themeMode: ThemeMode.light,

      home: IntroScreen(),

    );
  }
}
