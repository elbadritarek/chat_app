
import 'package:chatapp/controllers/auth_controllers.dart';
import 'package:chatapp/services/auth/firebase_services.dart';
import 'package:chatapp/views/Home/home_veiw.dart';
import 'package:chatapp/views/Shared_widgets/custom_button.dart';
import 'package:chatapp/views/Shared_widgets/custom_text_from_feild.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  final AuthController _authController = AuthController(FirebaseAuthService());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            children: [
              Image.asset('assets/images/icon.png', height: 100),
              const Text("Sign Up", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(height: 60),
          Expanded(
            child: Container(
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(18),
                  left: Radius.circular(18),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Row(
                            children: [
                              Text("Your Username", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          customTextFeild(
                            textController: TextEditingController(),
                            hintText: "Username",
                            onChange: (data) {
                              username = data;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Text("Your Email", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          customTextFeild(
                            textController: TextEditingController(),
                            hintText: "Example@gmail.com",
                            onChange: (data) {
                              emailAddress = data;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Text("Your Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          customTextFeild(
                            textController: TextEditingController(),
                            hintText: "*********",
                            flag: true,
                            onChange: (data) {
                              password = data;
                            },
                          ),
                        ],
                      ),
                      customBottum(
                        text: "Sign Up",
                        onTap: () async {
                          _authController.signUp(
                            username: username!,
                            email: emailAddress!,
                            password: password!,
                            formKey: _formKey,
                            context: context,
                            onSuccess: (User user) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return HomeView(user: user);
                              }));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
