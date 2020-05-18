import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class AtentionModule extends StatefulWidget {
    static final String routeName = 'atentionVoluntary';
  @override
  _AtentionModuleState createState() => _AtentionModuleState();
}

class _AtentionModuleState extends State<AtentionModule> {
  InputCheckBox lunes;
  InputCheckBox martes;
  InputCheckBox miercoles;
  InputCheckBox jueves;
  InputCheckBox viernes;
  InputCheckBox sabado;
  InputCheckBox domingo;

  bool selectLunes = false;
  bool selectMartes = false;
  bool selectMiercoles = false;
  bool selectJueves = false;
  bool selectViernes = false;
  bool selectSabado = false;
  bool selectDomingo = false;

  int intLunes = 0;
  int intMartes = 0;
  int intMiercoles = 0;
  int intJueves = 0;
  int intViernes = 0;
  int intaSabado = 0;
  int intDomingo = 0;

  bool _save = false;
  var result;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
    final prefs = new PreferensUser();
Atencion entity = new Atencion();

  @override
  void initState() {
      prefs.ultimaPagina = AtentionModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Atencion entityData =
        ModalRoute.of(context).settings.arguments;

    if (entityData != null) entity = entityData;

    return Scaffold(
        key: scaffoldKey,
       
        drawer: DrawerCitizen(),
        body: Stack(
          children: <Widget>[
            _crearForm(context),
          ],
        ),
     );
  }

 
   Widget informacionProfesional(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width -20 ,
       
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(243, 124, 18, 1.0),
        Color.fromRGBO(255, 209, 18, 3.0),
        Color.fromRGBO(243, 156, 18, 1.0),
        Color.fromRGBO(243, 223, 18, 1.0)
      ])),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                imagenProfesional(),
                RichText(
                  text: TextSpan(
                    text: 'Voluntario(a) : Corina Balderrama.', // 'Dr Dan MlayahFX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                     // fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n' + 'Especialidad: Psicologa',
                        style: TextStyle(
                          color: Colors.black,
                        //  fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '\n' + 'Grupo: Dejame Ayudarte',
                        style: TextStyle(
                          color: Colors.black,
                         // fontWeight: FontWeight.w400,
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
            Divider(height: 35,),
           
            Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 20,),
            Text(
              '1. Seleccionar los días de atención',
              style: TextStyle(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 15.0),
            FaIcon(
              FontAwesomeIcons.calendarCheck,
              color: Colors.blue,
              size: 15,
            ),
          ],
        ),
        
         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 25,),
            Text(
              '2. Definir si la atención se realiza fin de semana.',
              style: TextStyle(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 15.0),
            FaIcon(
              FontAwesomeIcons.calendarCheck,
              color: Colors.blue,
              size: 15,
            ),
          ],
        ),
      //  SizedBox(width: 15,),
         
         SizedBox(height: 20.0),
         Divider(thickness: 1.0, color: Colors.orange, endIndent: 60.0, indent: 60.0),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCamposRRSS() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
         
        ),
        _crearCampos(),
      ],
    );
  }

  Widget _crearCampos() {
    lunes = InputCheckBox('Lun', selectLunes);
    martes = InputCheckBox('Mar', selectMartes);
    miercoles = InputCheckBox('Mie', selectMiercoles);
    jueves = InputCheckBox('Jue', selectJueves);
    viernes = InputCheckBox('Vie', selectViernes);
    sabado = InputCheckBox('Sab', selectSabado);
    domingo = InputCheckBox('Dom', selectDomingo);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'HORARIOS DE ATENCION',
              style: TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 15.0),
            FaIcon(
              FontAwesomeIcons.calendarCheck,
              color: Colors.blue,
              size: 25,
            ),
          ],
        ),
        Divider(thickness: 2.0, color: Colors.orange),
        Row(
          children: <Widget>[
            Expanded(
              child: lunes,
            ),
            Expanded(
              child: martes,
            ),
            Expanded(
              child: miercoles,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: jueves,
            ),
            Expanded(
              child: viernes,
            ),
            Expanded(
              child: sabado,
            ),
          ],
        ),
        domingo,
        _crearBoton(resource.save),
      ],
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
        icon: FaIcon(FontAwesomeIcons.edit, color: Colors.white, ),
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

    if (lunes.objectValue == true) {
      intLunes = 1;
      selectLunes = true;
    }
    if (martes.objectValue == true) {
      intMartes = 1;
      selectMartes = true;
    }
    if (miercoles.objectValue == true) {
      intMiercoles = 1;
      selectMiercoles = true;
    }
    if (jueves.objectValue == true) {
      intJueves = 1;
      selectJueves = true;
    }
    if (viernes.objectValue == true) {
      intViernes = 1;
      selectViernes = true;
    }
    if (sabado.objectValue == true) {
      intaSabado = 1;
      selectSabado = true;
    }
    if (domingo.objectValue == true) {
      intDomingo = 1;
      selectDomingo = true;
    }

    entity.idInstitucion = int.parse(prefs.idInsitucion);
    entity.idInstitucionPersonal = int.parse(prefs.idPersonal);
    entity.perLunes = intLunes;
    entity.perMartes = intMartes;
    entity.perMiercoles = intMiercoles;
    entity.perJueves = intJueves;
    entity.perViernes = intViernes;
    entity.perSabado = intaSabado;
    entity.perDomingo = intDomingo;
    entity.perLunesH = '-1';
    entity.perMartesH = '-1';
    entity.perMiercolesH = '-1';
    entity.perJuevesH = '-1';
    entity.perViernesH = '-1';
    entity.perSabadoH = '-1';
    entity.perDomingoH = '-1';
    entity.usuario = prefs.userId;

    final dataMap = generic.add(entity, urlAddAtencion);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result  y el idinstitucion');

    if (result == "0") {
   
           scaffoldKey.currentState.showSnackBar(messageOk("Se insertó correctamente"));
    }
    
    else
           scaffoldKey.currentState.showSnackBar(messageNOk("Error, vuelta a intentarlo"));

    setState(() {
      _save = false;
    });

    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
  }
}
