import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Util/Resource.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenModule extends StatefulWidget {
  @override
  SplashScreenModuleState createState() => SplashScreenModuleState();
}

class SplashScreenModuleState extends State<SplashScreenModule> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 7,
      navigateAfterSeconds: new SignUpModule(),
     
      photoSize: 250,
      image: Image(
        image: AssetImage('assets/fondo.png') ,       
        fit: BoxFit.cover,
      ),
    
  
    );
  }
}
//RadialGradient