import 'package:flutter/material.dart';
import 'package:minimal_app/services/auth/auth_service.dart';
import 'package:minimal_app/components/my_button.dart';
import 'package:minimal_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.forum_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                hintText: "Email",
                focusNode: null,
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                focusNode: null,
                hintText: "Password",
                obscureText: true,
                controller: pwController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                focusNode: null,
                hintText: "Confirm password",
                obscureText: true,
                controller: confirmPwController,
              ),
              const SizedBox(height: 25.0),
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account! ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void register(BuildContext context) {
    final _authService = AuthService();
    if (pwController.text == confirmPwController.text) {
      try {
        _authService.signUpWithEmailPassword(
            emailController.text.trim(), pwController.text.trim());
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match"),
        ),
      );
    }
  }
}
