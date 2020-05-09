
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

  //////          MARCO           //////
  // METODOS GET
  final String primaryKeyGetClasifidor = '_DevuelveClasificadorResult';
  String urlGetClasificador  = 'http://covid19.ruta88.net/COVID/Clasificador/srvClasificador.svc/Clasificador/';

  final String primaryKeyGetAyudaAmigo= '_DevuelveAyudasResult';
  String urlGetDevuelveAyuda =   'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/DevuelveAyudas';

  final String primaryKeyGetInsitucion= '_DevuelveInstitucionesResult';
  String urlGetInstitucion =   'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveInstitucion';

  final String primaryKeyGetVoluntario = '_DevuelvePersonalResult';
  String urlGetVoluntario =   'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/DevuelvePersonal';

  String urlGetAtencion =  'http://covid19.ruta88.net/COVID/Atencion/srvAtencion.svc/DevuelveAtencion/{pIdInstitucion}/{pIdPersonal} ';
  String urlGetMultimedia = 'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/Multimedia';
  String urlGetEvento = 'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/MultimediaXX';

 // METODO POST
    final String urlAddVoluntary     = 'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/AyudaAmigo';
    final String urlAddSignIn     = 'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
    final String urlAddInstitucion     = 'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/Institucion';
    final String urlAddPersonal    = 'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/Personal';
    final String urlAddMultimedia = 'http://covid19.ruta88.net/COVID/Multimedia/srvMultimedia.svc/Multimedia';
    final String urlAddEvento = 'http://covid19.ruta88.net/COVID/Evento/srvEvento.svc/Evento';

// METODO DELETE
  final String urlDeleteAyudaAmigo =  'http://covid19.ruta88.net/COVID/AyudaAmigo/srvAyudaAmigo.svc/EliminarAyudaAmigo/';
  final String urlDeleteVoluntario =  'http://covid19.ruta88.net/COVID/Personal/srvPersonal.svc/EliminarPersonal/';
 final String urlDeleteInstitucion =  'http://covid19.ruta88.net/COVID/Institucion/srvInstitucion.svc/DevuelveInstitucion/EliminarInstitucion';



