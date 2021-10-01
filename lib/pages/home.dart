import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: 0, // fixed index 0
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"), // must have label
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail), label: "Contact Us"),
        ],
        onTap: (index) {
          print(index);
        },
      ),
      appBar: AppBar(
        title: Text(
          "ความรู้เกี่ยวกับคอมพิวเตอร์",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          // builder, future
          builder: (context, snapshot) {
            var data = json.decode(snapshot.data.toString());
            return ListView.builder(
              // itemBuilder, itemCount
              itemBuilder: (BuildContext context, int index) {
                // this function return widget
                return MyBox(data[index]["title"], data[index]["subtitle"],
                    data[index]["image_url"], data[index]["detail"]);
              },
              itemCount: data.length,
            );
          },
          future: DefaultAssetBundle.of(context)
              .loadString('assets/data.json'), // source of data
        ),
      ),
    );
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      // color: Colors.yellow.shade200,
      height: 150,
      decoration: BoxDecoration(
          // color: Colors.yellow.shade200,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(image_url), // Insert String url
            fit: BoxFit.cover, // fit image
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.60), BlendMode.darken),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, // title of card
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle, //subtitle of card
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 25,
          ),
          TextButton(
              onPressed: () {
                print("Next Page >>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(title, subtitle, image_url, detail)));
              },
              child: Text("อ่านต่อ...", style: TextStyle(color: Colors.white),)),
        ],
      ),
    );
  }
}
