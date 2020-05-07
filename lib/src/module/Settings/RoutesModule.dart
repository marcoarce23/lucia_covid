
import 'package:flutter/material.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
import 'package:lucia_covid/src/module/Login/RegisterLoginModule.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/SplashScreenModule.dart';

Map<String, WidgetBuilder> getApplicationRoute() {
  return <String, WidgetBuilder>{
     'Splash': (BuildContext context) => new SplashScreenModule(),
        'citizen': (BuildContext context) => new CitizenLayoutMenuModule(),
        'login': (BuildContext context) => new SignUpModule(),
        'forgetPassword': (BuildContext context) => new ForgetPassword(),
        'registerLogin': (BuildContext context) => new RegisterLoginModule(),
        'introScreen': (BuildContext context) => new IntroScreenModule(),
  };
}


  // METODOS GET
  final String primaryKeyGetClasifidor = '_DevuelveClasificadorResult';
  String urlGetClasificador  = 'http://covid19.ruta88.net/COVID/Clasificador/srvClasificador.svc/Clasificador/';

 // METODO POST
    final String urlAddVoluntary     = 'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/AyudaAmigo';
    final String urlAddSignIn     = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    final String urlAddInstitucion     = 'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/Institucion';
    final String urlAddPersonal    = 'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/Personal';


// METODO DELETE

    // final String urlGetSignIn     = 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
    
    // final String urlUpdateSignIn  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlDeleteSignIn  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';

    // final String primaryKeyEntity = '_devuelveHospitalesResult';
    // final String urlGetEntity     = 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
    
    // final String urlUpdateEntity  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlDeleteEntity  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';

    // final String primaryKeyVoluntary = '_devuelveHospitalesResult';
    // final String urlGetVoluntary     = 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
    
    // final String urlUpdateVoluntary  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlDeleteVoluntary  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';

    // final String primaryKeyMultimedia = '_devuelveHospitalesResult';
    // final String urlGetMultimedia    = 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
    // final String urlAddMultimedia     = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlUpdateMultimedia = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlDeleteMultimedia  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';

    // final String primaryKeyEventEntity = '_devuelveHospitalesResult';
    // final String urlGetEventEntity    = 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
    // final String urlAddEventEntity    = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlUpdateEventEntity = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlDeleteEventEntity  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';

    // final String primaryKeyEventVoluntary = '_devuelveHospitalesResult';
    // final String urlGetEventVoluntary    = 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
    // final String urlAddEventVoluntary    = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlUpdateEventVoluntary = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlDeleteEventVoluntary  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';

    // final String primaryKeyHelp = '_devuelveHospitalesResult';
    // final String urlGetHelp    = 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
    // final String urlAddHelp   = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlUpdateHelp = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlDeleteHelp  = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';

    // final String primaryKeyPanic = '_devuelveHospitalesResult';
    // final String urlGetPanic    = 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
    // final String urlAddPanic   = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlUpdatePanic = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    // final String urlDeletePanic = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';

