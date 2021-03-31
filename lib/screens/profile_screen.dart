import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/porilfe_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body : SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appbar(),
              ProfileBody()
            ]),
      )
    );
  }

  Row _appbar() {
    return Row(
            children: [
              SizedBox(
                width: 44,
              ),
              Expanded(
                  child: Text('The Nolec',
                      textAlign: TextAlign.center
                  )
              ),
              IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {}
              )
            ]);
  }
}
