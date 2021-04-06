import 'package:flutter/material.dart';
import 'package:flutter_app/screens/profile_screen.dart';
import 'package:flutter_app/widgets/fade_stack.dart';
import 'package:flutter_app/widgets/sign_in_form.dart';
import 'package:flutter_app/widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>  {
  int selectedForm = 0;
  Widget currentWidget;

  @override
  void initState() {
    if(currentWidget == null) currentWidget = SignUpForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            FadeStack(selectedForm: selectedForm),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 45,
              child: Container(
                color : Colors.white,
                child: FlatButton(
                    shape: Border(top: BorderSide(color : Colors.grey)),
                    onPressed: () {
                      setState(() {
                        if(selectedForm == 0){
                          selectedForm = 1;
                          currentWidget = SignInForm();
                        } else {
                          selectedForm = 0;
                          currentWidget = SignUpForm();
                        }
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                        text:  (currentWidget is SignUpForm)
                            ? "Already have an account?"
                            : "Don't have an account.",
                        style: TextStyle(color : Colors.black87),
                        children: [TextSpan(
                            text:(currentWidget is SignUpForm) ? 'Sign In' : 'Sign Up',
                            style: TextStyle(
                                color : Colors.blue,
                                fontWeight: FontWeight.bold)
                        )]
                      ),)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}