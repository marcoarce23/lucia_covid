import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
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

  bool _save = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  LoginSigIn entity = new LoginSigIn();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  var result;

  GoogleSignInAccount currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

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
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      idunique = await ImeiPlugin.getId();
    } catch (error) {
      print(error);
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
    } catch (error) {
      print('rrrr: $error   y el valor token ${prefs.token}');
    }
      entity.idUsuario = currentUser.id;
      entity.idInstitucion = '-1';
      entity.nombrePersona = currentUser.displayName;
      entity.nombreInstitucion = '-1';
      entity.usuario = currentUser.email;
      entity.correo = currentUser.email;
      entity.avatar =  (currentUser.photoUrl == null) ? 'https://definicionyque.es/wp-content/uploads/2017/11/Medicina_Preventiva.jpg': currentUser.photoUrl;
      entity.password = '-1';
      entity.tokenDispositivo = prefs.token;
      entity.imei = _platformImei;
      entity.primeraVez = '-1';

 final dataMap = generic.add(entity, urlAddSignIn);

      await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
      print('resultado:$result ');

        if (result != "-1") {

          prefs.imei = int.parse(_platformImei);
          prefs.nombreUsuario= currentUser.displayName;
          prefs.correoElectronico = currentUser.email;
          prefs.avatarImagen =  currentUser.photoUrl;
          prefs.userId =result;

            Navigator.push(
            context,
            PageTransition(
              curve: Curves.bounceOut,
              type: PageTransitionType.rotate,
              alignment: Alignment.topCenter,
              child: IntroScreenModule(),
            ));
    
    }
    else
     scaffoldKey.currentState.showSnackBar(messageNOk("Se produjo un error, vuelta a intentarlo"));
 }

  Future<void> handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        body: Stack(
      children: <Widget>[
        crearFondo(context),
        _crearForm(context),
      ],
    ));
  }

  Widget _crearForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: 170.0,
              ),
            ),
            Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              // padding: EdgeInsets.symmetric( vertical: 30.0 ),
              decoration: _crearContenedorCampos(),
              child: _crearCampos(),
            ),
            SizedBox(height: 20.0),
            _dividerOr(),
            _gmailButton(),
            _registerCount(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: Colors.orange,
                thickness: 2.0,
              ),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    correo = InputEmailField(
        FaIcon(FontAwesomeIcons.user, color: Colors.orange),
        'Correo electrónico',
        '',
        'Ingresar su correo electrónico',
        'ej: cuenta@correo.com');
    contrasenia = InputTextPassword(
        FaIcon(FontAwesomeIcons.expeditedssl, color: Colors.orange),
        'Contraseña:',
        '',
        'Ingrese su contraseña');
    return Column(
      children: <Widget>[
        SizedBox(height: 15.0),
        Text(
          'LUCIA TE CUIDA',
          style: TextStyle(fontSize: 18, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        SizedBox(width: 5.0),
        FaIcon(
          FontAwesomeIcons.keybase,
          color: Colors.blue,
          size: 20,
        ),
        correo,
        contrasenia,
        _crearBoton(resource.signIn),
        _forgetPassword(),
      ],
    );
  }

  _crearContenedorCampos() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: Offset(0.0, 5.0),
              spreadRadius: 3.0)
        ]);
  }

  Widget _crearBoton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 65.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: Colors.blue,
        textColor: Colors.white,
        label: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        icon: Icon(Icons.check),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    entity.idUsuario = '0';
    entity.idInstitucion = '-1';
    entity.nombrePersona = '0';
    entity.nombreInstitucion = '0';
    entity.usuario = correo.objectValue;
    entity.avatar = '';
    entity.password = contrasenia.objectValue;
    entity.tokenDispositivo = prefs.token;
    entity.imei = _platformImei;

    final dataMap = generic.add(entity, urlAddSignIn);

    await dataMap.then((x) => result = x["TIPO_RESPUESTA"]);
  
    if (result != '-1') {
      prefs.imei = int.parse(_platformImei);
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
            child: IntroScreenModule(),
          ));
    } else {
      Navigator.push(
          context,
          PageTransition(
            curve: Curves.bounceOut,
            type: PageTransitionType.rotate,
            alignment: Alignment.topCenter,
            child: SignUpModule(),
          ));
    }
    setState(() {
      _save = false;
    });
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
          Text('SI CUENTAS CON CORREO GMAIL'),
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

  Widget _forgetPassword() {
    return FlatButton(
        child: Text('Olvidaste tu contraseña ?'), onPressed: ()  => Navigator.push(
          context,
          PageTransition(
            curve: Curves.bounceOut,
            type: PageTransitionType.rotate,
            alignment: Alignment.topCenter,
            child: ForgetPassword(),
          ))
          );
  }

  _registerCount() {
    return FlatButton(
        child: Text('Crea una nueva cuenta. Aqui.'), onPressed: () => Navigator.push(
          context,
          PageTransition(
            curve: Curves.bounceOut,
            type: PageTransitionType.rotate,
            alignment: Alignment.topCenter,
            child: ForgetPassword(),
          ))
        
      );
    //       Navigator.of(context).push(PageRouteTheme(AgreeLoginModule())));
  }

  Widget _gmailButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
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
                'Registrate con Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
