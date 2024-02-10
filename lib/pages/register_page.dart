import 'package:firebase_chat_app/components/my_button.dart';
import 'package:firebase_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    void onRegister() {}
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
                MyButton(text: "Register", onTap: onRegister),
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
