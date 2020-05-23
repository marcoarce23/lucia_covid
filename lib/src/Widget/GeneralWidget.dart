import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';

Widget copyRigth() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10.0),
     divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 160.0),
          Text('Lucia te cuida@2020. ', style: kTitleCursive4Style),
          FaIcon(
            FontAwesomeIcons.keybase,
            color: Color.fromRGBO(165, 5, 5 , 0.7),
            size: 18,
          ),
        ],
      ),
      // SizedBox(height: 5.0),
      // Text('Derechos Reservados', style: TextStyle(fontSize: 12.0)),
    ],
  );
}
