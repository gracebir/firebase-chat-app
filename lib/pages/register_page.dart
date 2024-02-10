import 'package:firebase_chat_app/services/auth/auth_service.dart';
import 'package:firebase_chat_app/components/my_button.dart';
import 'package:firebase_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();
  void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void onRegister(BuildContext context) {
    if (_passwordController.text == _confirmPassword.text) {
      try {
        final authService = AuthService();
        authService.signUpWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Passwords don't match",
                  style: TextStyle(fontSize: 16),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //logo
                Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 60,
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "Welcome back you've been missed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                ),
                // email
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                // password
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  hintText: "Confirm password",
                  obscureText: true,
                  controller: _confirmPassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                // button login
                MyButton(text: "Register", onTap: () => onRegister(context)),
                const SizedBox(
                  height: 15,
                ),

                // register now link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Alreay have account? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        "Login now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
