import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/screens/profile_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked),
              label: 'GALLERY'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked),
              label: 'PHOTO'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked),
              label: 'VIDEO'
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTabbed,
      ),
      body: PageView(
        // scrollDirection: Axis.vertical,
        controller: _pageController,
        children: [
          Container(
            color: Colors.cyanAccent,
          ),
          Container(
            color: Colors.amberAccent,
          ),
          Container(
            color: Colors.greenAccent,
          )
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void _onItemTabbed(index) {
        print(index);
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex, duration: duration, curve: Curves.fastOutSlowIn);
        });
      }
}
