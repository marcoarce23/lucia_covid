import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Provider/PushNotificationProvider.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';
import 'package:lucia_covid/src/module/Map/MapAdressModule.dart';
import 'package:lucia_covid/src/module/Map/MapPositionModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferensUser();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final prefs = new PreferensUser();
 
  @override
  void initState() {
    super.initState();

     final pushProvider = new PushNotificationProvider();
     pushProvider.initNotifications();

     pushProvider.mensajes.listen( (data) {

    //   // Navigator.pushNamed(context, 'mensaje');
    //   print('Argumento del Push');
    //   print(data);

    //   navigatorKey.currentState.pushNamed('mensaje', arguments: data );
        prefs.token = data;
     });

  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));

    return MaterialApp(
      title: 'resource.titleApp',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
      ),
       // MULTILENGUAGE
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('en', 'US'), // English
      //   const Locale('es', 'ES'), // Hebrew
      // ],


     // initialRoute: prefs.ultimaPagina,
      home: new IntroScreenModule(),//MapAdressModule(),

        routes: <String, WidgetBuilder>{
        'login': (BuildContext context) => new SignUpModule(),
        'forget': (BuildContext context) => new ForgetPassword(),
        'introScreen': (BuildContext context) => new IntroScreenModule(),
        'home': (BuildContext context) => new HomePageModule(),

      },
    );
  }
}

































      // routes: <String, WidgetBuilder>{
      //   'Splash': (BuildContext context) => new SplashScreenModule(),
      //   'citizen': (BuildContext context) => new CitizenModule(),
      //   'login': (BuildContext context) => new SignUpModule(),
      //   'forgetPassword': (BuildContext context) => new ForgetPassword(),
      //   'registerLogin': (BuildContext context) => new AgreeLoginModule(),
      //   'sliderShowModule': (BuildContext context) => new SliderShowModule(),
      //   'mensaje': (BuildContext context) => new MensajePage(),
      // },