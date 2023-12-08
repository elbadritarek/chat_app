import 'package:chatapp/views/Sign_In_view.dart';
import 'package:chatapp/views/widgets/intro_Item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class onBoardingPage extends StatefulWidget {
  const onBoardingPage({super.key});

  @override
  State<onBoardingPage> createState() => _onBoardingPageState();
}

class _onBoardingPageState extends State<onBoardingPage> {
  @override
  void initState() {
    super.initState();
    _checkIfFirstTime();
  }

  void _checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      await prefs.setBool("isFirstTime", false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const SignInView();
      }));
    }
  }

  final PageController control = PageController(initialPage: 0);
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 3),
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
                        onProgressDot(const Color.fromRGBO(33, 150, 243, 1))
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
        physics: const NeverScrollableScrollPhysics(),
        children: [
          introItem(
            title: "Connect with the World",
            image: "assets/images/chatapp-high-resolution-logo.png",
            desc:
                "Welcome to chatApp, the ultimate platform to connect with anyone, anywhere!",
            control: control,
            onPressed: () {
              control.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);

              setState(() {
                if (selectedIndex < 2 && selectedIndex >= 0) {
                  selectedIndex++;
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const SignInView();
                  }));
                }
              });
            },
          ),
          introItem(
            desc:
                "stay connected with your loved ones no matter where you are in the world. You can even make group calis with up to 10 people at once",
            image: "assets/images/video.png",
            box: BoxFit.fill,
            title: "Voice and video calling",
            control: control,
            onPressed: () {
              control.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);

              setState(() {
                if (selectedIndex < 2 && selectedIndex >= 0) {
                  selectedIndex++;
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const SignInView();
                  }));
                }
              });
            },
          ),
          introItem(
            desc:
                "Delve into various chat formats - from private conversations to lively group chats. Share photos, videos, and more!",
            image: "assets/images/intro1.png",
            title: "Start Chatting Today!",
            control: control,
            onPressed: () {
              control.nextPage(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);

              setState(() {
                if (selectedIndex < 2 && selectedIndex >= 0) {
                  selectedIndex++;
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const SignInView();
                  }));
                }
              });
            },
          ),
        ],
      ),
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
