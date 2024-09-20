import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_firebase/auth/firebase_auth/firebase_auth_services.dart';
import 'package:todo_app_with_firebase/auth/login_screen.dart';
import 'package:todo_app_with_firebase/widget/button_widget.dart';
import 'package:todo_app_with_firebase/widget/textfield_widget.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


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
          child: Icon(CupertinoIcons.back),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xfff7f7f9),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign up now',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please fill the details and create account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 55,
                ),
                CustomTextfield(
                  title: 'Name',
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextfield(
                  title: 'Email',
                  controller: _emailController,
                ),
                SizedBox(
                  height: 24,
                ),
                CustomTextfield(
                  title: 'Password',
                  controller: _passwordController,
                  isPasswordField: true,
                ),
                SizedBox(
                  height: 55,
                ),
                InkWell(
                  onTap: () {
                    _signup();
                  },
                  child: CustomButton(
                    buttonColor: Color(0xff0d6efd),
                    width: 335,
                    height: 56,
                    title: 'Sign up',
                    fontColor: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => LoginScreen())),
                      },
                      child: Text(
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
      print("Some Error Occure");
    }
  }
}