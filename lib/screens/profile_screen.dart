import 'package:flutter/material.dart';
import 'package:flutter_app/constants/screen_size.dart';
import 'package:flutter_app/widgets/porilfe_body.dart';
import 'package:flutter_app/widgets/profile_side_menu.dart';

const duration = Duration(milliseconds: 1000);

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final menuWidth = size.width / 3 * 2;

  MenuStatus _menuStatus = MenuStatus.closed;
  double _bodyXPos = 0;
  double _menuXpos = size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body : Stack(
        children: [
          AnimatedContainer(
              duration : duration,
              curve: Curves.fastOutSlowIn,
              transform: Matrix4.translationValues(_bodyXPos, 0, 0),
              child: ProfileBody(
                onMenuChanged: () {
                  setState(() {
                    _menuStatus = (_menuStatus == MenuStatus.closed)
                        ? MenuStatus.opened
                        : MenuStatus.closed;
                    switch(_menuStatus){
                      case MenuStatus.opened:
                        _bodyXPos = - menuWidth;
                        _menuXpos = size.width - menuWidth;
                        break;
                      case MenuStatus.closed:
                        _bodyXPos = 0;
                        _menuXpos = size.width;
                        break;
                    }
                  });
                },
              ),
          ),
          AnimatedContainer(
              duration: duration,
              curve: Curves.fastOutSlowIn,
              transform: Matrix4.translationValues(_menuXpos, 0, 0),
              child: ProfileSideMenu(menuWidth)
          ),
        ],
      )
    );
  }
}

enum MenuStatus {
  opened,
  closed
}
