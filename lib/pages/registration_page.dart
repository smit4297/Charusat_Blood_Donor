import 'package:charusat_blood_donor/pages/user_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charusat_blood_donor/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:charusat_blood_donor/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:charusat_blood_donor/stores/user_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../stores/user_database.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  String token1;

  @override
  void initState() {
    super.initState();

    _messaging.getToken().then((token) {
      print(token);
      token1 = token;
    });
  }

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
  String name;
  String city;
  String Gender;
  String email;
  DateTime birthDate;
  String bloodGroup;
  String currentSelectedBloodGroup;
  String disease;

  //Radio Button Widget Builder
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.redAccent,
          value: gender[btnValue],
          groupValue: Gender,
          onChanged: (value) {
            setState(() {
              Gender = title;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  //Date Picker Widget
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime.now());
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(),
                child: Image.asset(
                  "assets/img/login.png",
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Form(
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
                          hintText: 'Full Name',
                          onChange: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "This field should not be empty";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Gender',
                                textAlign: TextAlign.left,
                                style: kFormTextStyle.copyWith(
                                    color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            addRadioButton(0, 'Male'),
                            addRadioButton(1, 'Female'),
                            addRadioButton(2, 'Others'),
                          ],
                        ),
                        CustomTextField(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black54,
                          ),
                          hintText: 'Email',
                          onChange: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "This field should not be empty";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(height: 15),
                        /*CustomTextField(
                          icon: Icon(Icons.phone,color: Colors.black54,),
                          hintText: 'Mobile Number',
                          onChange: (value) {},
                          validator: (value) {},
                          keyBoardtype: TextInputType.phone,
                        ),*/
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.black54,
                                ),
                                Text(
                                  birthDate == null
                                      ? 'Select BirthDate'
                                      : DateFormat.yMd().format(birthDate),
                                  style: kFormTextStyle,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(23.0),
                                  ),
                                  child: FlatButton(
                                    child: Text(
                                      'Edit',
                                      style: kFormTextStyle,
                                    ),
                                    onPressed: () {
                                      return _selectDate(context);
                                    },
                                  ),
                                ),
                              ],
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19.0),
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                                    isEmpty: currentSelectedBloodGroup == '',
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: currentSelectedBloodGroup,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            currentSelectedBloodGroup =
                                                newValue;
                                            state.didChange(newValue);
                                          });
                                        },
                                        items: _bloodGroups.map((String value) {
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
                          hintText: 'City',
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.black54,
                          ),
                          onChange: (value) {
                            setState(() {
                              city = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "This field should not be empty";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(height: 15),
                        CustomTextField(
                          hintText: 'Disease(If any)',
                          icon: Icon(
                            Icons.accessibility,
                            color: Colors.black54,
                          ),
                          onChange: (value) {
                            setState(() {
                              disease = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "This field should not be empty";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: Container(
                            decoration: kGradientButtonDecoration.copyWith(
                                borderRadius: BorderRadius.circular(23.0)),
                            width: 130.0,
                            child: FlatButton(
                              child: Text(
                                'Submit',
                                style: kSubmitButtonTextSyle,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  print("data submitted successfully");

                                  if (currentSelectedBloodGroup.isEmpty) {
                                    //put toast

                                  } else {
                                    //uid for Userdatabase class call
                                    FirebaseUser firebaseUser =
                                        await FirebaseAuth.instance
                                            .currentUser();
                                    String uid = await firebaseUser.uid;

                                    await UserDatabase(uid: uid).setUserData(
                                      name,
                                      Gender,
                                      email,
                                      birthDate.toString(),
                                      currentSelectedBloodGroup,
                                      city,
                                      disease,
                                      token1,
                                    );

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (_) => UserDashboard(
                                                uid: uid,
                                                bloodGroup:
                                                    currentSelectedBloodGroup)),
                                        (Route<dynamic> route) => false);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
