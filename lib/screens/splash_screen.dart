import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/controllers/splash_controller.dart';
// import 'package:grocery_plus/controllers/splash_controller.dart';
// import 'package:grocery_plus/screens/bottom_Nav_bar.dart';
// import 'package:grocery_plus/screens/login_screen.dart';

class SplashScreen extends StatefulWidget { 
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "images/splash_image.jpg",
              height: 100,
              width: 200,
            ),
          ),
          Text("Grocery Plus",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}