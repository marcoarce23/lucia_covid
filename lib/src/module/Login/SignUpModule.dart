import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
import 'package:lucia_covid/src/module/Login/RegisterLoginModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';

class SignUpModule extends StatefulWidget {
  static final String routeName = 'login';

  @override
  _SignUpModuleState createState() => _SignUpModuleState();
}

class _SignUpModuleState extends State<SignUpModule> {
  bool _save = false;
  final formKey = GlobalKey<FormState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  LoginSignIn login = new LoginSignIn();
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

    platformImei =
        await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    idunique = await ImeiPlugin.getId();

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
    // try {
    await _googleSignIn.signIn();

    login.id = currentUser.id;
    login.email = currentUser.email;
    login.persona = currentUser.displayName;
    login.avatar = 'currentUser.photoUrl';
    login.imei = _platformImei;

    print('iddd:${login.id}');
    print('IMEI:${login.imei}');
    final dataMap = generic.add(login);

    await dataMap.then((x) => result = x["TIPO_RESPUESTA"]);
    print('DDDDD:$result');
    if (result == '0')
      Navigator.push(context, PageTransition(
                      curve: Curves.bounceOut,
                      type: PageTransitionType.rotate,
                      alignment: Alignment.topCenter,
                      child: IntroScreenModule(),
                ));
    else
      Navigator.of(context).push(PageRouteTheme(SignUpModule()));
    // catch(Exception error){error.toString();}
  }

  Future<void> handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
    return Column(
      children: <Widget>[
        SizedBox(height: 15.0),
        Text('Bienvenido a "Lucia Te Cuida."',
            style: TextStyle(fontSize: 20.0)),
        _crearEmail('Correo ELectrónico'),
        _crearPassword('Contraseña:'),
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
          'Ingresar',
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

  Widget _crearEmail(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: login.email,
        enableInteractiveSelection: true,
        maxLength: 30,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: 'Correo electrónico:',
          helperText: 'ej: juan.perez@gmail.com',
          icon: Icon(Icons.alternate_email, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => login.email = value,
      ),
    );
  }

  Widget _crearPassword(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        maxLength: 10,
        decoration: InputDecoration(
          labelText: text,
          icon: Icon(Icons.lock_outline, color: Colors.orange),
          helperText: 'Nota: caracter especial, un numero.',
        ),
        validator: (value) => validator.validateTextfieldLength(value, 6),
        onSaved: (value) => login.id = value,
      ),
    );
  }

  void _submit() async {

      login.id  = currentUser.id;
      login.email  = currentUser.email;
      login.persona  = currentUser.displayName;
      login.avatar  = 'currentUser.photoUrl';

    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => IntroScreenModule()));

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    // if (true) {
    //   // generic.add(citizen);
    //     Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => IntroScreenModule()));
    // }
    // else
    // {

    // }
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
          Text('PARA PÚBLICO EN GENERAL'),
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
        child: Text('Olvidaste tu contraseña ?'),
        onPressed: () =>  Navigator.of(context).push(PageRouteTheme(ForgetPassword())));
  }

  _registerCount() {
    return FlatButton(
        child: Text('Crea una nueva cuenta. Aqui.'),
        onPressed: () =>
            Navigator.of(context).push(PageRouteTheme(RegisterLoginModule())));
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
