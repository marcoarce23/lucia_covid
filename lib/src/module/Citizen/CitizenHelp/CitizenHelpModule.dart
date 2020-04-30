import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;

class CitizenHelpModule extends StatefulWidget {


  @override
  _CitizenHelpModuleState createState() => _CitizenHelpModuleState();
}

class _CitizenHelpModuleState extends State<CitizenHelpModule> {
 bool _save = false;
  File foto;

  String _opcionSeleccionadaTipoAyuda = '';
  String _opcionSeleccionadaPrioridad = '';

  List<String> _tipoPrioridad = ['<Seleccionar_Prioridad>',
    'Muy Alta',
    'Alta',
    'Media'
  ];

   List<String> _tipoAyuda = [ '<Seleccionar_Ayuda>',
    'Salud - Covid',
    'Salud',
    'Económica',
    'Alimentación'
  ];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Hospital hospital = new Hospital();

  @override
  void initState() {

    _opcionSeleccionadaTipoAyuda = '<Seleccionar_Ayuda>';
    _opcionSeleccionadaPrioridad= '<Seleccionar_Prioridad>';

    super.initState();
  }



  List<DropdownMenuItem<String>> getOpcionesTipoAyuda() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoAyuda.forEach((tipoAyuda) {
      lista.add(DropdownMenuItem(
        child: Text(tipoAyuda),
        value: tipoAyuda,
      ));
    });
    return lista;
  }

List<DropdownMenuItem<String>> getOpcionesPrioridad() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoPrioridad.forEach((tipoPrioridad) {
      lista.add(DropdownMenuItem(
        child: Text(tipoPrioridad),
        value: tipoPrioridad,
      ));
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final Hospital hospitalData = ModalRoute.of(context).settings.arguments;

    if (hospitalData != null) hospital = hospitalData;



    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(),
      body: Stack(
        children: <Widget>[
          _crearForm(context),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('AYUDA A UN AMIG@'),
      backgroundColor: Colors.orange,
      actions: <Widget>[_crearIconAppImagenes(), _crearIconAppCamara()],
    );
  }

Widget informacionProfesional(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.black12,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                imagenProfesional(),
                RichText(
                  text: TextSpan(
                    text: 'Corina Balderrama.', // 'Dr Dan MlayahFX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '\n' + 'Carnet: 4538412 CBB',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n' + 'CElular: 72038768',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                crearIconoProfesional(Icons.mail, 'Correo'),
                crearIconoProfesional(Icons.phone, 'Correo'),
                crearIconoProfesional(Icons.bug_report, 'Ayuda con covid'),
              ],
            ),
          ],
        ),
      ),
    );
  }

Image imagenProfesional() {
    Image imagenAvatar;

    //if (profesionalesDeInstitucion.sexo == "F") {
      imagenAvatar = Image.asset(
        "assets/image/circled_user_female.png",
        width: 50,
        height: 50,
        fit: BoxFit.fill,
       );
    // } else {
    //   imagenAvatar = Image.asset(
    //     "assets/image/circled_user_male.png",
    //     width: 50,
    //     height: 50,
    //     fit: BoxFit.fill,
    //   );
    // }
    return imagenAvatar;
  }

  Column crearIconoProfesional(icon, title) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _crearForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
              informacionProfesional(context),

            SafeArea(
              child: Container(
                height: 10.0,
              ),
            ),


            Container(
              width: size.width * 0.90,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: _crearContenedorCampos(),
              child: _crearCampos(),
            ),
            crearLucia(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    return Column(
      children: <Widget>[
          Text('AYUDA A UN AMIG@', style: TextStyle(fontSize: 18, color: Colors.black),),
        _crearNombre('Persona a poyar'),
        _crearTelefonoContacto('Telefono de referencia'),
        _crearUbicacion('Ubicación'),
       
           _crearTipoApoyo(),
         
        _crearTipoPrioridad(),
        _crearBoton(resource.save),
      ],
    );
  }

  Widget _crearNombre(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        textCapitalization: TextCapitalization.sentences,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: 'Nombre',
          labelText: text,
          icon: Icon(Icons.person_pin, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearUbicacion(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: text,
          icon: Icon(Icons.person_outline, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearTelefonoContacto(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        keyboardType: TextInputType.number,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: text,
          icon: Icon(Icons.phone, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearTipoApoyo() {
    return Row(
      children: <Widget>[
    SizedBox(width:30.0),
       
        Text('Tipo de apoyo:'),
         SizedBox(width: 15.0),

        DropdownButton(
          value: _opcionSeleccionadaTipoAyuda,
          icon: Icon(Icons.person_pin, color: Colors.orange),
          items: getOpcionesTipoAyuda(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionadaTipoAyuda = opt;
            });
          },
        ),
      ],
    );
  }

Widget _crearTipoPrioridad() {
    return Row(
      children: <Widget>[
SizedBox(width:35.0),
       
        Text('Prioridad:'),
         SizedBox(width: 15.0),

        DropdownButton(
          value: _opcionSeleccionadaPrioridad,
          icon: Icon(Icons.person_pin, color: Colors.orange),
          items: getOpcionesPrioridad(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionadaPrioridad = opt;
            });
          },
        ),
      ],
    );
  }

  _crearContenedorCampos() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(0.0, 5.0),
              spreadRadius: 7.0)
        ]);
  }

  _crearIconAppImagenes() {
    return IconButton(
      icon: Icon(Icons.photo_size_select_actual),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: Icon(Icons.camera_alt),
      onPressed: _tomarFoto,
    );
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

  _submit() async {
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

    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
  }
  _seleccionarFoto() async => _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => _procesarImagen(ImageSource.camera);
  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      hospital.nombre = null;
    }
    setState(() {});
  }
}
