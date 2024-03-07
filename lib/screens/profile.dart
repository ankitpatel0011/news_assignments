import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../model/usermodel.dart';
import '../splash.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

//get user data
UserModel? userModel;
var auth = FirebaseAuth.instance.currentUser?.uid;

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    retrieveData().then((value) {
      setState(() {
        userModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFD8515B),
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
            'LogOut',
            style: GoogleFonts.acme(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding:  EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height*0.4,
            child: Card(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.perm_identity),
                    title: Text("UserId:-${userModel?.userId}"),
                  ),
                  Divider(
                    height: 5,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("${userModel?.name}"),
                  ),
                  Divider(
                    height: 5,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("${userModel?.email}"),
                  ),
                  Divider(
                    height: 5,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.password),
                    title: Text("${userModel?.password}"),
                  ),
                ],
              ),
            ),
          ),
        ],

      ),
    );
  }

  Future<UserModel?> retrieveData() async {
    var uuid = FirebaseAuth.instance.currentUser?.uid;
    var user =
        await FirebaseFirestore.instance.collection("users").doc(uuid).get();
    var userModel = UserModel.fromJson(user.data()!);
    return userModel;
  }
}
