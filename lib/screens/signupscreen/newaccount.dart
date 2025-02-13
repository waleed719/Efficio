import 'package:efficio/screens/appscreens/homepage.dart';
import 'package:efficio/screens/loginscreen/customtxtfield.dart';
import 'package:efficio/screens/loginscreen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Newaccount extends StatefulWidget {
  const Newaccount({super.key});

  @override
  State<Newaccount> createState() => _NewaccountState();
}

class _NewaccountState extends State<Newaccount> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // Future<void> signupWithEmailAndPassword(
  //     String name, String email, String password) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     await userCredential.user?.updateDisplayName(name);
  //     await userCredential.user?.reload();

  //     // Check if the widget is still mounted before showing the SnackBar
  //     if (mounted) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => Homepage()));
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('User registered successfully'),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     String errorMessage;
  //     switch (e.code) {
  //       case 'invalid-email':
  //         errorMessage = 'The email address is not valid.';
  //         break;
  //       case 'user-disabled':
  //         errorMessage = 'This user has been disabled.';
  //         break;
  //       case 'user-not-found':
  //         errorMessage = 'No user found with this email.';
  //         break;
  //       case 'wrong-password':
  //         errorMessage = 'Incorrect password.';
  //         break;
  //       default:
  //         errorMessage = 'An unexpected error occurred. Please try again.';
  //     }

  //     // Check if the widget is still mounted before showing the SnackBar
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(errorMessage),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     // Handle any other errors
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('An error occurred. Please try again.'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }

  Future<void> signupWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      // Sign up the user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Set the display name for the new user
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();

      // After successful signup, check if the user is authenticated
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // If user is logged in, navigate to Homepage
        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Homepage()));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registered and logged in successfully'),
              backgroundColor: Colors.deepPurpleAccent,
            ),
          );
        }
      } else {
        // If the user is not logged in after signup, show an error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('An error occurred during login. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle any other errors
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive font size calculations
    final double titleFontSize = screenWidth * 0.07;
    final double buttonFontSize = screenWidth * 0.04;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Create New Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize.clamp(24, 34),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomtxtField(
                        labeltext: 'UserName',
                        hintTt: 'Enter UserName',
                        controller: usernameController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your UserName";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),
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
                        },
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      CustomtxtField(
                        labeltext: 'Password',
                        hintTt: 'Enter your password',
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters long!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.065,
                        child: ElevatedButton(
                          onPressed: () async {
                            await signupWithEmailAndPassword(
                                usernameController.text,
                                emailController.text,
                                passwordController.text);
                            // if (mounted) {
                            //   Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => Homepage()));
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Create New Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: buttonFontSize.clamp(16, 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
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
                SizedBox(height: screenHeight * 0.04),
                Column(
                  children: [
                    _buildSocialButton(
                      "Continue with Google",
                      Brands.google,
                      context,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSocialButton(
                      "Continue with Facebook",
                      Brands.facebook,
                      context,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildSocialButton(
                      "Continue with Apple",
                      Brands.apple_logo,
                      context,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Loginscreen(),
                            ),
                          );
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: buttonFontSize.clamp(14, 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, dynamic icon, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: screenWidth * 0.15,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.deepPurpleAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Brand(icon, size: screenWidth * 0.06),
        label: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.035,
          ),
        ),
      ),
    );
  }
}
