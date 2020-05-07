import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';


class InConstruction extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
        elevation: 0,
        title: Center(
          child: Text(
            "En construccion",
            style: TextStyle(
                color: AppTheme.themeColorNaranja,
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
        ),
        //backgroundColor: AppTheme.themeColorNaranja,
      )

    );
    
    
     }
}