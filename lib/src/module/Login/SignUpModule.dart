import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Login/AgreeLoginModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'package:imei_plugin/imei_plugin.dart';

class SignUpModule extends StatefulWidget {
  static final String routeName = 'login';

  @override
  _SignUpModuleState createState() => _SignUpModuleState();
}

class _SignUpModuleState extends State<SignUpModule> {
  InputEmailField correo;
  InputTextPassword contrasenia;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  LoginSigIn entity = new LoginSigIn();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  String result2;
  var result;
  var result1;
  
  GoogleSignInAccount currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  get respuesta => null;

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = SignUpModule.routeName;
    initPlatformState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> initPlatformState() async {
    String platformImei = 'Failed to get platform version.';
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =  await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      idunique = await ImeiPlugin.getId();
    } catch (error) {
       scaffoldKey.currentState.showSnackBar(messageNOk('Se produjo un error: ${error.toString()}'));
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
      uniqueId = idunique;
    });
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      
      final dataMap1 = generic.getAll(
          entity, getLogin + '${currentUser.email}', primaryKeyGetLogin);

      dataMap1.then((value) {
        if (value.length > 0) {
          for (int i = 0; i < value.length; i++) {
            entity = value[i];
          }
          prefs.imei = entity.imei;
          prefs.nombreUsuario = entity.nombrePersona;
          prefs.correoElectronico = entity.correo;
          prefs.avatarImagen = entity.avatar;

          prefs.nombreInstitucion = entity.nombreInstitucion;
          prefs.idInsitucion = entity.idInstitucion;
          prefs.idPersonal = entity.idPersonal;
          prefs.userId = entity.idUsuario;

          Navigator.push(
              context,
              PageTransition(
                curve: Curves.bounceOut,
                type: PageTransitionType.rotate,
                alignment: Alignment.topCenter,
                child: IntroScreenModule(),
              ));
        } else {
          entity.idUsuario = currentUser.id;
          entity.idInstitucion = '-1';
          entity.nombrePersona = currentUser.displayName;
          entity.nombreInstitucion = '-1';
          entity.usuario = currentUser.email;
          entity.correo = currentUser.email;
          entity.avatar = (currentUser.photoUrl == null)
              ? 'https://definicionyque.es/wp-content/uploads/2017/11/Medicina_Preventiva.jpg'
              : currentUser.photoUrl;
          entity.password = '-1';
          entity.tokenDispositivo = prefs.token;
          entity.imei = _platformImei;
          entity.primeraVez = '-1';

          final dataMap = generic.add(entity, urlAddSignIn);
          dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
          //     print('resultado:$result ');

          if (result != "-1") {
            prefs.imei = _platformImei;
            prefs.nombreUsuario = currentUser.displayName;
            prefs.correoElectronico = currentUser.email;
            prefs.avatarImagen = currentUser.photoUrl;
            prefs.userId = result;

            Navigator.push(
                context,
                PageTransition(
                  curve: Curves.bounceOut,
                  type: PageTransitionType.rotate,
                  alignment: Alignment.topCenter,
                  child: AgreeLoginModule(),
                ));
          } else {
            scaffoldKey.currentState.showSnackBar(
                messageNOk("Se produjo un error, vuelta a intentarlo"));
          }
        }
      });
    } catch (error) {
      scaffoldKey.currentState
          .showSnackBar(messageNOk('Se produjo un error: ${error.toString()}'));
    }
  }

  Future<void> handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: <Widget>[
            //   crearFondo(context),
            Container(
              
               decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.4, 0.7, 0.9],
                  colors: [
                    Color.fromRGBO(215, 78, 159, 1.0),
                    Color.fromRGBO(245, 173, 53, 1.0),
                    Color.fromRGBO(236, 220, 109, 1.0),
                    Color.fromRGBO(70, 191, 167 , 1.0),
               //      Color.fromRGBO(90, 150, 188 , 1.0),
              //        Color.fromRGBO(133, 75, 178  , 1.0),
                  ],
                ),
              ),
            
            

             child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text('Estamos contigo. Beinvenido', style: kTitleCursiveStyle),
                          Text('Lucia Te Cuida. La App de nuestro corazón'),
                          Image(
                              image: AssetImage("assets/buu.PNG"),
                              height: 250.0),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _crearForm(context),
                  ],
                ),
              ),
              ),
           
          ],
        ));
  }

  Widget _crearForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
       
            //     Container(
            //       width: size.width * 0.85,
            //       margin: EdgeInsets.symmetric(vertical: 10.0),
            //       // padding: EdgeInsets.symmetric( vertical: 30.0 ),
            //      // decoration: _crearContenedorCampos(),
            //  //     child: _crearCampos(),
            //     ),


            SizedBox(height: 20.0),

            _dividerOr(),
            _gmailButton(),
            _gmailButtonCerrar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: Colors.lightGreen,
                thickness: 2.0,
              ),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _dividerOr() {
    return Container(
      //   margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text('Si cuentas con correo GMAIL', style: kTitleCursive3Style,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gmailButton() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Inciar sesión con Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _gmailButtonCerrar() {
    return OutlineButton(
      splashColor: Colors.black,
      onPressed: handleSignOut,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '    Cerrar sesión Google   ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
