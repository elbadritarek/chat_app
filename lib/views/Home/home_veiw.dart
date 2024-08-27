import 'package:chatapp/views/Home/widgets/Message_body.dart';
import 'package:chatapp/views/Home/widgets/bottom_appbar.dart';
import 'package:chatapp/views/Home/widgets/calls_body.dart';
import 'package:chatapp/views/Home/widgets/explore_body.dart';
import 'package:chatapp/views/Home/widgets/friends_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.user});
  final User user;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(143, 176, 220, 243),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.photoURL ??
                  "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg"),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Text(widget.user.displayName ?? "user"),
                Center(
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 10, color: Colors.green),
                      Text("Active", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MessageBody(currentUser: widget.user.uid),
          callsBody(currentUser: widget.user.uid),
          friendsBody(currentUser: widget.user.uid),
          exploreBody(currentUser: widget.user.uid),
        ],
      ),
      bottomNavigationBar: bottomAppBar(control: pageController),
    );
  }
}
