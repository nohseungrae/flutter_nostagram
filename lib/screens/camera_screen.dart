import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/models/camera_state.dart';
import 'package:flutter_app/models/garlley_state.dart';
import 'package:flutter_app/screens/profile_screen.dart';
import 'package:flutter_app/widgets/my_gallery.dart';
import 'package:flutter_app/widgets/take_photo.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {

  CameraState _cameraState = CameraState();
  GalleryState _galleryState = GalleryState();

  @override
  _CameraScreenState createState() {
    _cameraState.getReadyToTakePhoto();
    _galleryState.initProvider();
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {

  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  String _title = 'Photo';

  @override
  void dispose() {
    _pageController.dispose();
    widget._cameraState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //_cameraState.getReadyToTakePhoto(); 를 먼저 실행하기 위해서 사용
        ChangeNotifierProvider<CameraState>.value(value: widget._cameraState),
        ChangeNotifierProvider<GalleryState>.value(value: widget._galleryState),
        // ChangeNotifierProvider(create: (context) => CameraState())
      ],
      child: Scaffold(
        appBar: AppBar(
          title : Text(_title)
        ),
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
            MyGallery(),
            TakePhoto(),
            Container(
              color: Colors.greenAccent,
            )
          ],
          onPageChanged: (index) {
            setState(() {
              switch(index) {
                case 0 :
                  _title = 'Gallery';
                  break;
                case 1 :
                  _title = 'Photo';
                  break;
                case 2 :
                  _title = 'Video';
                  break;
              }
              _currentIndex = index;
            });
          },
        ),
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
