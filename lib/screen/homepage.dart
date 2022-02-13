import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: CircleAvatar(
                radius: 550,
                backgroundColor: Colors.red,
                child: CircleAvatar(
                  radius: 400,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 200,
                    child: Hero(
                      tag: "image",
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          border: Border.all(
                              color: const Color(0xfff06127),
                              style: BorderStyle.solid),
                          // image: DecorationImage(
                          //   fit: BoxFit.cover,
                          // image: details.userModel.data?.avatarImageUrl != null
                          //     ? NetworkImage(details.userModel.data?.avatarImageUrl)
                          //     : const AssetImage('assets/icons/neesumLogo.png')
                          //         as ImageProvider,
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity,
              height: 10,
            ),
            const Text("Choose your Dream Car"),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    margin: EdgeInsets.all(8),
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.all(8),
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.all(8),
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.all(8),
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.all(8),
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text("Select your car."),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Icon(Icons.list),
                      trailing: Text(
                        "GFG",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text("List item $index"));
                }),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                // scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  ListTile(
                    title: Text("1st Row"),
                    subtitle: Text("1st subtitle"),
                  ),
                  ListTile(
                    title: Text("2nd Row"),
                    subtitle: Text("2nd subtitle"),
                  ),
                  ListTile(
                    title: Text("3rd Row"),
                    subtitle: Text("3rd subtitle"),
                  ),
                  ListTile(
                    title: Text("4th Row"),
                    subtitle: Text("4th subtitle"),
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              // margin: EdgeInsets.all(8),
              height: 150,
              color: Colors.indigo[800],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              // margin: EdgeInsets.all(8),
              height: 150,
              color: Colors.indigo[800],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              // margin: EdgeInsets.all(8),
              height: 150,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
