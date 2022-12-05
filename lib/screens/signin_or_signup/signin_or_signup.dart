import 'package:chatapp/components/primary_button.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/screens/chats/chat_screen.dart';
import 'package:flutter/material.dart';

class SigninOrSignupScreen extends StatelessWidget {
  const SigninOrSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset(
                    "assets/images/Logo_light.png",
                height: 146,
              ),
              const Spacer(),
              PrimaryButton(
                text: "Sign In",
                press: () =>
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatsScreen(),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "Sign Up",
                press: () {},
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
