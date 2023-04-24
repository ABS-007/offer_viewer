import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [Color(0xFFE4EDF0), Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              height: Get.height * .25,
              width: Get.width * 1,
              child: Column(
                children: const [
                  Expanded(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          "https://pbs.twimg.com/profile_images/1608129257221533696/bAxRmtib_400x400.jpg"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Ashish Bibyan",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "aashishbibyan007@gmail.com",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.check_mark_circled,
                color: Colors.blue,
              ),
              title: Text("My Offers"),
              trailing: Icon(CupertinoIcons.right_chevron),
            ),
            ListTile(
              leading: Icon(
                Icons.checklist_sharp,
                color: Colors.blue,
              ),
              title: Text("App Usage"),
              trailing: Icon(CupertinoIcons.right_chevron),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.chat_bubble_text,
                color: Colors.blue,
              ),
              title: Text("Support"),
              trailing: Image.asset(
                "assets/icons/goto.png",
                height: 20,
                width: 20,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.square_list,
                color: Colors.blue,
              ),
              title: Text("Terms & Conditions"),
              trailing: Image.asset(
                "assets/icons/goto.png",
                height: 20,
                width: 20,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.gear_alt,
                color: Colors.blue,
              ),
              title: Text("Privacy Policy"),
              trailing: Image.asset(
                "assets/icons/goto.png",
                height: 20,
                width: 20,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.star,
                color: Colors.blue,
              ),
              title: Text("Rate Us"),
              trailing: Icon(CupertinoIcons.right_chevron),
            ),
            ListTile(
              leading: Icon(
                Icons.translate_sharp,
                color: Colors.blue,
              ),
              title: Text("Languages"),
              trailing: Text("ENG"),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              title: Text("Logout"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Follow Us"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(child: Icon(Icons.facebook))),
                IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      child: Image.asset(
                        "assets/icons/instagram.png",
                      ),
                    )),
                IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      child: Image.asset(
                        "assets/icons/youtube.png",
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
