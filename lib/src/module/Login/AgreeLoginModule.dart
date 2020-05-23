import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';

class AgreeLoginModule extends StatefulWidget {
  static final String routeName = 'login';
  @override
  _AgreeLoginModuleState createState() => _AgreeLoginModuleState();
}

class _AgreeLoginModuleState extends State<AgreeLoginModule> {
   
  InputCheckBox agree;
  InputEmailField correo;

  bool selectAgree = false;
  bool _save = false;
  int intAgree = 0;

  final formKey = GlobalKey<FormState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  LoginSigIn entity = new LoginSigIn();
 
 @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = AgreeLoginModule.routeName;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
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
              padding: EdgeInsets.symmetric(vertical: 25.0),
              decoration: _crearContenedorCampos(),
              child: _crearCampos(),
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
        prefs.correoElectronico,
        'Ingresar su correo electrónico',
        'ej: cuenta@correo.com', true);

    return Column(
      children: <Widget>[
        Text('TERMINOS Y USOS', style: TextStyle(fontSize: 20.0)),
        correo,
        SizedBox(height: 10.0),
        Divider(color:Colors.orange, thickness: 0.8, indent: 35.0, endIndent: 35.0,),
        Row(
          children: <Widget>[
            FaIcon(FontAwesomeIcons.user, color: Colors.orange),
            Expanded(child: Text('Por favor, lea cuidadosamente las condiciones de uso de la aplicación', style: TextStyle(fontSize: 18.0))),
          ],
        ),
       RichText(text: null) ,
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
        label: Text('Empezar'),
        icon: Icon(Icons.assignment_turned_in),
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

   Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IntroScreenModule()),
                );
  }
}
