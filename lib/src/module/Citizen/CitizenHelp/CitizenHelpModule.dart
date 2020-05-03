import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';

class CitizenHelpModule extends StatefulWidget {


  @override
  _CitizenHelpModuleState createState() => _CitizenHelpModuleState();
}

class _CitizenHelpModuleState extends State<CitizenHelpModule> {
   InputTextField nombre;
   InputPhoneField telefono;
  InputMultilineField ubicacion;

 bool _save = false;
  File foto;
 int _currentIndex =0; 
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
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('AYUDA A UN AMIG@'),
      backgroundColor: Colors.orange,
    
    );
  }

    Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Colors.blueGrey))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
             _currentIndex = value;
            callHelp(_currentIndex, context);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Colabora')),
        
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Listado solicitudes')),
         ],
      ),
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

    nombre =   InputTextField(Icon(Icons.business), 'Persona a poyar', '', '');
    telefono =  InputPhoneField(Icon(Icons.business), 'Telefono de referencia', '', '');
    ubicacion =  InputMultilineField(Icon(Icons.business), 'Donde la encuentro', '', '');
    return Column(
      children: <Widget>[
          Text('AYUDA A UN AMIG@', style: TextStyle(fontSize: 18, color: Colors.black),),
        nombre,
        telefono,
        ubicacion,
        _crearTipoApoyo(),
        _crearTipoPrioridad(),
        _crearBoton(resource.save),
      ],
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
