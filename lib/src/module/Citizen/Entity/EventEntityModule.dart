import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class EventEntityModule extends StatefulWidget {
  EventEntityModule({Key key}) : super(key: key);

  @override
  _EventEntityModuleState createState() => _EventEntityModuleState();
}

class _EventEntityModuleState extends State<EventEntityModule> {
  bool _save = false;
  String _fecha = '';
  TimeOfDay _time;
  int _currentIndex;
  var result;
  String imagen =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
  File foto;

  TextEditingController _inputFieldDateController = new TextEditingController();
  TextEditingController _inputFieldTimeController = new TextEditingController();

  InputTextField titulo;
  InputMultilineField objetivo;
  InputMultilineField dirigidoA;
  InputTextField expositor;
  InputMultilineField ubicacion;
  InputTextField fecha;
  InputTextField hora;
  InputTextField fotoa;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  Evento entity = new Evento();

  @override
  void initState() {
    _currentIndex = 0;
    _time = new TimeOfDay.now();
    _fecha = new DateTime.now().toString().substring(0, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Evento entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) entity = entityData;

    return Scaffold(
        key: scaffoldKey,
        appBar: _appBar(),
        body: Stack(
          children: <Widget>[
            crearFondoForm(context, imagen),
            _crearForm(context),
          ],
        ),
        drawer: DrawerCitizen(),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('EVENTOS DEL GRUPO'),
      backgroundColor: Colors.orange,
      actions: <Widget>[_crearIconAppImagenes(), _crearIconAppCamara()],
    );
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
            callPageEventVoluntary(_currentIndex, context);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Eventos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Historial Eventos')),
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
    titulo = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'Titulo del evento:',
        '',
        '');
    objetivo = InputMultilineField(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Objetivo:',
        '',
        '');
    dirigidoA = InputMultilineField(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Dirigido A:',
        '',
        '');
    expositor = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'Expositor:',
        '',
        '');
    ubicacion = InputMultilineField(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Ubicacion:',
        '',
        '');

    return Column(
      children: <Widget>[
        Text(
          'REGISTRO DE EVENTOS XXX',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        titulo,
        objetivo,
        dirigidoA,
        expositor,
        ubicacion,
        _crearFecha('Fecha Evento'),
        _crearTime('hora'),
        _crearBoton(resource.save),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020, 4),
      lastDate: new DateTime(2025, 12),
      // locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateController.text = _fecha;
        print(_inputFieldDateController.text);
      });
    }
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
        _inputFieldTimeController.text = _time.hour.toString() +
            ':' +
            _time.minute
                .toString(); //TimeOfDay(hour: _time.hour, minute: _time.minute).toString();
      });
    }
  }

  Widget _crearFecha(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: 'Fecha del evento',
            labelText: 'Fecha del evento',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: Icon(Icons.calendar_today, color: Colors.orange)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
    );
  }

  Widget _crearTime(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldTimeController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: 'Hora del evento',
            labelText: 'Hora del evento (23:59)',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: Icon(Icons.timer, color: Colors.orange)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectTime(context);
        },
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

    entity.idcovEvento = 0;
    entity.idcovInstitucion = int.parse(prefs.idInsitucion);
    entity.idcovPersonal = -1;
    entity.eveTitulo = titulo.objectValue;
    entity.eveObjetivo = objetivo.objectValue;
    entity.eveDirigidoA = dirigidoA.objectValue;
    entity.eveExpositor = expositor.objectValue;
    entity.eveUbicacion = ubicacion.objectValue;
    entity.eveFecha = _inputFieldDateController.text;
    entity.eveHora = _inputFieldTimeController.text;
    entity.eveFoto = imagen;
    entity.usuario = prefs.nombreUsuario;

    final dataMap = generic.add(entity, urlAddEvento);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');

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
      imagen = await generic.subirImagen(foto);
    }

    setState(() {
      entity.eveFoto = imagen;
      print('cargadod e iagen ${entity.eveFoto}');
    });
  }
}