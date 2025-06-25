import 'package:flutter/material.dart';
import 'package:nanoid/non_secure.dart';
import 'package:solh_ai_app/chat/chat_screen.dart';
import 'package:solh_ai_app/helper/shared_prefrences/shared_prefrences_singleton.dart';
import 'package:solh_ai_app/helper/shared_prefrences/user_id.dart';
import 'package:solh_ai_app/test/test.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    manageId();
  }

  void manageId() {
    String? ID = Prefs.getString("userID");

    if (ID == null) {
      String id = nanoid(5);
      Prefs.setString("userID", id);
      userId = id;
      return;
    }

    userId = ID;
    UserId.I.userId = ID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Solh AI")),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Your user id :- $userId",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat),
                    SizedBox(width: 10),
                    Text("Start chating"),
                  ],
                ),
              ),
            ),
                InkWell(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => TestWidget()));
              },
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat),
                    SizedBox(width: 10),
                    Text("sample test"),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  height: 5,
                  width: 5,
                ),
                SizedBox(width: 10),
                Text("Connected"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
