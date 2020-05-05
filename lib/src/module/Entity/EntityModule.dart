import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';


class EntityModule extends StatefulWidget {
  EntityModule({Key key}) : super(key: key);

  @override
  _EntityModuleState createState() => _EntityModuleState();
}

class _EntityModuleState extends State<EntityModule> {
 bool _save = false;
  File foto;
int _currentIndex;
  String _opcionSeleccionada = '';

  List<String> _expedido = [
    'Grupos de apoyo',
    'Farmacias',
    'Laboratorios',
    'Otros',
  ];
 
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Hospital hospital = new Hospital();

  @override
  void initState() {
_currentIndex = 0;
    _opcionSeleccionada = 'Grupos de apoyo';
    super.initState();
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _expedido.forEach((expedido) {
      lista.add(DropdownMenuItem(
        child: Text(expedido),
        value: expedido,
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
          crearFondoForm(context),
          _crearForm(context),
        ],
      ),
      drawer: DrawerCitizen(),
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('REGISTRO DE INSTITUCIONES', style: TextStyle(fontSize: 18, color: Colors.black),),
      backgroundColor: Colors.orange,
      actions: <Widget>[_crearIconAppImagenes(), _crearIconAppCamara()],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.blueGrey))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            callPageInstitucion(_currentIndex, context);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Institucion')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Horario Atención')),
         
        ],
      ),
    );
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
                height: 160.0,
              ),
            ),
            Container(
              width: size.width * 0.92,
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
        Text('INFORMACION GENERAL',  style: TextStyle(fontSize: 18, color: Colors.black),),
        _crearTipoInstitucion(),
        _crearNombre('Nombres de la Entidad/Institución'),
        _crearUbicacion('Ciudad'),
        _crearUbicacion('Dirección/Ubicación'),
 //       _crearFecha('Fecha'),
  //      _crearEstadoCovid(),
        _crearCallCenter('Telefono referencia'),
        _crearDetalle('Informacion complementaria'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Divider(color: Colors.orange, thickness: 2.0,),
        ),
        Text('REDES SOCIALES',  style: TextStyle(fontSize: 18, color: Colors.black),),
        crearFacebook('Cuenta Facebook'),
        crearTwitter('Cuenta Twitter'),
           crearPaginaWeb('Página Web'),
        crearYouTube('Cuenta YouTUbe'),
        _crearEmail('Correo ELectrónico'),
        
        _crearBoton(resource.save),
      ],
    );
  }

  Widget _crearDetalle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        textCapitalization: TextCapitalization.sentences,
        enableInteractiveSelection: true,
        enableSuggestions: true,
         maxLength: 150,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: text,
          labelText: text,
          icon: Icon(Icons.score, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }
  Widget crearYouTube(String text) {
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
          hintText: text,
          labelText: text,
          icon: Icon(Icons.score, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

Widget crearPaginaWeb(String text) {
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
          hintText: text,
          labelText: text,
          icon: Icon(Icons.person_pin, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

Widget crearInstagram(String text) {
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
          hintText: text,
          labelText: text,
          icon: Icon(Icons.person_pin, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

Widget crearTwitter(String text) {
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
          hintText: text,
          labelText: text,
          icon: Icon(Icons.person_pin, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }


 Widget crearFacebook(String text) {
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
          hintText: text,
          labelText: text,
          icon: Icon(Icons.person_pin, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
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
          hintText: text,
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
         maxLength: 100,
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

  Widget _crearCallCenter(String text) {
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

  Widget _crearTipoInstitucion() {
    return Row(
      children: <Widget>[
        SizedBox(width:22.0),
        Text('Tipo de institucion:'),
        SizedBox(width:22.0),

        DropdownButton(
          value: _opcionSeleccionada,
          icon: Icon(Icons.person_pin, color: Colors.orange),
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionada = opt;
            });
          },
        ),
      ],
    );
  }



  // Widget _crearEstadoCovid() {
  //   bool valor=true;
  //   return SwitchListTile(
  //     value: valor,
  //     title: Text('Centinela Covid',),
  //     activeColor: Colors.orange,
  //     onChanged: (value) => setState(() {
  //       valor= value;
  //     }),
  //   );
  // }

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
          labelText: 'Correo electrónico:',
          helperText: 'ej: juan.perez@gmail.com',
          icon: Icon(Icons.alternate_email, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
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
