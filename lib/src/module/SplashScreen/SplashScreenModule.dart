import 'package:flutter/material.dart';
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
      seconds: 5,
      navigateAfterSeconds: new SignUpModule(),
      title: new Text(
        'LUCIA TE CUIDA',
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
      image: Image(
        image: AssetImage('assets/image/COVID-19.png'),
        width: MediaQuery.of(context).size.width / 2,
        fit: BoxFit.contain,
      ),
      backgroundColor: Colors.black,
      photoSize: 100.0,
      gradientBackground: RadialGradient(
        colors: [
          Color(0xFF3594DD),
          Color(0xFF4563DB),
          Color(0xFF5036D5),
          Color(0xFF5B16D0),
        ],
      ),
    );
  }
}
//RadialGradient