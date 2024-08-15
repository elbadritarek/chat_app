import 'package:chatapp/views/Sign_up_view.dart';
import 'package:chatapp/views/home_veiw.dart';
import 'package:chatapp/views/widgets/custom_button.dart';
import 'package:chatapp/views/widgets/custom_text_from_feild.dart';
import 'package:chatapp/views/widgets/sign_up_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  String? emailAddress;

  String? password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/icon.png',
                height: 100,
              ),
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
              child: Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(18), left: Radius.circular(18))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Your Email",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customTextFeild(
                        textController: TextEditingController(),
                          hintText: "Example@gmail.com",
                          onChange: (data) {
                            emailAddress = data;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Your Password",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customTextFeild(
                        textController: TextEditingController(),
                          hintText: "*********",
                          onChange: (data) {
                            password = data;
                          }),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("don't have an account ?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SignUpView();
                              }));
                            },
                            child: const Text(" Sign Up",
                                style: TextStyle(color: Colors.blue)),
                          )
                        ],
                      ),
                    ],
                  ),
                  customBottum(
                    text: "Sign In",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailAddress!, password: password!);
                          showSnacBar(
                              context: _formKey.currentContext,
                              data: "Sign In success");
                          Navigator.pushReplacement(_formKey.currentContext!,
                              MaterialPageRoute(builder: (context) {
                            return HomeView(
                              user: credential.user!,
                            );
                          }));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnacBar(
                                context: _formKey.currentContext,
                                data: 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnacBar(
                                context: _formKey.currentContext,
                                data: 'Wrong password provided for that user.');
                          }
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
