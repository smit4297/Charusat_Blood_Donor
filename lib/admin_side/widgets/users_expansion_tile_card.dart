import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class UserDetailsTileCard extends StatelessWidget {
  //final bool isChecked;
  final String userName;
  final String bloodGroup;
  //final dynamic taskDate;
  //final dynamic taskTime;
  //final Function toggleCheckValue;
  final Function longpressCallback;

  UserDetailsTileCard(
      {
        this.userName,
        this.longpressCallback,
        this.bloodGroup,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ExpansionTileCard(
        title: Text(
          userName,
          style: TextStyle(
            fontFamily: 'OpenSans',
          ),
        ),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                bloodGroup,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
