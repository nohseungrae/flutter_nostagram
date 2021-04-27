import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _firebaseUser;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context,
      {@required String email, @required String password}) {
    _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error.code);
      String _message = "";

      switch (error.code) {
        case 'weak-password':
          _message = '패스워드 좀 잘 넣어줘!';
          break;
        case 'invalid-email':
          _message = '이메일 형식 좀 잘 넣어줘!';
          break;
        case 'email-already-in-use':
          _message = '이미 등록된 이메일입니다.';
          break;
      }

      SnackBar snackBar = SnackBar(content: Text(_message));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }

  void login(BuildContext context,
      {@required String email, @required String password}) {
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error.code);
      String _message = "";

      switch (error.code) {
        case 'invalid-email':
          _message = '이메일 형식 좀 잘 넣어줘!';
          break;
        case 'wrong-password':
          _message = '패스워드가 틀렸습니다.';
          break;
        case 'user-not-found':
          _message = '등록된 유저가 없습니다.';
          break;
        case 'user-disabled':
          _message = '금지된 이메일입니다.';
          break;
        case 'too-many-requests':
          _message = '너무 많은 시도로 잠시 후에 다시 해주세요.';
          break;
        case 'operation-not-allowed':
          _message = '해당 동작을 할 수 없습니다.';
          break;
      }

      SnackBar snackBar = SnackBar(content: Text(_message));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }

    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
