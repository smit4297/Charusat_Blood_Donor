import 'package:charusat_blood_donor/models/request_model.dart';
import 'package:charusat_blood_donor/stores/login_store.dart';
import 'package:charusat_blood_donor/stores/req_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charusat_blood_donor/widgets/user_nav_drawer.dart';
import 'package:charusat_blood_donor/widgets/blood_thumbnail.dart';
import 'package:charusat_blood_donor/widgets/percentage_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserDashboard extends StatefulWidget {
  String uid;
  String bloodGroup;
  UserDashboard({this.uid, this.bloodGroup});
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  double bannerHeight, listHeight, listPaddingTop;
  double cardContainerHeight, cardContainerTopPadding;

  // get uid => UserDashboard(uid: uid);
  @override
  Widget build(BuildContext context) {
    bannerHeight = MediaQuery.of(context).size.height * .20;
    listHeight = MediaQuery.of(context).size.height * .80;
    cardContainerHeight = 160;
    cardContainerTopPadding = bannerHeight / 2;
    listPaddingTop = cardContainerHeight - (bannerHeight / 2);

    String totalRequests;

    return Scaffold(
      appBar: AppBar(
        title: Text("Charusat Blood Donor"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      drawer: UserNavDrawer(uid: widget.uid, bloodGroup: widget.bloodGroup),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              topBanner(context), //0.20% Screen
              Expanded(
                child: bodyBloodRequestList(context),
              ) //0.80%
            ],
          ),
          bannerContainer(),
          cardContainer(context),
        ],
      ),
    );
  }

  Container bodyBloodRequestList(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade300,
      padding:
          new EdgeInsets.only(top: listPaddingTop, right: 10.0, left: 10.0),
      child: Column(
        children: <Widget>[Expanded(child: listRecentUpdates())],
      ),
    );
  }

  StreamBuilder<List<RequestModel>> listRecentUpdates() {
    return StreamBuilder<List<RequestModel>>(
        stream: ReqDatabase().requests,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print(snapshot.data);
            print(snapshot.hasError);
            return Container(
              child: Center(
                child: Text('Could not find the required data'),
              ),
            );
          } else {
            List<RequestModel> reqInstance = snapshot.data;

            return ListView.builder(
                scrollDirection: Axis.vertical,
                //   reverse: true,
                shrinkWrap: false,
                itemCount: reqInstance.length,
                itemBuilder: (BuildContext context, int index) {
                  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                  DateTime date =
                      DateTime.parse(reqInstance[index].currentDate);
                  String printDate = dateFormat.format(date);

                  DateFormat timeFormat = DateFormat('HH:mm');
                  DateTime time =
                      DateTime.parse(reqInstance[index].currentDate);
                  String printTime = timeFormat.format(time);

                  String urgentString;
                  if (reqInstance[index].isUrgent == "Yes") {
                    urgentString = "Urgent";
                  } else {
                    urgentString = "Not Urgent";
                  }

                  // totalRequests = reqInstance[index].reqNo;
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.white30,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: BloodGroupThumbnailWidget(
                            requirement: urgentString,
                            SelectedbloodGrp: reqInstance[index].bloodGrp,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 10.0),
                              child: Text(
                                'Status',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 10.0),
                              child: Text(
                                'Date Of Request  ' + printDate,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 10.0),
                              child: Text(
                                'Time Of Request  ' + printTime,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
        });
  }

  Container topBanner(BuildContext context) {
    return Container(
      height: bannerHeight,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        const Color.fromARGB(1000, 157, 37, 24),
        const Color.fromARGB(1000, 212, 47, 33),
      ])),
    );
  }

  Container bannerContainer() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 30, right: 20.0, left: 20.0),
      child: Text(
        "Blood Requests",
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container cardContainer(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: new EdgeInsets.only(
          top: cardContainerTopPadding, right: 20.0, left: 20.0),
      child: Container(
        height: cardContainerHeight - 40,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FutureBuilder<int>(
                    future: ReqDatabase().countDocuments(),
                    builder: (context, snapshot) {
                      return PercentageWidget(
                        size: 80.0,
                        title: 'Requests',
                        count: snapshot.data,
                        countLeft: false,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
