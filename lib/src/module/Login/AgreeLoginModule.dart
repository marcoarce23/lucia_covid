import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';

class AgreeLoginModule extends StatefulWidget {
  @override
  _AgreeLoginModuleState createState() => _AgreeLoginModuleState();
}

class _AgreeLoginModuleState extends State<AgreeLoginModule> {
  bool _save = false;
  final formKey = GlobalKey<FormState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;
  LoginSigIn entity = new LoginSigIn();
InputCheckBox agree;
  bool selectAgree = false;

  int intAgree = 0;

  InputEmailField correo;

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
                height: 180.0,
              ),
            ),
            Container(
              width: size.width * 0.92,
    //          margin: EdgeInsets.symmetric(vertical: 0.0),
             padding: EdgeInsets.symmetric( vertical: 25.0 ),
              decoration: _crearContenedorCampos(),
              child     : _crearCampos(),
            ),
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
        
    return Column(
      children: <Widget>[
        Text('Crear cuenta con "Lucia"', style: TextStyle(fontSize: 20.0)),
     correo,
 agree = InputCheckBox('Acepto', selectAgree),
        _crearBoton(resource.signIn),
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
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.blue,
        textColor: Colors.white,
        label: Text(resource.createAccount),
        icon: Icon(Icons.save),
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

    

    setState(() {
      _save = false;
    });

    Navigator.of(context).push(PageRouteTheme(IntroScreenModule()));
  }


}