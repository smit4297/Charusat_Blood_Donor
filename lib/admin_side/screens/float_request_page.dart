import 'package:flutter/material.dart';
import 'package:charusat_blood_donor/constants.dart';
import 'package:charusat_blood_donor/widgets/custom_text_field.dart';
import 'package:charusat_blood_donor/stores/req_database.dart';

class FloatRequestPage extends StatefulWidget {
  @override
  _FloatRequestPageState createState() => _FloatRequestPageState();
}

class _FloatRequestPageState extends State<FloatRequestPage> {

  ReqDatabase reqDatabase = new ReqDatabase();
  final _formKey = GlobalKey<FormState>();
  List<String> isUrgent = ["Yes", "No"];
  String currentSelectedBloodGroup;
  String quantity;
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String urgent;
  static int reqNo=0;
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

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Radio(
        activeColor: Colors.redAccent,
        value: isUrgent[btnValue],
        groupValue: urgent,
        onChanged: (value) {
          setState(() {
            urgent = title;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Float Request'),
        backgroundColor: Colors.redAccent,
      ),
        body: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelStyle: kFormTextStyle,
                              labelText: 'Blood Group',
                              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 18.0),
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
                                    currentSelectedBloodGroup = newValue;
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
                SizedBox(height: 40),
                CustomTextField(
                  hintText: 'Quantity',
                  icon: Icon(Icons.looks_one,color: Colors.black54,),
                  keyBoardtype: TextInputType.number,
                  onChange: (value) {
                    setState(() {
                      quantity = value;
                    });
                  },
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,0,0,0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Urgent Requirement : ',
                        textAlign: TextAlign.left,
                        style: kFormTextStyle.copyWith(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    addRadioButton(0, 'Yes'),
                    addRadioButton(1, 'No'),
                  ],
                ),
                SizedBox(height: 40.0,),
                Center(
                  child: Container(
                    decoration: kGradientButtonDecoration.copyWith(borderRadius: BorderRadius.circular(23.0)),
                    width: 130.0,
                    child: FlatButton(
                      child: Text(
                        'Submit',
                        style: kSubmitButtonTextSyle,
                      ),
                      onPressed: () async {
                        reqNo++;
                        print(reqNo.toString());
                        print(currentSelectedBloodGroup);
                        print(quantity);
                        print(urgent);
                        print(currentDate);
                        print(currentTime);
                        try{
                          await reqDatabase.addRequest( reqNo.toString(),currentSelectedBloodGroup, quantity, urgent, currentDate.toString(), currentTime.toString());
                          Navigator.of(context).pop();
                        }
                        catch(e){
                          print(e);
                        }
                        },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
