import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';

class AtentionEntityModule extends StatefulWidget {
  AtentionEntityModule({Key key}) : super(key: key);

  @override
  _AtentionEntityModuleState createState() => _AtentionEntityModuleState();
}

class _AtentionEntityModuleState extends State<AtentionEntityModule> {
 bool _save = false;
  
   InputCheckBox lunes;
  InputCheckBox martes;
  InputCheckBox miercoles;
  InputCheckBox jueves;
  InputCheckBox viernes;
  InputCheckBox sabado;
  InputCheckBox domingo;

     InputTextField lunesH;
  InputTextField martesH;
  InputTextField miercolesH;
  InputTextField juevesH;
  InputTextField viernesH;
  InputTextField sabadoH;
  InputTextField domingoH;
  
  int _currentIndex;

TimeOfDay _time;
 TextEditingController _inputFieldTimeController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Hospital hospital = new Hospital();

  @override
  void initState() {
    _currentIndex = 0;
    _time = new TimeOfDay.now();
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
      title: Text('DÍAS Y HORAS DE ATENCIÓN'),
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
                    text: 'Institución: Dejame Apoyarte.', // 'Dr Dan MlayahFX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n' + 'Grupo: Dejame de voluntarios',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '\n' + 'Objetivo: Apoyo a la gente',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '\n' + 'Correo: dejame_apoyarte@gmail.com',
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

 _selectTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
           child: child,
    );
  },
   //   locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _time = picked;
        _inputFieldTimeController.text = _time.toString();
      });
    }
  }



  Widget _crearCampos() {
        lunes= InputCheckBox('Lun');
martes= InputCheckBox('Mar');
miercoles= InputCheckBox('Mie');
jueves= InputCheckBox('Jue');
viernes= InputCheckBox('Vie');
sabado= InputCheckBox('Sab');
domingo= InputCheckBox('Dom');

        lunesH= InputTextField(Icon(Icons.watch_later), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
martesH= InputTextField(Icon(Icons.watch_later), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
miercolesH= InputTextField(Icon(Icons.watch_later), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
juevesH= InputTextField(Icon(Icons.watch_later), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
viernesH= InputTextField(Icon(Icons.watch_later), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
sabadoH= InputTextField(Icon(Icons.watch_later), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
domingoH= InputTextField(Icon(Icons.watch_later), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');

    return Column(
      children: <Widget>[
        Text(
          'DIAS Y HORARIOS DE ATENCIÓN',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: lunes,
              
            ),

             Expanded(
              child: lunesH,
              
            ),
         
          //  _crearTime(),
          ],
        ),

         Row(
          children: <Widget>[
            Expanded(
              child: martes,
            ),
             Expanded(
              child: martesH,
              
            ),
            
          ],
        ),

         Row(
          children: <Widget>[
            Expanded(
              child: miercoles,
            ),
             Expanded(
              child: miercolesH,
              
            ),
            
          ],
        ),
         Row(
          children: <Widget>[
            Expanded(
              child: jueves,
            ),
             Expanded(
              child: juevesH,
              
            ),
            
          ],
        ),
         Row(
          children: <Widget>[
            Expanded(
              child: viernes,
            ),
             Expanded(
              child: viernesH,
              
            ),
            
          ],
        ),
         Row(
          children: <Widget>[
            Expanded(
              child: sabado,
            ),
             Expanded(
              child: sabadoH,
              
            ),
            
          ],
        ),
         Row(
          children: <Widget>[
            Expanded(
              child: domingo,
            ),
             Expanded(
              child: domingoH,
              
            ),
            
          ],
        ),
        
        _crearBoton(resource.save),
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
        ]
      );
  }



  // _crearContenedorCamposRRSS() {
  //   return BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(35.0),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Colors.black26,
  //             blurRadius: 7.0,
  //             offset: Offset(0.0, 5.0),
  //             spreadRadius: 7.0)
  //       ]
  //     );
  // }
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

  // Widget _crearBotonRRSS(String text) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 100.0),
  //     width: MediaQuery.of(context).size.width,
  //     child: RaisedButton.icon(
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  //       color: Colors.blue,
  //       textColor: Colors.white,
  //       label: Text(text),
  //       icon: Icon(Icons.save),
  //       onPressed: (_save) ? null : _submit,
  //     ),
  //   );
  // }

  // _submit2() async {
  //   if (!formKey.currentState.validate()) return;

  //   formKey.currentState.save();
  //   setState(() {
  //     _save = true;
  //   });

  //   if (hospital.nombre == null) {
  //     // generic.add(citizen);
  //     print("INSERTOOOO");
  //   } else {
  //     //  generic.update(citizen);
  //     print("MODIFICO");
  //   }

  //   setState(() {
  //     _save = false;
  //   });

  //   //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
  // }

}
