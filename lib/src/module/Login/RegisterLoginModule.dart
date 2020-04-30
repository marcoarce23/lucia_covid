import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';

class RegisterLoginModule extends StatefulWidget {
  @override
  _RegisterLoginModuleState createState() => _RegisterLoginModuleState();
}

class _RegisterLoginModuleState extends State<RegisterLoginModule> {
  bool _save = false;
  final formKey = GlobalKey<FormState>();
  final generic = new Generic();
  final prefs = new PreferensUser();

  Hospital hospital = new Hospital();

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
              width: size.width * 0.85,
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
    return Column(
      children: <Widget>[
        Text('Crear cuenta con "Lucia"', style: TextStyle(fontSize: 20.0)),
        _crearEmail('Correo ELectrónico'),
        _crearPassword('Contraseña:'),
        _crearPassword('Repetir contraseña:'),
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

  Widget _crearEmail(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        maxLength: 30,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: text,
          hintText: 'ej: juan.perez@gmail.com',
          icon: Icon(Icons.alternate_email, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
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
        ),
        validator: (value) => validator.validateTextfieldLength(value, 6),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    if (hospital.nombre == null) {
      // generic.add(citizen);
      print("INSERTOOOO");
    } else {
      //  generic.update(citizen);
      print("MODIFICO");
    }

    setState(() {
      _save = false;
    });

    Navigator.of(context).push(PageRouteTheme(SignUpModule()));
  }


}