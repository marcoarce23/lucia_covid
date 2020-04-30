import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;

class AtentionModule extends StatefulWidget {
  @override
  _AtentionModuleState createState() => _AtentionModuleState();
}

class _AtentionModuleState extends State<AtentionModule> {
  bool _save = false;
  bool _lun = false;
  bool _mar = false;
  bool _mie = false;
  bool _jue = false;
  bool _vie = false;
  bool _sab = false;
  bool _dom = false;
  
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
      title: Text('INFORMACION COMPLEMENTARIA'),
      backgroundColor: Colors.orange,
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
            callPage(_currentIndex, context);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Voluntarios')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Atención-RRSS')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 25.0),
              title: Text('Eventos')),
        ],
      ),
    );
  }

// Widget widget() {
//   return new TimePickerSpinner(
//     is24HourMode: false,
//     normalTextStyle: TextStyle(
//       fontSize: 24,
//       color: Colors.deepOrange
//     ),
//     highlightedTextStyle: TextStyle(
//       fontSize: 24,
//       color: Colors.yellow
//     ),
//     spacing: 50,
//     itemHeight: 80,
//     isForce2Digits: true,
//     onTimeChange: (time) {
//       setState(() {
//         _dateTime = time;
//       });
//     },
//   );
// }

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
                        text: '\n' + 'Especialidad: Psicologa',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '\n' + 'Grupo: Dejame Ayudarte',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '\n' + 'Correo: corina_123@gmail.com',
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
              width: size.width * 0.94,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: _crearContenedorCamposRRSS(),
              child: _crearCamposRRSS(),
            ),

            crearLucia(),
          ],
        ),
      ),
    );
  }


  Widget _crearCamposRRSS() {
    return Column(
      children: <Widget>[
        Text(
          'REDES SOCIALES',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        _crearTitulo('Facebook'),
_crearTitulo('Twitter'),
_crearTitulo('Instagram'),
_crearTitulo('YouTube'),
_crearTitulo('Página Web'),
Padding(
  padding: const EdgeInsets.all(12.0),
  child:   Divider(thickness: 2.0, color: Colors.orange),
),
_crearCampos(),
      ],
    );
  }
  Widget _crearCampos() {
    return Column(
      children: <Widget>[
        Text(
          'HORARIOS DE ATENCIÓN',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _crearLu(),
            ),
            Expanded(
              child: _crearMa(),
            ),
            Expanded(
              child: _crearMi(),
            ),
           
          ],
        ),
        Row(
          children: <Widget>[
             Expanded(
              child: _crearJu(),
            ),
            Expanded(
              child: _crearVi(),
            ),
            Expanded(
              child: _crearSa(),
            ),
          
          ],
        ),
        _crearBoton(resource.save),
      ],
    );
  }

  Widget _crearLu() {
    return CheckboxListTile(
        title: new Text('Lun.'), 
        value: _lun, 
        onChanged: (value) {
          setState(() {
             _lun = value;
          });
        }
    );
  }

 Widget _crearMa() {
    return CheckboxListTile(
        title: new Text('Mar.'), 
        value: _mar, 
        onChanged: (value) {
          setState(() {
             _mar = value;
          });
        }
    );
  }
   Widget _crearMi() {
    return CheckboxListTile(
        title: new Text('Mie.'), 
        value: _mie, 
        onChanged: (value) {
          setState(() {
             _mie = value;
          });
        }
    );
  }
   Widget _crearJu() {
    return CheckboxListTile(
        title: new Text('Jue.'), 
        value: _jue, 
        onChanged: (value) {
          setState(() {
             _jue = value;
          });
        }
    );
  }
   Widget _crearVi() {
    return CheckboxListTile(
        title: new Text('Vie.'), 
        value: _vie, 
        onChanged: (value) {
          setState(() {
             _vie = value;
          });
        }
    );
  }
   Widget _crearSa() {
    return CheckboxListTile(
        title: new Text('Sab.'), 
        value: _sab, 
        onChanged: (value) {
          setState(() {
             _sab = value;
          });
        }
    );
  }
   Widget _crearDo() {
    return CheckboxListTile(
        title: new Text('Dom.'), 
        value: _dom, 
        onChanged: (value) {
          setState(() {
             _dom = value;
          });
        }
    );
  }
  Widget _crearTitulo(String text) {
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
          icon: Icon(Icons.add_box, color: Colors.orange),
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
        ]
      );
  }



  _crearContenedorCamposRRSS() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(0.0, 5.0),
              spreadRadius: 7.0)
        ]
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

  Widget _crearBotonRRSS(String text) {
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

  _submit2() async {
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
