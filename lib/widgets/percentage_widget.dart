import 'package:flutter/material.dart';

class PercentageWidget extends StatelessWidget{

  final double size;
  final int count;

  final String title;
  final bool countLeft;

  const PercentageWidget({Key key, this.size, this.count, this.title, this.countLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            countLeft ? leftWidget() : rightWidget(),
            Text(title, style: TextStyle( fontSize: 16.0),),

          ],
        ),

      ),
    );
  }

  Row leftWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text('$count', style: TextStyle( fontSize: 35.0, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Row rightWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Expanded(
            flex: 2,
            child: Text('$count', style: TextStyle( fontSize: 40.0, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

}
