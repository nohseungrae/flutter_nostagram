import 'package:flutter/material.dart';
import 'package:flutter_app/constants/common_size.dart';
import 'package:flutter_app/constants/screen_size.dart';

class ProfileBody extends StatefulWidget {

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.left;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: CustomScrollView(slivers: <Widget>[
      SliverList(delegate: SliverChildListDelegate(
          [
            _username(),
            _userBio(),
            _editProfileBtn(),
            _tapButtons(),
            _selectedIndicator()
          ]
      ))
    ])
    );
  }

  Row _tapButtons() {
    return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: IconButton(
                  icon: ImageIcon(AssetImage('assets/images/grid.png'),
                    color: _selectedTab == SelectedTab.left ? Colors.black : Colors.black26,),
                  onPressed: (){
                    setState(() {
                      _selectedTab = SelectedTab.left;
                    });
                  }
              )),
              Expanded(child: IconButton(
                  icon: ImageIcon(AssetImage('assets/images/saved.png'),
                  color: _selectedTab == SelectedTab.left ? Colors.black26 : Colors.black),
                  onPressed: (){
                    setState(() {
                      _selectedTab = SelectedTab.right;
                    });
                  }
              ))
            ],
          );
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
      child: SizedBox(
        height: 24,
        child: OutlinedButton(
          child: Text('Edit Profile',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
          ),
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.black45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
              )
          ),
        ),
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text('username',
          style: TextStyle(fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text('This is WHAT?!!?!?!?!',
          style: TextStyle(fontWeight: FontWeight.w400)
      ),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: _selectedTab == SelectedTab.left ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(height: 3, width: size.width/2, color: Colors.black87),
    );
  }
}

enum SelectedTab {
  left,
  right
}