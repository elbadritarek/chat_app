import 'package:chatapp/views/auth/Sign_In_view.dart';
import 'package:flutter/material.dart';

class introItem extends StatelessWidget {
  const introItem({
    super.key,
    required this.control,
    required this.onPressed,
    required this.image,
    required this.title,
    required this.desc,
    this.box,
  });
  final PageController control;
  final void Function()? onPressed;
  final BoxFit? box;
  final String image;
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w700,
              ),
            )),
        Image.asset(
          image,
          fit: box,
          height: 450,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 40,
                    left: 40,
                    top: 20,
                  ),
                  child: Text(desc),
                ),
                const Divider(
                  indent: 25,
                  endIndent: 25,
                  height: 10,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignInView();
                          }));
                        },
                        child: const Text("Sikp")),
                    ElevatedButton(
                        onPressed: onPressed, child: const Text("Next"))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
