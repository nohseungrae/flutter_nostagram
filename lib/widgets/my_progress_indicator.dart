import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {

  final double containerSize;
  final double progressSize;

  const MyProgressIndicator({Key key, this.containerSize, this.progressSize = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: progressSize,
        height: progressSize,
        child: Center(
            child: SizedBox(height: 60 ,width : 60,
                child: Image.asset('assets/images/loading_img.gif')
            )));
  }
}
