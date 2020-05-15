import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Provider/PushNotificationProvider.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenEmergency/CitizenEmergencyModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenEvents/CitizenEventsModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenHelpModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/ListCitizenHelpModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenInstitution/CitizenListInstitucionModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenMultimedia/CitizenMultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenPanicButton/CitizenPanicButtonModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenPanicButton/ListCitizenPanic.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/AtentionEntityodule.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/EntityModule.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/ListEntityModule.dart';
import 'package:lucia_covid/src/module/Citizen/Multimedia/ListMultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/Multimedia/MultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/AtentionModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/EventModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/FoundVoluntaryModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/ListEventModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/ListVoluntary.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/VoluntaryModule.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Login/AgreeLoginModule.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';
import 'package:lucia_covid/src/module/Map/MapAdressModule.dart';
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

    pushProvider.mensajes.listen((data) {
      //   // Navigator.pushNamed(context, 'mensaje');
      //   print('Argumento del Push');
      //   print(data);

      //   navigatorKey.currentState.pushNamed('mensaje', arguments: data );
      prefs.token = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

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
      home: new HomePageModule(),//MapAdressModule(),

        routes: <String, WidgetBuilder>{
        'login': (BuildContext context) => new SignUpModule(),
        'forget': (BuildContext context) => new ForgetPassword(),
        'agree': (BuildContext context) => new AgreeLoginModule(),
        'introScreen': (BuildContext context) => new IntroScreenModule(),
        'home': (BuildContext context) => new HomePageModule(),
        'mapAtencion': (BuildContext context) => new MapAdressModule(),
        'voluntary': (BuildContext context) => new VoluntaryModule(),
        'lisVoluntary': (BuildContext context) => new ListVoluntaryModule(),
        'ListEventVoluntary': (BuildContext context) => new ListEventModule(),
        'eventVoluntary': (BuildContext context) => EventModule(),
        'atentionVoluntary': (BuildContext context) => AtentionModule(),
        'multimedia': (BuildContext context) => MultimediaModule(),
        'lisMultimedia': (BuildContext context) => ListMultimediaModule(),
        'AtentionEntity': (BuildContext context) => AtentionEntityModule(),
        'entidad': (BuildContext context) => new EntityModule(),
        'listaEntidad': (BuildContext context) => new ListEntityModule(),
        'eventEntity': (BuildContext context) => new ListEntityModule(),
'helpCitizen': (BuildContext context) => new  CitizenHelpModule(),


      //  "CiudadanoAlertaEmergencia":(BuildContext context)=> new  CitizenAlertEmergency(),
        "CiudadanoEmergencia": (BuildContext context) =>     new CitizenEmergencyModule(),
        "CiudadanoEventos": (BuildContext context) => new CitizenEventsModule(),
        //"CiudadanoEventosDetalle":(BuildContext context)=> new CitizenEventsDetailModule(),
        "ListaCiudadanoAyuda": (BuildContext context) =>     new ListCitizenHelpModule(),
        //"CiudadanoInstitucion":(BuildContext context)=> new CitizenInstitutionModule(),
        "ListaInstituciones": (BuildContext context) =>     new CitizenListInstitucionModule(),
        //"ImagenDetalle":(BuildContext context)=> new CitizenImageDetailModule(),
        "CiudadanoMultimedia": (BuildContext context) =>    new CitizenMultimediaModule(),
        "CiudadanoBotonPanico": (BuildContext context) =>   new CitizenPanicButtonModule(),
        "ListaCiudadanoPanico": (BuildContext context) =>   new ListCitizenPanic(),
        //"EncontrarTodosLosVoluntariosPorGrupo":(BuildContext context)=> new FoundAllVoluntaryGroupModule(),
        //"EncontrarTodosLosVoluntarios":(BuildContext context)=> new FoundAllVoluntaryModule(),
        "EncuentraVoluntario": (BuildContext context) => new FoundVoluntaryModule(),
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