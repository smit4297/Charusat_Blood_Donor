import 'package:charusat_blood_donor/pages/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charusat_blood_donor/pages/home_page.dart';
import 'package:charusat_blood_donor/pages/login_page.dart';
import 'package:charusat_blood_donor/stores/login_store.dart';
import 'package:charusat_blood_donor/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<LoginStore>(context, listen: false).isAlreadyAuthenticated().then((result) {
      if (result) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>  UserDashboard()), (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
    );
  }
}
