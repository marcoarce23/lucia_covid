
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EmployeeModule extends StatefulWidget {
  @override
  _EmployeeModuleState createState() => _EmployeeModuleState();
}

class _EmployeeModuleState extends State<EmployeeModule> {
 
 bool _save = false;
  File foto;
  
  String _opcionSeleccionada = '';
  String _fecha = '';
  TextEditingController _inputFieldDateController = new TextEditingController();
  List<String> _expedido = ['CHQ','LPZ','CBB','ORU', 'PTS','TRJ', 'SCZ','BNI', 'PND' ];
  int _selectedRadio;


  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Hospital hospital = new Hospital();

  @override
  void initState() {
    _selectedRadio = 0;
    _opcionSeleccionada = 'LPZ';
    super.initState();
  }


  _setSelectedRadio(int value) {
    setState(() {
      _selectedRadio = value;
    });
  }

_selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020,3),
      lastDate: new DateTime(2025,12),
      //    locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.toString().substring(0, 10);
        _inputFieldDateController.text = _fecha;
      });
    }
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
        )
    );
  }

  AppBar _appBar() {
      return AppBar(
          title: Text('Registro de Funcionarios Públicos'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            _crearIconAppImagenes(), 
            _crearIconAppCamara()
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
            SafeArea(
              child: Container(
                height: 160.0,
              ),
            ),
            Container(
              width: size.width * 0.85,
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
        _crearNombre('Nombres:'),
        _crearApellidos('Apellidos:'),
        Row( children: <Widget>[
            Expanded(
              child: _crearCI('Documento de Identidad'),),
             _crearExpedido(),
          ],
        ),
        _crearTelefono('Telefono'),
        _crearSexo('Sexo'),
        _crearEmail('Correo ELectrónico'),
        _crearFechaNacimiento('Fecha de Nacimiento:'),
        _crearObservacion('Observación'),
        _crearBoton(resource.save),
        // _forgetPassword(),
      ],
      
    );
  }

  Widget _crearObservacion(String text) {
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
          icon: Icon(Icons.edit, color: Colors.orange),
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
          hintText: 'Nombre',
          labelText: text,
          icon: Icon(Icons.person_pin, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearApellidos(String text) {
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

 

  Widget _crearTelefono(String text) {
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

  Widget _crearCI(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        keyboardType: TextInputType.text,
        enableInteractiveSelection: true,
        maxLength: 10,
        enableSuggestions: true,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: text,
          icon: Icon(Icons.note, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

 Widget _crearExpedido() {
    return Row(
      children: <Widget>[
        DropdownButton(
          value: _opcionSeleccionada,
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

  

  Widget _crearFechaNacimiento(String text) {
    return Padding(
       padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        
        enableInteractiveSelection: false,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: 'Fecha de nacimiento',
            labelText: 'Fecha de nacimiento',
        //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: Icon(Icons.calendar_today, color: Colors.orange)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  Widget _crearSexo(String text) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Masculino'),
          leading: Radio(
            value: 0,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              _setSelectedRadio(value);
            },
          ),
        ),
        ListTile(
          title: Text('Femenino'),
          leading: Radio(
            value: 1,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              _setSelectedRadio(value);
            },
          ),
        ),
      ],
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

  _seleccionarFoto() async =>  _procesarImagen(ImageSource.gallery); 
  _tomarFoto() async =>        _procesarImagen(ImageSource.camera);
  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      hospital.nombre = null;
    }
    setState(() {});
  }

}