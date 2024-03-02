import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logic_app/components/LoginPageComponents.dart';
import 'package:logic_app/helper/ApiHelper.dart';
import 'package:logic_app/views/utils/ImageUtils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _shakeKey = GlobalKey<ShakeWidgetState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String email = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String version = 'app';
    String from = 'app';

    Map<String, dynamic> response = await APIHelper.apiHelper.fetchPassword(email, password, version, from);

    if (response != null && response.containsKey('success')) {
      if (response['success'] == 1) {
        log('Authentication successful: $response');
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      } else {
        log('Authentication failed');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect username or password'),
            duration: Duration(seconds: 2),
          ),
        );
        _shakeKey.currentState?.shake();
      }
    } else {
      log('Unexpected response from API');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
      _shakeKey.currentState?.shake();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const Center(
                child: Text(
                  'Sign in to unlock exclusive features and personalized content',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              AuthField(
                controller: _usernameController,
                hintText: 'Enter Username',
              ),
              const SizedBox(height: 30),
              AuthField(
                controller: _passwordController,
                hintText: 'Enter Password',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  text: 'Forget Password?',
                ),
              ),
              const SizedBox(height: 20),
              ShakeWidget(
                key: _shakeKey,
                shakeOffset: 10.0,
                shakeDuration: const Duration(milliseconds: 500),
                child: PrimaryButton(
                  onTap: () async {
                    await _login();
                  },
                  text: 'Login',
                ),
              ),
              const SizedBox(height: 20),
              const DividerWithText(),
              const SizedBox(height: 20),
              CustomSocialButton(
                onTap: () {},
                icon: AppAssets.kFaceBook,
                text: 'Join using Facebook',
                margin: 0,
              ),
              const SizedBox(height: 20),
              CustomSocialButton(
                onTap: () {},
                icon: AppAssets.kGoogle,
                text: 'Join using Google',
                margin: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
