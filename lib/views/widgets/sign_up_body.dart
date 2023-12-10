import 'package:chatapp/views/home_veiw.dart';
import 'package:chatapp/views/widgets/custom_button.dart';
import 'package:chatapp/views/widgets/custom_text_from_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _formKey = GlobalKey<FormState>();
  String? username;

  String? emailAddress;
  String? password;
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
                "Sign Up",
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
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Your User Name",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextFeild(
                              hintText: "Username",
                              onChange: (data) {
                                username = data;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
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
                              hintText: "*********",
                              onChange: (data) {
                                password = data;
                              }),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text("alraedy have an account ?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(" Sign In",
                                    style: TextStyle(color: Colors.blue)),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      customBottum(
                        text: "Sign Up",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailAddress!,
                                password: password!,
                              );
                              FirebaseAuth.instance.currentUser!
                                  .updateDisplayName(username);

                              showSnacBar(
                                  context: _formKey.currentContext,
                                  data: "Sign_up success!");

                              Navigator.pushReplacement(
                                  _formKey.currentContext!,
                                  MaterialPageRoute(builder: (context) {
                                return HomeView();
                              }));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showSnacBar(
                                    context: _formKey.currentContext,
                                    data: 'The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                showSnacBar(
                                    context: _formKey.currentContext,
                                    data:
                                        'The account already exists for that email.');
                              }
                            } catch (e) {
                              showSnacBar(
                                  context: _formKey.currentContext,
                                  data: e.toString());
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

showSnacBar({BuildContext? context, String? data}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(data!)));
}
