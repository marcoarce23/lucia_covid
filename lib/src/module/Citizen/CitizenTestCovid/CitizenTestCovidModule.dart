import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenFamilyModule.dart';

import 'package:lucia_covid/src/module/Citizen/CitizenReference/CitizenReferenceModule.dart';

import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/module/Voluntary/VoluntaryModule.dart';

class CitizenTestCovidModule extends StatefulWidget {
  const CitizenTestCovidModule({Key key}) : super(key: key);

  @override
  _CitizenTestCovidModuleState createState() => _CitizenTestCovidModuleState();
}

class _CitizenTestCovidModuleState extends State<CitizenTestCovidModule> {
  bool _save = false;
  int _currentIndex;
  bool _isSelected = false;

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
      title: Text('TEST RAPIDO DE APOYO'),
      backgroundColor: Colors.orange,
      actions: <Widget>[],
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
                    text: 'Lucia de ayuda', // 'Dr Dan MlayahFX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n' + 'Bienvenido al Test Rápido...',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text:
                            '\n' + 'Completa el registro con total sinceridad',
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
                // crearIconoProfesional(Icons.mail, 'Correo'),
                // crearIconoProfesional(Icons.phone, 'Correo'),
                // crearIconoProfesional(Icons.bug_report, 'Ayuda con covid'),
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
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.blueGrey))),
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
              icon: Icon(Icons.person, size: 25.0), title: Text('Coronavirus')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Resfrio')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 25.0),
              title: Text('Fiebre')),
        ],
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

  Widget _crearCampos() {
    return Column(
      children: <Widget>[
        Text(
          'TEST COVID',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        _checkBoxFiebre(),
        _checkBoxTos(),
        _checkBoxGarganta(),
        _checkBoxRespirar(),
        _checkBoxFlema(),
        _checkBoxCansancio(),
        _checkBoxCabeza(),
        _checkBoxPulmon(),
        _crearBoton(resource.save),
      ],
    );
  }

  Widget _checkBoxFiebre() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(width: 80.0),
                Text('Fiebre'),
              ],
            ),
            SizedBox(width: 60.0),
            Column(
              children: <Widget>[
                Checkbox(
                  value: _isSelected,
                  onChanged: (valor) {
                    setState(() {
                      _isSelected = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
 Widget _checkBoxTos() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
             
              children: <Widget>[
                 SizedBox(width: 60.0),
                Text('Tos'),
              ],
            ),
             SizedBox(width: 80.0),
            Column(
              children: <Widget>[
                Checkbox(
                  value: _isSelected,
                  onChanged: (valor) {
                    setState(() {
                      _isSelected = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
 Widget _checkBoxGarganta() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                 SizedBox(width: 10.0),
                Text('Dolor de Garganta'),
              ],
            ),
             SizedBox(width: 30.0),
            Column(
              children: <Widget>[
                Checkbox(
                  value: _isSelected,
                  onChanged: (valor) {
                    setState(() {
                      _isSelected = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
 Widget _checkBoxRespirar() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Dificultad para respirar'),
              ],
            ),
            Column(
              children: <Widget>[
                Checkbox(
                  value: _isSelected,
                  onChanged: (valor) {
                    setState(() {
                      _isSelected = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
 Widget _checkBoxFlema() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                 SizedBox(width: 80.0),
                Text('Flema'),
              ],
            ),
             SizedBox(width: 60.0),
            Column(
              children: <Widget>[
                Checkbox(
                  value: _isSelected,
                  onChanged: (valor) {
                    setState(() {
                      _isSelected = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
 Widget _checkBoxCansancio() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Cansancio - Debilidad'),
              ],
            ),
             SizedBox(width: 5.0),
            Column(
              children: <Widget>[
                Checkbox(
                  value: _isSelected,
                  onChanged: (valor) {
                    setState(() {
                      _isSelected = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
 Widget _checkBoxCabeza() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Dolor de cabeza'),
              ],
            ),
             SizedBox(width: 40.0),
            Column(
              children: <Widget>[
                Checkbox(
                  value: _isSelected,
                  onChanged: (valor) {
                    setState(() {
                      _isSelected = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
 Widget _checkBoxPulmon() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('X-ray pulmón mancha'),
              ],
            ),
            Column(
              children: <Widget>[
                Checkbox(
                  value: _isSelected,
                  onChanged: (valor) {
                    setState(() {
                      _isSelected = valor;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
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
        label: Text('Concluir Test'),
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
