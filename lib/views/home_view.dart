import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class onBoardingPage extends StatefulWidget {
  const onBoardingPage({super.key});

  @override
  State<onBoardingPage> createState() => _onBoardingPageState();
}

class _onBoardingPageState extends State<onBoardingPage> {
  final PageController control = PageController(initialPage: 0);
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 3),
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (int i = 0; i < 3; i++)
                      if (selectedIndex == i)
                        onProgressDot(Colors.blue)
                      else
                        onProgressDot(Colors.grey[300]!)
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: control,
        physics: NeverScrollableScrollPhysics(),
        children: [
          introModel(
            control: control,
            onPressed: () {
              control.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);

              setState(() {
                if (selectedIndex < 2 && selectedIndex >= 0)
                  selectedIndex++;
                else
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeView();
                  }));
              });
            },
          ),
          introModel(
            control: control,
            onPressed: () {
              control.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);

              setState(() {
                if (selectedIndex < 2 && selectedIndex >= 0)
                  selectedIndex++;
                else
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeView();
                  }));
              });
            },
          ),
          introModel(
            control: control,
            onPressed: () {
              control.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);

              setState(() {
                if (selectedIndex < 2 && selectedIndex >= 0)
                  selectedIndex++;
                else
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeView();
                  }));
              });
            },
          ),
        ],
      ),
    );
  }
}

class introModel extends StatelessWidget {
  const introModel({
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

Widget onProgressDot(Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 5),
    height: 10,
    width: 10,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: color),
  );
}
