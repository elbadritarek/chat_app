import 'package:chatapp/controllers/auth_controllers.dart';
import 'package:chatapp/services/auth/firebase_services.dart';
import 'package:chatapp/views/Home/home_veiw.dart';
import 'package:chatapp/views/Shared_widgets/custom_button.dart';
import 'package:chatapp/views/Shared_widgets/custom_text_from_feild.dart';
import 'package:chatapp/views/auth/Sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  // final AuthController _authController = AuthController(FirebaseAuthService());

  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        AuthController(FirebaseAuthService());

    final formKey = GlobalKey<FormState>();
    String? emailAddress;

    String? password;
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            children: [
              Image.asset('assets/images/icon.png', height: 100),
              const Text("Sign In",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(height: 60),
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
                          Text("Your Email",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
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
                          Text("Your Password",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
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
                      // context.read<AuthController>().signIn(
                      //       email: emailAddress!,
                      //       password: password!,
                      //       formKey: _formKey,
                      //       context: context,
                      //       onSuccess: (User user) {
                      //         Navigator.pushReplacement(context,
                      //             MaterialPageRoute(builder: (context) {
                      //           return HomeView(user: user);
                      //         }));
                      //       },
                      //     );
                      authController.signIn(
                        email: emailAddress!,
                        password: password!,
                        formKey: formKey,
                        context: context,
                        onSuccess: (User user) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeView(user: user);
                          }));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
