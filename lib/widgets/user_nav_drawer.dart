import 'package:charusat_blood_donor/pages/home_page.dart';
import 'package:charusat_blood_donor/stores/login_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charusat_blood_donor/pages/edit_profile.dart';
import 'package:provider/provider.dart';


class UserNavDrawer extends StatefulWidget {

  final String uid;
  final String bloodGroup;
  UserNavDrawer({this.uid,this.bloodGroup});

  @override
  _UserNavDrawerState createState() => _UserNavDrawerState();
}


class _UserNavDrawerState extends State<UserNavDrawer> {

  showAlertDialog(BuildContext context,String bloodGroup) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Blood Group"),
      content: Text("Your Blood Group :" + bloodGroup),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/img/edit_profile.png'),
                  radius: 30.0,
                ),
                SizedBox(height: 10.0,),
                Text('Profile',
                  style: TextStyle(fontSize: 28.0, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('User Profile'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile(uid: widget.uid)), ),
            },
          ),
          ListTile(
            leading: Icon(Icons.adjust),
            title: Text('Blood Group'),
            onTap: () {
              setState(() {
                showAlertDialog(context,widget.bloodGroup.toString());
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_ind),
            title: Text('Sign Out'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
