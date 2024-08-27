import 'package:chatapp/views/auth/widgets/sign_in_body.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size(12, 20),
            child: SizedBox(
              height: 20,
            )),
        body: SignInViewBody());
  }
}
