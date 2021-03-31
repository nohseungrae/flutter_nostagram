import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/post.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: IconButton(
          onPressed: null,
          icon : Icon(
            Icons.photo_camera,
                color : Colors.black87
          )
        ),
        middle: Text(
          'nostagram',
          style: TextStyle(
            fontFamily: 'VeganStyle',
            color: Colors.black87,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          IconButton(icon: ImageIcon(
            AssetImage('assets/images/actionbar_camera.png'),
            color: Colors.black87,
          ), onPressed: null),
            IconButton(icon: ImageIcon(
              AssetImage('assets/images/actionbar_camera.png'),
              color: Colors.black87,
            ), onPressed: null)
        ],),
      ),
      body: ListView.builder(itemBuilder: feedListBuilder, itemCount: 30),
    );
  }

  Widget feedListBuilder(BuildContext context , int index) {
    print(index);
    return Post(index);
  }
}
