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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Lucia te cuida@2020. ', style: kTitleCursive4Style),
          FaIcon(
            FontAwesomeIcons.keybase,
            color: Color.fromRGBO(165, 5, 5 , 0.7),
            size: 18,
          ),
        ],
      ),
    ],
  );
}
