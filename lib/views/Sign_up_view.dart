import 'package:chatapp/views/widgets/custom_button.dart';
import 'package:chatapp/views/widgets/custom_text_from_feild.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(12, 20),
          child: SizedBox(
            height: 20,
          )),
      body: Column(
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
                              "Your First Name",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customTextFeild(hintText: "first name"),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text(
                              "Your Last Name",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customTextFeild(hintText: "last name"),
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
                        customTextFeild(hintText: "Example@gmail.com"),
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
                        customTextFeild(hintText: "*********"),
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
                    customBottum(
                      text: "Sign Up",
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
