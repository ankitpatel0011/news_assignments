import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_assignments/screens/dashboard.dart';
import 'package:news_assignments/screens/login.dart';

import 'const/global_data.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToNextScreen();
    super.initState();
  }

  navigateToNextScreen() {
    Future.delayed(
      const Duration(seconds: 3),
          () {
        String? auth = FirebaseAuth.instance.currentUser?.uid;
        if (auth != null) {
          Get.offAll(() => const DashBoard());
        } else {
          Get.offAll(() =>  LoginPage());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFD8515B),
      body: Center(
        child: FadeInDown(
          child: Text(
            "News App",
            style: GoogleFonts.acme(
                color: Colors.white,fontSize: deviceWidth! * .1),
          ),
        ),
      ),
    );
  }
}
