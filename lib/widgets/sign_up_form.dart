import 'package:flutter/material.dart';
import 'package:flutter_app/constants/auth_input_deco.dart';
import 'package:flutter_app/constants/common_size.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/models/firebase_auth_state.dart';
import 'package:flutter_app/widgets/or_divider.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  height: common_xs_gap,
                ),
                TextFormField(
                    controller: _pwController,
                    cursorColor: Colors.black54,
                    obscureText: true,
                    decoration: textInputDeco('Password'),
                    validator: (text) {
                      if (text.isNotEmpty && text.length > 5) {
                        return null;
                      } else {
                        return '제대로 된 비밀번호를 입력해주세요.';
                      }
                    }),
                SizedBox(
                  height: common_gap,
                ),
                TextFormField(
                    controller: _cpwController,
                    cursorColor: Colors.black54,
                    obscureText: true,
                    decoration: textInputDeco('ConfirmPassword'),
                    validator: (text) {
                      if (text.isNotEmpty && _pwController.text == text) {
                        return null;
                      } else {
                        return '입력한 값이 비밀번호와 일치하지 않습니다.';
                      }
                    }),
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
            print(_formKey.currentState);
            if (_formKey.currentState.validate()) {
              print('validation success!!');
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => HomePage()));
              Provider.of<FirebaseAuthState>(context, listen: false)
                  .registerUser(context,
                      email: _emailController.text,
                      password: _pwController.text);
            }
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(common_b_radius))),
          child: Text(
            'Join',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
