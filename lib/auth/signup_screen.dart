import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_firebase/auth/firebase_auth/firebase_auth_services.dart';
import 'package:todo_app_with_firebase/auth/login_screen.dart';
import 'package:todo_app_with_firebase/widget/button_widget.dart';
import 'package:todo_app_with_firebase/widget/textfield_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: TextButton(
          //onPressed: () => Get.back(),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xfff7f7f9),
          ),
          child: const Icon(CupertinoIcons.back),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign up now',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Please fill the details and create account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 55,
                ),
                CustomTextfield(
                  title: 'Name',
                  controller: _usernameController,
                ),
                const SizedBox(
                  height: 24,
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
                  height: 55,
                ),
                InkWell(
                  onTap: () {
                    _signup();
                  },
                  child: const CustomButton(
                    buttonColor: Color(0xff0d6efd),
                    width: 335,
                    height: 56,
                    title: 'Sign up',
                    fontColor: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const LoginScreen())),
                      },
                      child: const Text(
                        'Sign in',
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
    );
  }

  void _signup() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");
      Get.toNamed('/login');
      Get.snackbar('Clicked', 'Signup Successfully');
    } else {
      print("Some Error Occur");
      Get.snackbar('Sorry', 'Some Error Occurred');
    }
  }
}
