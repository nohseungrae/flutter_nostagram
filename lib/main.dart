import 'package:flutter/material.dart';
import 'package:flutter_app/constants/material_white.dart';
import 'package:flutter_app/models/firebase_auth_state.dart';
import 'package:flutter_app/screens/auth_screen.dart';
import 'package:flutter_app/screens/profile_screen.dart';
import 'package:flutter_app/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {

    _firebaseAuthState.watchAuthChange();

    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<FirebaseAuthState>(
          builder: (context, firebaseAuthState, child) {

            switch (firebaseAuthState.firebaseAuthStatus) {
              case FirebaseAuthStatus.signout:
                _currentWidget = AuthScreen();
                break;
              case FirebaseAuthStatus.signin:
                _currentWidget = HomePage();
                break;
              default:
                _currentWidget = MyProgressIndicator();
            }

            return AnimatedSwitcher(
                duration: Duration(milliseconds: 300), child: _currentWidget);
          },
        ),
        // home: AuthScreen(),
        theme: ThemeData(primarySwatch: white),
      ),
    );
  }
}
