import 'package:firebase_chat_app/auth/auth_service.dart';
import 'package:firebase_chat_app/components/my_button.dart';
import 'package:firebase_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void onLogin(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          Expanded(
            child: Center(
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
                    height: 25,
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
                  // button login
                  MyButton(text: "Login", onTap: () => onLogin(context)),
                  const SizedBox(
                    height: 15,
                  ),
                  // register now link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member? ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: Text(
                          "Register now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
