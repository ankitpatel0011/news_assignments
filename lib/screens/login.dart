import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_assignments/screens/register.dart';
import 'package:news_assignments/screens/user_exists.dart';

import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email, _password;

  //Controller with email & Password //
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Button click isLoading variable //
  bool isLoading = false;

  // Password variable visible show & off //
  bool passwordVisible = false;

  //Login With Email Password//
  loginWithEmailAndPassword() async {
    var auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);
      Fluttertoast.showToast(msg: "Login Successful", textColor: Colors.blue);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashBoard()));
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid email and password");
    }
    var uId = FirebaseAuth.instance.currentUser?.uid;
    bool userExists = await checkUserExists(uId!);
    if (userExists) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoard(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterScreen(),
          ));
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.focused,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  var checkResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8515B),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
                child: Text(
              'Sign In',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 45),
            child: Text(
              'Email',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
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
                  controller: email,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.blue),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 45),
            child: Text(
              'Password',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
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
                  controller: password,
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
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 180),
            child: TextButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpasswordpage(),));
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              children: [
                Checkbox(
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  activeColor: Colors.white,
                  checkColor: Colors.blueAccent,
                  value: checkResult,
                  onChanged: (result) {
                    setState(() {
                      checkResult = result!;
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Remember me',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          // Login  Button Click isLoading and Progressbar show Inside //
          InkWell(
            onTap: checkResult ? () async {
              setState(() {
                isLoading = true;
                loginWithEmailAndPassword();
              });
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  isLoading = false;
                });
              });
            }:null,
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),  color: checkResult ? Colors.white : Colors.grey,),
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
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ),

          // end  //
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              '- OR -',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'Sign In with',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox  for the FacebookAuth //
              SizedBox(
                height: 60,
                width: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        //border radius equal to or more than 50% of width
                      )),
                  child: const Image(
                      image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/128/2111/2111393.png')),
                ),
              ),
              const SizedBox(
                width: 30,
              ),

              // SizedBox  for the GoogleAuth //
              SizedBox(
                height: 60,
                width: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        //border radius equal to or more than 50% of width
                      )),
                  child: const Image(
                      image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/128/281/281764.png')),
                ),
              ),
              const SizedBox(
                width: 30,
              ),

              //SizedBox  for the PhoneAuth //
              SizedBox(
                height: 60,
                width: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        //border radius equal to or more than 50% of width
                      )),
                  child: const Image(
                      image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/128/10797/10797331.png')),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't  have an Account?",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ));
                },
                child: const Text(
                  'Register',
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
    );
  }
}
