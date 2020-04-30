import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/module/InitialPages/SlideShowModule.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
import 'package:lucia_covid/src/module/Login/RegisterLoginModule.dart';

class SignUpModule extends StatefulWidget {
  @override
  _SignUpModuleState createState() => _SignUpModuleState();
}

class _SignUpModuleState extends State<SignUpModule> {
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
                height: 170.0,
              ),
            ),
            Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              // padding: EdgeInsets.symmetric( vertical: 30.0 ),
              decoration: _crearContenedorCampos(),
              child     : _crearCampos(),
            ),
            _dividerOr(),
            _gmailButton(),
            _registerCount(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    return Column(
      children: <Widget>[
        Text('Bienvenido a "Lucia Te Cuida."', style: TextStyle(fontSize: 20.0)),
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
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.blue,
        textColor: Colors.white,
        label: Text(text),
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
        //  hintText: 'Ingrese el correo elecrrónico válido',
         focusColor: Colors.blue,
          labelText:  'Correo electrónico:',
          helperText: 'ej: juan.perez@gmail.com',
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
           helperText: 'Nota: caracter especial, un numero.',
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

    Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
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
          SizedBox(height: 30.0),
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
        onPressed: () => //Navigator.of(context).pushNamed('forgetPassword'),
            Navigator.of(context).push(PageRouteTheme(ForgetPassword())));
  }

  _registerCount() {
    return FlatButton(
      child: Text('Crea una nueva cuenta. Aqui.'),
      onPressed: () =>  Navigator.of(context).push(PageRouteTheme(RegisterLoginModule()))
      );
      // Navigator.of(context).pushNamed('registerLogin'),
  }

  Widget _gmailButton() {
    // return Container(
    //   height: 50,
    //   margin: EdgeInsets.symmetric(vertical: 5),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(10)),
    //   ),
    //   child: Row(
    //     children: <Widget>[
    //       Expanded(
    //         flex: 1,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             color: Colors.red,
    //             borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(5),
    //                 topLeft: Radius.circular(5)),
    //           ),
    //           alignment: Alignment.center,
    //           child: Text('G',
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 25,
    //                   fontWeight: FontWeight.w400)),
    //         ),
    //       ),
    //       Expanded(

    //         child: Container(

    //             decoration: BoxDecoration(

    //               color: Colors.red,
    //               borderRadius: BorderRadius.only(
    //                   bottomRight: Radius.circular(5),
    //                   topRight: Radius.circular(5)),
    //             ),
    //             alignment: Alignment.center,
    //             child: InkWell(
    //               onTap: () {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => CitizenLayoutMenuModule()));
    //               },
    //               child: Text(
    //                 'GMail',
    //                 style: TextStyle(fontSize: 20, color: Colors.white),
    //               ),
    //             )),
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.orange,
        textColor: Colors.white,
        label: Text('GMail'),
        icon: Icon(Icons.mail_outline),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }
}
