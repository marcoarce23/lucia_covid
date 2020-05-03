import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenNews/CitizenNewsModule.dart';
import 'package:lucia_covid/src/module/CitizenPage/CitizenModule.dart';
import 'package:lucia_covid/src/module/InitialPages/SlideShowModule.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
import 'package:lucia_covid/src/module/Login/RegisterLoginModule.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/SplashScreenModule.dart';
import 'package:lucia_covid/src/module/Voluntary/VoluntaryModule.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferensUser();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new PreferensUser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'resource.titleApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
      ),
      //home: new ListCitizenModule(),
      //initialRoute: SplashScreenModule(),

      home: new CitizenLayoutMenuModule(),//(,//IntroScreen(),

      routes: <String, WidgetBuilder>{
        'Splash': (BuildContext context) => new SplashScreenModule(),
        'citizen': (BuildContext context) => new CitizenModule(),
        'login': (BuildContext context) => new SignUpModule(),
        'forgetPassword': (BuildContext context) => new ForgetPassword(),
        'registerLogin': (BuildContext context) => new RegisterLoginModule(),
        'sliderShowModule': (BuildContext context) => new SliderShowModule(),
      },
    );
  }
}
