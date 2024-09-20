import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_firebase/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      //Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_) => LoginScreen()), (route) => false);
      Get.offUntil(GetPageRoute(page: () => LoginScreen()), (route) => false,);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'CARETUTORS',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
