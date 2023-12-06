import 'package:chatapp/views/home_view.dart';
import 'package:flutter/material.dart';

class introItem extends StatelessWidget {
  const introItem({
    super.key,
    required this.control,
    required this.onPressed,
  });
  final PageController control;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 15, top: 20),
            child: Text(
              "Voice and video calling",
              style: TextStyle(
                fontSize: 65,
                fontWeight: FontWeight.w700,
              ),
            )),
        Image.asset(
          "assets/images/intro1.png",
          height: 450,
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: 40, left: 40, top: 20, bottom: 30),
                child: Text(
                    "stay connected with your loved ones no matter where you are in the world. You can even make group calis with up to 10 people at once"),
              ),
              Divider(
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
                          return HomeView();
                        }));
                      },
                      child: Text("Sikp")),
                  ElevatedButton(onPressed: onPressed, child: Text("Next"))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
