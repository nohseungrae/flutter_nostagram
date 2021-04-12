import 'package:flutter/material.dart';
import 'package:flutter_app/constants/screen_size.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          height : size.width,
          color : Colors.black
        ),
        Expanded(
            child: OutlinedButton(
              child: Text(''),
              onPressed: () {
                print('hello');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(size.width / 3, 0),
                  shape: CircleBorder(),
                  side: BorderSide(color : Colors.black12, width: 20)
              ),
            )
        )
      ],
    );
  }
}