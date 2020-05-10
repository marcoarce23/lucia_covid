import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class VoluntaryModule extends StatefulWidget {
  const VoluntaryModule({Key key}) : super(key: key);

  @override
  _VoluntaryModuleState createState() => _VoluntaryModuleState();
}

class _VoluntaryModuleState extends State<VoluntaryModule> {
  InputDropDown tipoEntidad;
  InputDropDown tipoEspecialidad;
  InputTextField nombre;
  InputEmailField email;
  InputPhoneField telefono;
  InputTextField ci;
  InputTextField complmementario;
  InputTextField facebook;
  InputTextField twitter;
  InputUrlField paginaWeb;
  InputDropDown expedido;
  InputSexo sexo;

  bool _save = false;
  bool esCovid = false;
  File foto;
  var result;

  int _currentIndex;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Voluntary entity = new Voluntary();

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
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
              icon: FaIcon(FontAwesomeIcons.userCircle, size: 25,),
              title: Text('Voluntario')),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendarCheck,size: 25, ),
              title: Text('Atención')),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.users, size: 25, ),
              title: Text('Integrantes')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Voluntary entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) entity = entityData;

    return Scaffold(
        key: scaffoldKey,
        appBar: _appBar(),
        body: Stack(
          children: <Widget>[
            crearFondoForm(context),
            _crearForm(context),
          ],
        ),
        drawer: DrawerCitizen(),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('REGISTRO VOLUNTARIO'),
      backgroundColor: Colors.orange,
      actions: <Widget>[_crearIconAppImagenes(), _crearIconAppCamara()],
    );
  }

  _crearIconAppImagenes() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.image, color: Colors.black87),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.cameraRetro, color: Colors.black87),
      onPressed: _tomarFoto,
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
    tipoEntidad = InputDropDown(
        FaIcon(FontAwesomeIcons.building, color: Colors.orange),
        'Institución:',
        '7',
        urlGetClasificador + '2');
    tipoEspecialidad = InputDropDown(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Especialidad:',
        '11',
        urlGetClasificador + '10');
    expedido = InputDropDown(
        FaIcon(FontAwesomeIcons.sortDown, color: Colors.orange),
        'Expedido:',
        '26',
        urlGetClasificador + '23');
    nombre = InputTextField(
        FaIcon(FontAwesomeIcons.userFriends, color: Colors.orange),
        'Nombre voluntario:',
        '',
        '.');
    ci = InputTextField(FaIcon(FontAwesomeIcons.idCard, color: Colors.orange),
        'Documentod e Identidad:', '', '.');
    telefono = InputPhoneField(
        FaIcon(FontAwesomeIcons.mobileAlt, color: Colors.orange),
        'Telefono de referencia',
        '',
        '');
    complmementario = InputTextField(
        FaIcon(FontAwesomeIcons.commentAlt, color: Colors.orange),
        'Información complementaria:',
        '',
        '.');
    email = InputEmailField(
        FaIcon(FontAwesomeIcons.envelopeOpen, color: Colors.orange),
        'Correo Electronico:',
        '',
        '',
        'Ingrese su correo electronico');
    facebook = InputTextField(
        FaIcon(FontAwesomeIcons.facebook, color: Colors.orange),
        'Cuenta Facebook:',
        '',
        '.');
    twitter = InputTextField(
        FaIcon(FontAwesomeIcons.twitter, color: Colors.orange),
        'Cuenta Twitter:',
        '',
        '.');
    paginaWeb = InputUrlField(
        FaIcon(FontAwesomeIcons.internetExplorer, color: Colors.orange),
        'Pagina Web/block:',
        '',
        '.');
    sexo = InputSexo();

    return FadeInLeft(
      duration: Duration(milliseconds: 250),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'INFORMACION GENERAL',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 15.0),
              FaIcon(
                FontAwesomeIcons.addressCard,
                color: Colors.blue,
                size: 25,
              ),
            ],
          ),
          SizedBox(height: 10),
          tipoEntidad,
          tipoEspecialidad,
          _crearEsCovid('Ayuda Covid'),
          nombre,
          telefono,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ci,
              ),
              expedido,
            ],
          ),
          sexo,
          complmementario,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Divider(
              color: Colors.orange,
              thickness: 2.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'REDES SOCIALES',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 15.0),
              FaIcon(
                FontAwesomeIcons.blog,
                color: Colors.blue,
                size: 25,
              ),
            ],
          ),
          email,
          facebook,
          twitter,
          paginaWeb,
          _crearBoton(resource.save),
        ],
      ),
    );
  }

  Widget _crearEsCovid(String text) {
    return SwitchListTile(
      value: esCovid,
      title: Text(text),
      activeColor: Colors.orange,
      onChanged: (value) => setState(() {
        esCovid = value;
      }),
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
        icon: FaIcon(FontAwesomeIcons.edit, color: Colors.white),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }

  _submit() async {

  String fotoUrl;
  
    if ( foto != null ) {
      fotoUrl = await generic.subirImagen(foto);
      print('fotoURL :$fotoUrl');
    }

    // if (!formKey.currentState.validate()) return;

    // formKey.currentState.save();
    // setState(() {
    //   _save = true;
    // });

    // entity.idcovPersonal = 0;
    // entity.idcovInstitucion = int.parse(tipoEntidad.objectValue);
    // entity.idcovLogin = 0;
    // entity.idaTipopersonal = int.parse(tipoEspecialidad.objectValue);
    // entity.perNombrepersonal = nombre.objectValue;
    // entity.perCorreo = email.objectValue;
    // entity.perTelefono = telefono.objectValue;
    // if (esCovid)
    //   entity.perAyudacovid = 1;
    // else
    //   entity.perAyudacovid = 0;
    // entity.perCI = ci.objectValue;
    // entity.idaExtension = int.parse(expedido.objectValue);
    // entity.idaSexo = 0;
    // entity.perInformacionComplementaria = complmementario.objectValue;
    // entity.perFacebbok = facebook.objectValue;
    // entity.perTwitter = twitter.objectValue;
    // entity.perPaginaWeb = paginaWeb.objectValue;
    // entity.usuario = 'marcoarce23@gmail.com';

    // final dataMap = generic.add(entity, urlAddPersonal);

    // await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    // print('resultado:$result');

    // setState(() {
    //   _save = false;
    // });

    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
  }

  _seleccionarFoto() async => _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => _procesarImagen(ImageSource.camera);
  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    setState(() {});
  }
}
