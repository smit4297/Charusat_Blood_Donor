import 'package:charusat_blood_donor/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charusat_blood_donor/widgets/custom_text_field.dart';
import 'package:charusat_blood_donor/constants.dart';
import 'package:charusat_blood_donor/stores/user_database.dart';
import '../stores/user_database.dart';

class EditProfile extends StatefulWidget {
  final String uid;
  EditProfile({this.uid});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<String> gender = ["Male", "Female", "Other"];
  var _bloodGroups = [
    "A+ve",
    "A-ve",
    "AB+ve",
    "AB-ve",
    "B+ve",
    "B-ve",
    "O+ve",
    "O-ve",
  ];

  final dateFormat = DateFormat.yMd();
  final _formKey = GlobalKey<FormState>();
  String currentName;
  String currentCity;
  String currenttoken;
  String currentEmail;
  String currentSelectedBloodGroup;
  String currentDisease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(),
              child: Image.asset('assets/img/user_profile.jpeg'),
            ),
          ),
          Expanded(
            flex: 4,
            child: StreamBuilder<User>(
                stream: UserDatabase(uid: widget.uid).userData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ));
                  }
                  User user = snapshot.data;
                  /*currentName = user.name;
                currentEmail = user.email;
                currentCity = user.city;
                currentSelectedBloodGroup = user.bloodGroup;
                currentDisease = user.disease; */
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(14.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CustomTextField(
                              icon: Icon(
                                Icons.person,
                                color: Colors.black54,
                              ),
                              initialtext: user.name,
                              onChange: (value) {
                                setState(() {
                                  currentName = value;
                                });
                              },
                            ),
                            SizedBox(height: 15),
                            CustomTextField(
                              icon: Icon(
                                Icons.email,
                                color: Colors.black54,
                              ),
                              initialtext: user.email,
                              onChange: (value) {
                                setState(() {
                                  currentEmail = value;
                                });
                              },
                              validator: (value) {},
                              keyBoardtype: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 19.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                          labelStyle: kFormTextStyle,
                                          labelText: 'Blood Group',
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 18.0),
                                          hintText: 'Please select Blood Group',
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        isEmpty:
                                            currentSelectedBloodGroup == '',
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: currentSelectedBloodGroup ??
                                                user.bloodGroup,
                                            isDense: true,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                currentSelectedBloodGroup =
                                                    newValue;
                                                state.didChange(newValue);
                                              });
                                            },
                                            items: _bloodGroups
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 8.0,
                                        color: Colors.grey.withOpacity(.4),
                                        offset: Offset(1.5, 2.0)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            CustomTextField(
                              //hintText: 'City',
                              initialtext: user.city,
                              icon: Icon(
                                Icons.location_city,
                                color: Colors.black54,
                              ),
                              onChange: (value) {
                                setState(() {
                                  currentCity = value;
                                });
                              },
                            ),
                            SizedBox(height: 15),
                            CustomTextField(
                              //hintText: 'Disease(If any)',
                              initialtext: user.disease,
                              icon: Icon(
                                Icons.accessibility,
                                color: Colors.black54,
                              ),
                              onChange: (value) {
                                setState(() {
                                  currentDisease = value;
                                });
                              },
                            ),
                            SizedBox(height: 25),
                            Center(
                              child: Container(
                                decoration: kGradientButtonDecoration.copyWith(
                                    borderRadius: BorderRadius.circular(23.0)),
                                width: 130.0,
                                child: Container(
                                  width: 100.0,
                                  child: FlatButton(
                                    child: Text(
                                      'Update',
                                      style: kSubmitButtonEditTextSyle,
                                    ),
                                    onPressed: () async {
                                      /*if(currentName != null){
                                      await UserDatabase(uid: widget.uid).updateUserName(currentName);
                                    }
                                    if(currentCity != null){
                                      await UserDatabase(uid: widget.uid).updateUserCity(currentCity);
                                    }
                                    if(currentEmail != null){
                                      await UserDatabase(uid: widget.uid).updateUserEmail(currentEmail);
                                    }
                                    if(currentDisease != null){
                                      await UserDatabase(uid: widget.uid).updateUserDisease(currentDisease);
                                    }
                                    if(currentSelectedBloodGroup != null){
                                      await UserDatabase(uid: widget.uid).updateUserBloodGroup(currentSelectedBloodGroup);
                                    }*/

                                      await UserDatabase(uid: widget.uid)
                                          .setUserData(
                                              currentName ?? user.name,
                                              null,
                                              currentEmail ?? user.email,
                                              user.birthDate.toString(),
                                              currentSelectedBloodGroup ??
                                                  user.bloodGroup,
                                              currentCity ?? user.city,
                                              currentDisease ?? user.disease,
                                              currenttoken ?? user.token);
                                      print(currentName);
                                      print(currentEmail);
                                      print(currentCity);
                                      print(currentDisease);
                                      print(currentSelectedBloodGroup);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
