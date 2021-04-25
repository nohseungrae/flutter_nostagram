import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/screen_size.dart';
import 'package:flutter_app/screens/camera_screen.dart';
import 'package:flutter_app/screens/feed_screen.dart';
import 'package:flutter_app/screens/profile_screen.dart';
import 'package:flutter_app/screens/search_screen.dart';
import 'package:permission_handler/permission_handler.dart';

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
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '')
  ];

  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static List<Widget> _screens = <Widget>[
    FeedScreen(),
    SearchScreen(),
    Container(
      color: Colors.greenAccent,
    ),
    Container(
      color: Colors.deepPurpleAccent,
    ),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
    }
    return Scaffold(
      key: _key,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
          child: BottomNavigationBar(
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
    switch (index) {
      case 2:
        _openCamera();
        break;
      default:
        setState(() {
          _selectedIndex = index;
        });
    }
  }

  void _openCamera() async {
    if (await checkIfPermissionGranted(context)) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    } else {
      SnackBar snackBar = SnackBar(
        content: Text('사진, 파일, 마이크 접근 허용을 하여야 카메라 사용잉 가능합니다.'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
        ),
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Platform.isIOS ? Permission.photos : Permission.storage
    ].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });

    return permitted;
  }
}
