import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenReference/CitizenReferenceModule.dart';

import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/module/Voluntary/VoluntaryModule.dart';

class CitizenFamilyModule extends StatefulWidget {
  

  @override
  _CitizenFamilyModuleState createState() => _CitizenFamilyModuleState();
}

class _CitizenFamilyModuleState extends State<CitizenFamilyModule> {

  bool _save = false;
  int _currentIndex;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Hospital hospital = new Hospital();

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  _callPage(int currentIdex) {
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => VoluntaryModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => CitizenReferenceModule()));
    if (currentIdex == 2)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => CitizenFamilyModule()));
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
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  AppBar _appBar() {
      return AppBar(
          title: Text('Cantidad de Familiares'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
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
            _callPage(_currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Ciudadano')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Referencias')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 25.0),
              title: Text('Familiares')),
        ],
      ),
    );
  }

  Widget _crearCampos() {
    return Column(
      children: <Widget>[

          Row( children: <Widget>[
                  Expanded( child: _crearBebes(), ),
                  Expanded( child: _crearNinos(), ),
                ],
          ),
        
        Row( children: <Widget>[
                  Expanded( child: _crearAdolescentes(), ),
                  Expanded( child: _crearAdultos(), ),
                ],
          ),

          Row( children: <Widget>[
                  Expanded( child: _crearAdultosMayores(), ),
                  Expanded( child: _crearMascotas(), ),
                ],
          ),
          _crearObservaciones(), 
        _crearBoton(resource.save),
      ],
    );
  }


 Widget _crearBebes() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: TextFormField(
      
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          labelText: 'Bebes',
          hintText: 'Cantidad',
          icon: Icon(Icons.child_care, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

Widget _crearNinos() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: TextFormField(
      
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          labelText: 'Niños',
          hintText: 'Cantidad',
          icon: Icon(Icons.child_care, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

Widget _crearAdolescentes() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: TextFormField(
      
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          labelText: 'Adolescentes',
          hintText: 'Cantidad',
          icon: Icon(Icons.child_care, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }
  Widget _crearAdultos() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: TextFormField(
      
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          labelText: 'Adultos',
          hintText: 'Cantidad',
          icon: Icon(Icons.child_care, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

Widget _crearAdultosMayores() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: TextFormField(
      
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          labelText: 'Adultos Mayores',
          hintText: 'Cantidad',
          icon: Icon(Icons.child_care, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

Widget _crearMascotas() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: TextFormField(
      
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          labelText: 'Mascotas',
          hintText: 'Cantidad',
          icon: Icon(Icons.child_care, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

Widget _crearObservaciones() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: TextFormField(
      
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          labelText: 'Observaciones',
          hintText: 'Registre las Observaciones',
          icon: Icon(Icons.child_care, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
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
                    text: 'Marco ANtonio Arce Valdivia .', // 'Dr Dan MlayahFX',
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