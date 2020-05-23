import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget copyRigth() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10.0),
      Divider(
          color: Colors.blue, thickness: 2.5, indent: 60.0, endIndent: 60.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 160.0),
          Text('Lucia de cuida@2020. ', style: TextStyle(fontSize: 14.0)),
          FaIcon(
            FontAwesomeIcons.keybase,
            color: Colors.blue,
            size: 18,
          ),
        ],
      ),
      // SizedBox(height: 5.0),
      // Text('Derechos Reservados', style: TextStyle(fontSize: 12.0)),
    ],
  );
}
