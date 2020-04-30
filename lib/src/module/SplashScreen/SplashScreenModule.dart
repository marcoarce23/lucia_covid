import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:lucia_covid/src/module/InitialPages/SlideShowModule.dart';


class SplashScreenModule extends StatefulWidget {
  @override
  SplashScreenModuleState createState() => SplashScreenModuleState();
}

class SplashScreenModuleState extends State<SplashScreenModule> {  

  @override
  Widget build(BuildContext context) {
    return  SplashScreen( seconds: 5,
      navigateAfterSeconds: new SliderShowModule(),
      title: new Text('Prevencion COVID-19', style:TextStyle( fontSize: 25, color: Colors.white )  ,),
      image:  Image(
            image: AssetImage('assets/image/COVID-19.png'),
            width: MediaQuery.of(context).size.width / 2,
            fit: BoxFit.contain,
          ),
      backgroundColor: Colors.black,
      
      photoSize: 100.0,
      loaderColor: Colors.white);
    /*return Scaffold(
      body: Stack(
        children: <Widget>[
          _ImagenLogo(),
        ],
      ),
    );
    */
  }
     
}
