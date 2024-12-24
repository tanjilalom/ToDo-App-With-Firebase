import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_firebase/auth/firebase_auth/firebase_auth_services.dart';
import 'package:todo_app_with_firebase/auth/signup_screen.dart';
import 'package:todo_app_with_firebase/widget/button_widget.dart';
import 'package:todo_app_with_firebase/widget/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Login now',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Please Login to continue our app',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                  CustomTextfield(
                    title: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextfield(
                    title: 'Password',
                    controller: _passwordController,
                    isPasswordField: true,
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  InkWell(
                    onTap: () {
                      _login();
                    },
                    child: const CustomButton(
                      buttonColor: Color(0xff0d6efd),
                      width: 335,
                      height: 56,
                      radius: 12,
                      title: 'Sign in',
                      fontColor: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const SignupScreen()));
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff0d6efd),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.loginWithEmailAndPassword(email, password);

    if (user != null) {
      debugPrint("User is successfully login");
      Get.toNamed('/home');
      Get.snackbar('Clicked', 'Login Successfully');
    } else {
      debugPrint("Some Error Occur");
      Get.snackbar('Sorry', 'Please Enter A Correct Email and Password');
    }
  }
}
