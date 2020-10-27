import 'package:CodeKaksha/drawer.dart';
import 'package:CodeKaksha/editor.dart';
import 'package:CodeKaksha/mywhiteboard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          title: Text(
            "Code Kaksha",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.yellow,
            tabs: [
              Tab(
                child: Text(
                  "Meeting",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  "Whiteboard",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  "Editor",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                //Tab parameters icon and text can be given which arranges them in a column
              ),
            ],
          ),
        ),
        drawer: MyDrawer(),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(),
            MyWhiteboard(),
            Editor(),
          ],
        ),
      ),
    );
  }
}
