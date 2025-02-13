import 'package:flutter/material.dart';
import 'package:efficio/screens/loginscreen/loginscreen.dart';
import 'package:efficio/screens/onboarding_screen/sign_in_up.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController pagecontroller;
  int currentpage = 0;

  @override
  void initState() {
    super.initState();
    pagecontroller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pagecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> title = [
      "Manage your tasks",
      "Create daily routine",
      "Organize your tasks",
    ];
    final List<String> discription = [
      "You can easily manage all of your daily\ntasks in DoMo for free",
      "In Uptodo you can create your\npersonalized routine to stay productive",
      "You can organize your daily tasks by\nadding your tasks into seperate categories",
    ];
    final List<String> images = [
      'assests/splash_images/image 1.png',
      'assests/splash_images/image 2.png',
      'assests/splash_images/image 3.png',
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Signinup()));
          },
          child: Text(
            "Skip",
            style: TextStyle(color: Colors.white54),
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pagecontroller,
                  itemCount: title.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentpage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Placeholder(
                            strokeWidth: -1,
                            fallbackHeight: 300,
                            fallbackWidth: double.infinity,
                            child: Image(
                              image: AssetImage(images[index]),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            title[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            discription[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: currentpage == 0
                          ? null
                          : () {
                              pagecontroller.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                      child: Text(
                        "Back",
                        style: TextStyle(fontSize: 18, color: Colors.white54),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        if (currentpage == title.length - 1) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Loginscreen()));
                        } else {
                          pagecontroller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.deepPurpleAccent),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1)))),
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
