import 'package:charusat_blood_donor/admin_side/screens/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:charusat_blood_donor/pages/splash_page.dart';
import 'package:charusat_blood_donor/stores/login_store.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _messaging.getToken().then((token) {
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>(
          create: (_) => LoginStore(),
        ),
      ],
      child: MaterialApp(
        home: SplashPage(),
        // home: AdminDashboard(),
      ),
    );
  }
}
