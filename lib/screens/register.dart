import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_assignments/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String _password;

  // Password variable visible show & off //
  bool passwordVisible = false;

  // Button click isLoading variable //
  bool isLoading = false;

  // Controller for Field //
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  //using this code for name validation for RegExp //
  final RegExp _nameRegExp =
      RegExp(r'^[a-zA-Z ]+$'); // Regular expression for valid name
  bool _isNameValid = true;

  void _validateName(String name) {
    setState(() {
      _isNameValid = _nameRegExp.hasMatch(name);
    });
  }

  //using this code for Email validation for RegExp //
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ); // Regular expression for valid email
  bool _isEmailValid = true;

  void _validateEmail(String email) {
    setState(() {
      _isEmailValid = _emailRegExp.hasMatch(email);
    });
  }

  // final RegExp _numberRegExp = RegExp(r'^[0-9]+$'); // Regular expression for valid numbers
  // bool _isNumberValid = true;
  // void _validateNumber(String number) {
  //   setState(() {
  //     _isNumberValid = _numberRegExp.hasMatch(number);
  //   });
  // }

  //for store in database user of id and phone number
  String? uid = "";
  int? number;

  //getData fun call and password visible variable call//
  @override
  void initState() {
    super.initState();
    getData();
    passwordVisible = true;
  }

  // Create a Function getData() to get data to sharedPreferences //
  Future getData() async {
    var sharePrefs = await SharedPreferences.getInstance();
    setState(() {
      number = sharePrefs.getInt('number');
      uid = sharePrefs.getString('uid');
    });
  }

  //check if user not fill data before click on submit button //
  passwordValidateForm() {
    if (_passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'number is empty');
    } else if (_passwordController.text.length < 8) {
      Fluttertoast.showToast(msg: 'Password must be 8 character');
    } else if (!_passwordController.text.contains(RegExp(r'[a-z]'))) {
      Fluttertoast.showToast(msg: 'Password should be mix of  lowercase');
    } else if (!_passwordController.text.contains(RegExp(r'[A-Z]'))) {
      Fluttertoast.showToast(msg: 'Password should be mix of uppercase');
    } else if (!_passwordController.text.contains(RegExp(r'[0-9]'))) {
      Fluttertoast.showToast(msg: 'Number is required in password');
    } else if (!_passwordController.text.contains(RegExp(r'[@,!,#,%,&,*$,]'))) {
      Fluttertoast.showToast(msg: 'Special Character is required in password');
    }else {
      userEmailAuth();
    }
  }

  // Email and Password Authentication //
  userEmailAuth() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      userDataStore();
    });
  }

// user data Store in firebase fireStore //
  userDataStore() {
    var auth = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection("users").doc(auth).set({
      "userId": FirebaseAuth.instance.currentUser?.uid,
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
    }).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashBoard(),
        ),
      );
      Fluttertoast.showToast(msg: 'Register Successfully');
    }).catchError((error) {
      Fluttertoast.showToast(msg: 'Register Failed');
    });
  }


// end //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8515B),
      body: ColorfulSafeArea(
        color: const Color(0xFFD8515B),
        child: ListView(
          children: [
            // Image.asset(
            //   'assets/images/auth_screen_top.png',
            // ),
            const Padding(
              padding: EdgeInsets.only(top: 58),
              child: Center(
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: SizedBox(
                height: 65,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  shadowColor: Colors.blue,
                  elevation: 15,
                  child: TextFormField(
                    controller: _nameController,
                    onChanged: _validateName,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.blue),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      errorText: _isNameValid ? null : 'Invalid name',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: CupertinoColors.systemBlue,
                      ),
                      hintText: "Enter your Name",
                      hintStyle: const TextStyle(color: Colors.blue),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1, //<-- SEE HERE
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: SizedBox(
                height: 65,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  shadowColor: Colors.blue,
                  elevation: 15,
                  child: TextFormField(
                    controller: _emailController,
                    onChanged: _validateEmail,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.blue),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorText: _isEmailValid ? null : 'Invalid email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: CupertinoColors.systemBlue,
                      ),
                      hintText: "Enter your Email",
                      hintStyle: const TextStyle(color: Colors.blue),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1, //<-- SEE HERE
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: SizedBox(
                height: 65,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  shadowColor: Colors.blue,
                  elevation: 15,
                  child: TextFormField(
                    controller: _passwordController,
                    cursorColor: Colors.blue,
                    obscureText: passwordVisible,
                    style: const TextStyle(color: Colors.blue),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: CupertinoColors.systemBlue,
                      ),
                      hintText: "Enter your Password",
                      hintStyle: const TextStyle(color: Colors.blue),

                      // Password Visible and Not Visible //
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      alignLabelWithHint: false,
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1, //<-- SEE HERE
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                    // call the function user store data in firebase //
                  });
                });
                passwordValidateForm();
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: Center(
                  child: InkWell(
                    child: isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Loading...',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ],
                          )
                        : const Text(
                            'REGISTER',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an Account?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
