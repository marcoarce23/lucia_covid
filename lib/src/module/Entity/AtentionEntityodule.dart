import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

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

   bool selectLunes =false;
  bool selectMartes=false;
  bool selectMiercoles=false;
  bool selectJueves=false;
  bool selectViernes=false;
  bool selectSabado=false;
  bool selectDomingo=false;

  int intLunes =0;
  int intMartes=0;
  int intMiercoles=0;
  int intJueves=0;
  int intViernes=0;
  int intSabado=0;
  int intDomingo=0;

  var result;
  
  int _currentIndex;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  InstitucionAtencion entity = new InstitucionAtencion();

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final InstitucionAtencion entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) entity = entityData;

    return Scaffold(
        key: scaffoldKey,
        appBar: _appBar(),
        body: Stack(
          children: <Widget>[
            _crearForm(context),
          ],
        ),
        drawer: DrawerCitizen(),
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


  Widget _crearCampos() {
        lunes= InputCheckBox('Lun', selectLunes);
martes= InputCheckBox('Mar',selectMartes);
miercoles= InputCheckBox('Mie',selectMiercoles);
jueves= InputCheckBox('Jue',selectJueves);
viernes= InputCheckBox('Vie',selectViernes);
sabado= InputCheckBox('Sab',selectSabado);
domingo= InputCheckBox('Dom',selectDomingo);

  lunesH= InputTextField(FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
  martesH= InputTextField(FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
  miercolesH= InputTextField(FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
  juevesH= InputTextField(FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
  viernesH= InputTextField(FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
  sabadoH= InputTextField(FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');
  domingoH= InputTextField(FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ), 'Horarios de atención', '', 'Ej: 08:00  a 13:30');

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

    if (lunes.objectValue == true) { intLunes =1; selectLunes = true;}
if (martes.objectValue == true)  {  intMartes =1;selectMartes = true;}
if (miercoles.objectValue == true)  {  intMiercoles =1;selectMiercoles = true;}
if (jueves.objectValue == true)  {  intJueves =1;selectJueves = true;}
if (viernes.objectValue == true)  {  intViernes =1;selectViernes = true;}
if (sabado.objectValue == true)  {  intSabado =1;selectSabado = true;}
if (domingo.objectValue == true)  {  intDomingo =1;selectDomingo = true;}

    entity.idInstitucionPersonal = 123456;
    entity.idInstitucion = 0;
    entity.perLunes= intLunes;
    entity.perMartes = intMartes;
    entity.perMiercoles = intMiercoles;
    entity.perJueves = intJueves;
    entity.perViernes = intViernes;
    entity.perSabado = intSabado;
    entity.perDomingo = intDomingo;
   entity.perLunesH = lunesH.objectValue;
    entity.perMartesH = martesH.objectValue;
    entity.perMiercolesH = miercolesH.objectValue;
    entity.perJuevesH = juevesH.objectValue;
    entity.perViernesH = viernesH.objectValue;
    entity.perSabadoH = sabadoH.objectValue;
    entity.perDomingoH = domingoH.objectValue;
     entity.usuario = 'marcoarce23@gmail.com';

final dataMap = generic.add(entity, urlAddInstitucion);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');


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
