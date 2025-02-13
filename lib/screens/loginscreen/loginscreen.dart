import 'package:efficio/screens/appscreens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:efficio/screens/loginscreen/customtxtfield.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:efficio/screens/signupscreen/newaccount.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final formKey = GlobalKey<FormState>();
  // final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signinEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Homepage()));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Logged in Successfully"),
            backgroundColor: Colors.deepPurpleAccent,
          ));
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("An Error Occured!! Please try again"),
              backgroundColor: Colors.deepPurpleAccent,
            ));
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      String errormessage;
      switch (e.code) {
        case 'invalid-email':
          errormessage = 'The email address is badly formatted.';
          break;
        case 'user-not-found':
          errormessage = 'No user found for that email.';

          break;
        case 'wrong-password':
          errormessage = 'Wrong password provided for that user.';

          break;
        case 'user-disabled':
          errormessage = 'This account has been disabled.';

          break;
        case 'too-many-requests':
          errormessage = 'Too many attempts. Try again later.';

          break;
        case 'operation-not-allowed':
          errormessage = 'Email/Password auth is not enabled.';

          break;
        default:
          errormessage = 'The email address is badly formatted.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errormessage),
          backgroundColor: Colors.deepPurpleAccent,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Text(
                "Login",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomtxtField(
                        labeltext: 'Email',
                        hintTt: 'Enter Email',
                        controller: emailController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Email";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please Enter a valid email.";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    CustomtxtField(
                        labeltext: 'Password',
                        hintTt: 'Enter your password',
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your User name";
                          }
                          if (value.length < 6) {
                            return "Password must be atleaast 6 chracters long!!";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    SizedBox(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.85,
                      child: ElevatedButton(
                        onPressed: () {
                          signinEmailPassword(
                              emailController.text, passwordController.text);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.deepPurpleAccent),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                        ),
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.85,
                      child: ScoialButtons(
                          text: "Login with Google", icon: Brands.google),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.85,
                      child: ScoialButtons(
                          text: "Login with Facebook", icon: Brands.facebook),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.85,
                      child: ScoialButtons(
                          text: "Login with Apple", icon: Brands.apple_logo),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Newaccount()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScoialButtons extends StatelessWidget {
  final String text;
  final String icon;

  const ScoialButtons({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black87),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: Colors.deepPurpleAccent, width: 2),
          ),
        ),
      ),
      icon: Brand(icon),
      label: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
