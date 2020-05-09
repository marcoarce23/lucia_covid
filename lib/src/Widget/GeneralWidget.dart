
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

   Widget copyRigth() {
     
     return    Column(
       mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
     
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width:160.0),
                Text('Lucia de cuida. ', style: TextStyle(fontSize: 14.0)),
                FaIcon(
              FontAwesomeIcons.cat,
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
