import 'dart:io';
import 'package:efficio/screens/appscreens/todo_provider.dart';
import 'package:efficio/screens/loginscreen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:efficio/screens/appscreens/aboutus.dart';
import 'package:efficio/screens/appscreens/faqs.dart';
import 'package:efficio/screens/appscreens/supportus.dart';
// import 'package:path/path.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController username = TextEditingController();
  File? _image;
  User? _user; // Store the user object

  @override
  void initState() {
    super.initState();
    // Initialize the user object in initState
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // You'll need to handle uploading the image to Firebase Storage here
      // and then update the user's photoURL.  This part is not shown here
      // as it requires more code and Firebase Storage setup.
    }
  }

  Future<void> handleUsernameUpdate(
    String newUsername,
    BuildContext dialogContext,
    StateSetter setState, // Keep this for the dialog's setState
  ) async {
    setState(() => _user =
        FirebaseAuth.instance.currentUser); // Update user and trigger rebuild
    try {
      if (_user == null) {
        throw Exception('No user logged in');
      }

      await _user!.updateDisplayName(
          newUsername); // Use _user! as it can't be null here
      // Important: Update the user object after the Firebase update
      _user = FirebaseAuth.instance.currentUser;

      if (mounted) {
        setState(() {
          username.text = newUsername; // Update the local TextEditingController
        });

        // ignore: use_build_context_synchronously
        Navigator.of(dialogContext).pop();

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update username: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {}); // Rebuild to update loading state if you have one
      }
    }
  }
  // Future<void> _pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();

  //   if (pickedFile != null) {
  //     // prefs.setString('imagePath', pickedFile.path);
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final todoprovider = Provider.of<Todoprovider>(context);
    // String name = user?.displayName ?? "";
    // bool isLoading = false;

    // Future<void> updateUsername(String newName) async {
    //   final scaffoldMessenger = ScaffoldMessenger.of(context);

    //   if (newName.trim().isEmpty) {
    //     scaffoldMessenger.showSnackBar(
    //         const SnackBar(content: Text('Username cannot be empty')));
    //     return;
    //   }

    //   try {
    //     await user?.updateDisplayName(newName);
    //     username.text = newName; // Update the local TextEditingController
    //     scaffoldMessenger.showSnackBar(
    //         const SnackBar(content: Text('Username updated successfully')));
    //   } catch (e) {
    //     scaffoldMessenger.showSnackBar(
    //         SnackBar(content: Text('Error updating username: $e')));
    //   }
    // // }
    // Future<void> handleUsernameUpdate(
    //   String newUsername,
    //   BuildContext dialogContext,
    //   StateSetter setState,
    //   TextEditingController controller,
    // ) async {
    //   // setState(() => isLoading = true);

    //   try {
    //     if (user == null) {
    //       throw Exception('No user logged in');
    //     }

    //     await user.updateDisplayName(newUsername);

    //     if (mounted) {
    //       setState(() {
    //         username.text = newUsername;
    //       });

    //       // ignore: use_build_context_synchronously
    //       Navigator.of(dialogContext).pop();

    //       // ignore: use_build_context_synchronously
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('Username updated successfully')),
    //       );
    //     }
    //   } catch (e) {
    //     if (mounted) {
    //       // ignore: use_build_context_synchronously
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Failed to update username: $e')),
    //       );
    //     }
    //   } finally {
    //     if (mounted) {
    //       setState(() => user?.updateDisplayName(newUsername));
    //     }
    //   }
    // }
    // // setState(() {
    // //   name = user?.displayName ?? "";
    // // });

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Profile'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CircleAvatar(
                    foregroundImage: _image != null ? FileImage(_image!) : null,
                    radius: 70,
                    // Use a NetworkImage if you have a photoURL
                    backgroundImage: _user?.photoURL != null
                        ? NetworkImage(_user!.photoURL!)
                        : null,
                    child: _image == null && _user?.photoURL == null
                        ? Icon(Icons.person)
                        : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _user?.displayName ?? '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(Size(150, 50)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          backgroundColor: WidgetStateProperty.all(
                            Color.fromRGBO(54, 54, 54, 1),
                          ),
                        ),
                        child: Text(
                          '${todoprovider.taskslength()} Tasks Left',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(Size(150, 50)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          backgroundColor: WidgetStateProperty.all(
                            Color.fromRGBO(54, 54, 54, 1),
                          ),
                        ),
                        child: Text(
                          '5 Tasks Done',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                            color: Color.fromRGBO(100, 100, 100, 1),
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SettingTiles(
                    icon: Icons.settings,
                    title: 'App Settings',
                    fn: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Account',
                        style: TextStyle(
                            color: Color.fromRGBO(100, 100, 100, 1),
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SettingTiles(
                    icon: FontAwesome.user_astronaut_solid,
                    title: 'Change Account Name',
                    fn: () {
                      final TextEditingController usernameController =
                          TextEditingController();
                      bool isLoading = false;

                      // Pre-fill with current username
                      usernameController.text = user?.displayName ?? '';

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext dialogContext) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                backgroundColor: Colors.black87,
                                title: Text(
                                  'Update Username',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: TextField(
                                  controller: usernameController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'New Username',
                                    hintText: 'Enter your new username',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  enabled: !isLoading,
                                  autofocus: true,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (value) {
                                    if (!isLoading && value.trim().isNotEmpty) {
                                      handleUsernameUpdate(
                                        value.trim(),
                                        dialogContext,
                                        setState,
                                      );
                                    }
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      final newUsername =
                                          usernameController.text.trim();
                                      if (newUsername.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Username cannot be empty'),
                                          ),
                                        );
                                        return;
                                      }
                                      handleUsernameUpdate(
                                        newUsername,
                                        dialogContext,
                                        setState,
                                      );
                                    },
                                    child: Text(
                                      'Update',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  SettingTiles(
                    icon: FontAwesome.key_solid,
                    title: 'Change Account Password',
                    fn: () {
                      {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final formKey = GlobalKey<FormState>();
                            final newPasswordController =
                                TextEditingController();
                            final confirmPasswordController =
                                TextEditingController();
                            bool isLoading = false;
                            String errorMessage = '';

                            return StatefulBuilder(
                                // Use StatefulBuilder for state management within the dialog
                                builder: (context, setState) {
                              // Get setState function for the dialog
                              return AlertDialog(
                                backgroundColor: Colors.black87,
                                title: Text('Change Password',
                                    style: TextStyle(color: Colors.white)),
                                content: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Important for dialogs
                                    children: [
                                      TextFormField(
                                        controller: newPasswordController,
                                        obscureText: true,
                                        style: TextStyle(
                                            color: Colors.white), // Text color
                                        decoration: InputDecoration(
                                          labelText: 'New Password',
                                          labelStyle: TextStyle(
                                              color:
                                                  Colors.grey), // Label color
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .grey)), // Underline color
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .blue)), // Focused underline
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your new password';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: confirmPasswordController,
                                        obscureText: true,
                                        style: TextStyle(
                                            color: Colors.white), // Text color
                                        decoration: InputDecoration(
                                          labelText: 'Confirm New Password',
                                          labelStyle: TextStyle(
                                              color:
                                                  Colors.grey), // Label Color
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .grey)), // Underline color
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .blue)), // Focused underline
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please confirm your new password';
                                          }
                                          if (value !=
                                              newPasswordController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      if (errorMessage.isNotEmpty)
                                        Text(
                                          errorMessage,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      SizedBox(height: 10),
                                      isLoading
                                          ? CircularProgressIndicator()
                                          : ElevatedButton(
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    isLoading = true;
                                                    errorMessage = '';
                                                  });

                                                  try {
                                                    User? user = FirebaseAuth
                                                        .instance.currentUser;
                                                    if (user != null) {
                                                      await user.updatePassword(
                                                          newPasswordController
                                                              .text);
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'Password changed successfully')),
                                                      );
                                                    } else {
                                                      setState(() {
                                                        errorMessage =
                                                            'User not found. Please re-login.';
                                                      });
                                                    }
                                                  } on FirebaseAuthException catch (e) {
                                                    setState(() {
                                                      errorMessage =
                                                          'Error changing password: ${e.message}';
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      errorMessage =
                                                          'An error occurred: $e';
                                                    });
                                                  } finally {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  }
                                                }
                                              },
                                              child: Text('Change Password'),
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      }
                    },
                  ),
                  SettingTiles(
                    icon: FontAwesome.camera_retro_solid,
                    title: 'Change Account Image',
                    fn: _pickImage,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Uptodo',
                        style: TextStyle(
                            color: Color.fromRGBO(100, 100, 100, 1),
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SettingTiles(
                    icon: FontAwesome.business_time_solid,
                    title: 'About US',
                    fn: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsPage()));
                    },
                  ),
                  SettingTiles(
                    icon: FontAwesome.info_solid,
                    title: 'FAQ',
                    fn: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FAQPage()));
                    },
                  ),
                  SettingTiles(
                    icon: FontAwesome.thumbs_up_solid,
                    title: 'Support US',
                    fn: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SupportUsPage()));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginscreen()));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Logout Error: ${e.message}")),
                          );
                        }
                      }
                    },
                    leading: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: Text('Log out'),
                    titleTextStyle: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingTiles extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback fn;

  const SettingTiles(
      {super.key, required this.icon, required this.title, required this.fn});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: fn,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(title),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      trailing: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }
}
