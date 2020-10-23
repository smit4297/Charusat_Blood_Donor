import 'package:charusat_blood_donor/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:charusat_blood_donor/admin_side/widgets/users_expansion_tile_card.dart';
import 'package:charusat_blood_donor/models/user_model.dart';
import 'package:charusat_blood_donor/stores/user_database.dart';

class UsersListView extends StatefulWidget {
  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
      stream: UserDatabase().users,
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Container();
        }
        else {
          List<User> user = snapshot.data;
          return Container(
            margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: ListView.builder(
              itemCount: user.length,
                itemBuilder: (context, index) {
                  return UserDetailsTileCard(
                    userName: user[index].name,
                    bloodGroup: user[index].bloodGroup,
                  );
                }
            ),
          );
        }
      }
    );
  }
}
