import 'package:flutter/material.dart';
import 'package:flutter_app/constants/screen_size.dart';
import 'package:flutter_app/screens/camera_screen.dart';
import 'package:flutter_app/screens/feed_screen.dart';
import 'package:flutter_app/screens/profile_screen.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon:Icon(Icons.home), label : ''),
    BottomNavigationBarItem(icon:Icon(Icons.search), label : ''),
    BottomNavigationBarItem(icon:Icon(Icons.add), label : ''),
    BottomNavigationBarItem(icon:Icon(Icons.healing), label : ''),
    BottomNavigationBarItem(icon:Icon(Icons.account_circle), label : '')
  ];

  int _selectedIndex = 0;

  static List<Widget> _screens = <Widget>[
    FeedScreen(),
    Container(color: Colors.blueAccent,),
    Container(color: Colors.greenAccent,),
    Container(color: Colors.deepPurpleAccent,),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    if(size == null){
      size = MediaQuery.of(context).size;
    }
    return Scaffold(
      body : IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onBtnItemClick,
      )),
    );
  }

  void _onBtnItemClick(int index) {
    switch(index) {
      case 2 :
        _openCamera();
        break;
      default : setState(() {_selectedIndex = index; });
    }
  }

  void _openCamera() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CameraScreen()));
  }
}