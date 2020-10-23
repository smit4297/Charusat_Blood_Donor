import 'package:flutter/material.dart';

class BloodGroupThumbnailWidget extends StatelessWidget {
  final String requirement;
  final String bloodGroup;
  final String SelectedbloodGrp;

  const BloodGroupThumbnailWidget(
      {Key key, this.requirement, this.bloodGroup, this.SelectedbloodGrp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            decoration: BoxDecoration(
              //   border: Border.all(
              //   color: Colors.red[500],
              //  ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            height: 120.0,
            width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      //   border: Border.all(
                      color: Colors.red,
                      //  ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    ),
                    alignment: Alignment.center,
                    child: Text(requirement != null ? requirement : "URGENT",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      //   border: Border.all(
                      //   color: Colors.red[500],
                      color: Colors.black87,
                      //  ),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                        bloodGroup != null ? bloodGroup : SelectedbloodGrp,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
