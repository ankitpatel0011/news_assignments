import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../splash.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () async {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    confirmBtnText: "Yes",
                    cancelBtnText: "No",
                    showCancelBtn: true,
                    showConfirmBtn: true,
                    title: "Are you sure you want to log out",
                    onConfirmBtnTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => const SplashScreen());
                    },
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                  );
                },
                child: Icon(Icons.logout)),
          )
        ],
        title: Center(
          child: Text(
            'Logout',
            style: GoogleFonts.acme(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: Get.height*0.4,width: Get.width*0.8,
          child: Card(
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("data")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
