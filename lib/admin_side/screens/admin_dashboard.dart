import 'package:charusat_blood_donor/admin_side/screens/float_request_page.dart';
import 'package:charusat_blood_donor/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'admin_dashboard_card.dart';
import 'users_list_view.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charusat Blood Donor'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      AdminDashboardCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FloatRequestPage()),
                          );
                        },
                        imagePath: 'assets/img/customer.jpg',
                        text: 'Float Request',
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      AdminDashboardCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UsersListView()),
                          );
                        },
                        imagePath: 'assets/img/user_profile.jpeg',
                        text: 'Information Of User',
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      AdminDashboardCard(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute
                            (builder: (_) => LoginPage()), (Route<dynamic> route) => false);
                        },
                        imagePath: 'assets/img/sign_out.jpg',
                        text: 'Sign Out',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
