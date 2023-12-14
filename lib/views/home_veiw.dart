import 'package:chatapp/views/widgets/bottom_appbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

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
              backgroundImage: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg"),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Text("tarekElbadri"),
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
        children: const [
          MessageBody(),
          callsBody(),
          groupsBody(),
          exploreBody(),
        ],
      ),
      bottomNavigationBar: bottomAppBar(control: pageController),
    );
  }
}

class MessageBody extends StatelessWidget {
  const MessageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class callsBody extends StatelessWidget {
  const callsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class groupsBody extends StatelessWidget {
  const groupsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class exploreBody extends StatelessWidget {
  const exploreBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
