import 'package:chatapp/views/auth/widgets/sign_up_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(12, 20),
            child: SizedBox(
              height: 20,
            )),
        body: SignUpViewBody());
  }
}
