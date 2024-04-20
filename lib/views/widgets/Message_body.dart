import 'package:flutter/material.dart';

class MessageBody extends StatelessWidget {
  const MessageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ProfileMessageItem();
      },
    );
  }
}

class ProfileMessageItem extends StatelessWidget {
  const ProfileMessageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileMessageItemView(),
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(color: Colors.blue[50]),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg"),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "userName",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      "message test for chatapp hello world my name is tarek elbadri thank you for developing this app",
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMessageItemView extends StatelessWidget {
  const ProfileMessageItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
