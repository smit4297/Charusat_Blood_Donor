import 'package:flutter/material.dart';

class AdminDashboardCard extends StatelessWidget {
  final Function onTap;
  final String imagePath;
  final String text;

  AdminDashboardCard({this.onTap,this.text,this.imagePath});
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: new Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          boxShadow: [BoxShadow(
            color: Colors.grey[200],
            blurRadius: 8.0,
          ),],
        ),
        width: 160,
        height: 175,
        padding:
        new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
        child: Column(
          children: <Widget>[
            new Container(
              width: 100.0,
              height: 110,
              padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              color: Colors.blue[300],
              child: new Column(children: [
                Image.asset(
                  imagePath,
                  height: 100,
                  width: 150,
                  fit: BoxFit.fitWidth,
                ),
              ]),
            ),
            SizedBox(height: 10.0,),
            Text(
                text,
                style: TextStyle(
                  fontSize: 14.0,
                ),),
          ],
        ),
      ),
    );
  }
}
