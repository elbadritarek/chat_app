import 'package:flutter/material.dart';

class bottomAppBar extends StatefulWidget {
  const bottomAppBar({super.key, required this.control});
  final PageController control;
  @override
  State<bottomAppBar> createState() => _bottomAppBarState();
}

class _bottomAppBarState extends State<bottomAppBar> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      /*AnimatedPositioned(
          child: Container(
            height: 50,
            width: 90,
            color: kprimary2Colour,
          ),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut),*/
      Row(
        children: [
          const Spacer(flex: 1),
          Container(
            height: 50,
            width: 60,
            color: selectIndex == 0
                ? const Color.fromARGB(143, 176, 220, 243)
                : Colors.white,
            child: IconButton(
                onPressed: () {
                  widget.control.animateToPage(0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                  selectIndex == 0;
                  setState(() {
                    selectIndex = 0;
                  });
                },
                icon: const Icon(
                  Icons.message,
                  size: 30,
                )),
          ),
          const Spacer(flex: 2),
          Container(
            height: 50,
            width: 60,
            color: selectIndex == 1
                ? const Color.fromARGB(143, 176, 220, 243)
                : Colors.white,
            child: IconButton(
                onPressed: () {
                  widget.control.animateToPage(1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                  selectIndex == 1;
                  setState(() {
                    selectIndex = 1;
                  });
                },
                icon: const Icon(
                  Icons.call,
                  size: 30,
                )),
          ),
          const Spacer(flex: 3),
          Container(
            height: 50,
            width: 60,
            color: selectIndex == 2
                ? const Color.fromARGB(143, 176, 220, 243)
                : Colors.white,
            child: IconButton(
                onPressed: () {
                  widget.control.animateToPage(2,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                  selectIndex == 2;
                  setState(() {
                    selectIndex = 2;
                  });
                },
                icon: const Icon(
                  Icons.group,
                  size: 30,
                )),
          ),
          const Spacer(flex: 2),
          Container(
            height: 50,
            width: 60,
            color: selectIndex == 3
                ? const Color.fromARGB(143, 176, 220, 243)
                : Colors.white,
            child: IconButton(
                onPressed: () {
                  widget.control.animateToPage(3,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut);
                  selectIndex == 3;
                  setState(() {
                    selectIndex = 3;
                  });
                },
                icon: const Icon(
                  Icons.explore,
                  size: 30,
                )),
          ),
          const Spacer(flex: 1),
        ],
      ),
    ]);
  }
}
