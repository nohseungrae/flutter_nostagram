import 'package:flutter/material.dart';
import 'package:flutter_app/constants/auth_input_deco.dart';
import 'package:flutter_app/constants/common_size.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/models/firebase_auth_state.dart';
import 'package:flutter_app/widgets/or_divider.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: common_l_gap),
                Image.asset('assets/images/insta_text_logo.png'),
                TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.black54,
                    decoration: textInputDeco('Email'),
                    validator: (text) {
                      if (text.isNotEmpty && text.contains('@')) {
                        return null;
                      } else {
                        return '정확한 이메일 주소를 입력해주세요.';
                      }
                    }),
                SizedBox(
                  height: common_gap,
                ),
                TextFormField(
                    controller: _pwController,
                    cursorColor: Colors.black54,
                    decoration: textInputDeco('Password'),
                    validator: (text) {
                      if (text.isNotEmpty && text.length > 5) {
                        return null;
                      } else {
                        return '제대로 된 비밀번호를 입력해주세요.';
                      }
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        side: BorderSide.none,
                        elevation: 0),
                    onPressed: () {},
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('Forgotten Password',
                            style: TextStyle(color: Colors.blue)))),
                _submitButton(context),
                OrDivider(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      side: BorderSide.none,
                      elevation: 0),
                  icon: ImageIcon(
                    AssetImage('assets/images/facebook.png'),
                    color: Colors.blue,
                  ),
                  label: Text(
                    'Login with Facebook',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Provider.of<FirebaseAuthState>(context, listen: false)
                        .changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                  },
                )
                // FlatButton.icon(
                //     onPressed: () {
                //       Provider.of<FirebaseAuthState>(context, listen: false)
                //           .changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                //     },
                //     textColor: Colors.blue,
                //     icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                //     label: Text('Login with Facebook'))
              ],
            )),
      ),
    );
  }

  Padding _submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: common_gap),
      child: TextButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print('validation success!!');
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => HomePage()));
              Provider.of<FirebaseAuthState>(context, listen: false).login(
                  context,
                  email: _emailController.text,
                  password: _pwController.text);
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
