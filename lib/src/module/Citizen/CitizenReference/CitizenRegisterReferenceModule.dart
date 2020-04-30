
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;

class CitizenRegisterReferenceModule extends StatefulWidget {
  CitizenRegisterReferenceModule({Key key}) : super(key: key);

  @override
  _CitizenRegisterReferenceModuleState createState() => _CitizenRegisterReferenceModuleState();
}

class _CitizenRegisterReferenceModuleState extends State<CitizenRegisterReferenceModule> {
 
  bool _save = false;
  String _opcionSeleccionada = '';
  String _opcionTipoReferencia ;
  List<String> _expedido = ['CHQ','LPZ','CBB','ORU', 'PTS','TRJ', 'SCZ','BNI', 'PND' ];
  List<String> _tipoReferencia = ['familiar','tutor','hemano'];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Hospital hospital = new Hospital();

  @override
  void initState() {
    _opcionSeleccionada = 'LPZ';
    _opcionTipoReferencia = 'tutor';
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

List<DropdownMenuItem<String>> getTipoReferenciaDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoReferencia.forEach((tipoReferencia) {
      lista.add(DropdownMenuItem(
        child: Text(tipoReferencia),
        value: tipoReferencia,
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
      );
   }

  AppBar _appBar() {
      return AppBar(
          title: Text('Registro Referencias - Sospechoso'),
          backgroundColor: Colors.orange,
          
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
        _crearNombre('Nombre completo:'),
        
        Row( children: <Widget>[
            Expanded(
              child: _crearCI('Documento de Identidad'),),
             _crearExpedido(),
          ],
        ),
        _crearTelefono('Telefono'),
        _crearEmail('Correo ELectrónico'),
        _crearTipoReferencia() ,
         _crearObservacion('Observacion'),
        _crearBoton(resource.save),
        // _forgetPassword(),
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

Widget _crearTipoReferencia() {
    return Row(
      children: <Widget>[
        SizedBox(width: 25.0),
           Icon(Icons.select_all),
          SizedBox(width: 25.0),
              Expanded(
             child: DropdownButton(
               isExpanded: true,
              // style: TextStyle(fontSize: 20, color: Colors.black),
            value: _opcionTipoReferencia,
          items: getTipoReferenciaDropdown(),
          onChanged: (opt) {
              setState(() {
                _opcionTipoReferencia = opt;
              });
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
}