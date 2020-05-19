import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Util/SearchDelegate/DataSearch.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/AtentionEntityodule.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/ListEntityModule.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Map/MapAdressModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class EntityAllModule extends StatefulWidget {
  static final String routeName = 'entidad';
  const EntityAllModule({Key key}) : super(key: key);

  @override
  _EntityAllModuleState createState() => _EntityAllModuleState();
}

class _EntityAllModuleState extends State<EntityAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;
  final List<Widget> optionPage = [
    EntityModule(),
    AtentionEntityModule(),
    ListEntityModule()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = EntityAllModule.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.themeColorAzul,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
        elevation: 0,
        title: Text(
          "ENTIDADES-INSTITUCIONES",
          style: TextStyle(
              color: AppTheme.themeColorNaranja,
              fontSize: 17,
              fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearchVoluntary());
            },
          )
        ],
      ),
      drawer: DrawerCitizen(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.userCircle,
                size: 25,
              ),
              title: Text('Institucion')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendarCheck,
                size: 25,
              ),
              title: Text('Atención')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.users,
                size: 25,
              ),
              title: Text('Listado')),
        ],
        currentIndex: page,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
    );
  }
}

class EntityModule extends StatefulWidget {
  static final String routeName = 'entidad';
  EntityModule({Key key}) : super(key: key);

  @override
  _EntityModuleState createState() => _EntityModuleState();
}

class _EntityModuleState extends State<EntityModule> {
  InputDropDown tipoInstitucion;
  InputDropDown ubicacion;
  InputTextField nombre;
  InputTextField token;
  InputTextField direccion;
  InputPhoneField telefono;
  InputTextField informacion;
  InputTextField facebook;
  InputTextField twitter;
  InputUrlField paginaWeb;
  InputTextField youtube;
  InputEmailField email;

  bool _save = false;
  File foto;
  double latitud = 0.0;
  double longitud = 0.0;
  LatLng latLng = LatLng(0, 0);

  String imagen =
      'https://definicionyque.es/wp-content/uploads/2017/11/Medicina_Preventiva.jpg';
  var result;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  Institucion entity = new Institucion();

  @override
  void initState() {
    prefs.ultimaPagina = EntityModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Institucion entityData = ModalRoute.of(context).settings.arguments;

    if (entityData != null) entity = entityData;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          crearFondoForm(context, imagen),
          _crearForm(context),
        ],
      ),
    );
  }

  Widget _crearForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      _crearIconAppImagenes(),
                      _crearIconAppCamara(),
                      _crearIconAppMap(),
                    ]),
              ],
            ),
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
    tipoInstitucion = InputDropDown(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Tipo institución:',
        '3',
        urlGetClasificador + '2');
    ubicacion = InputDropDown(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Departamento/ciudad:',
        '60',
        urlGetClasificador + '53');
    nombre = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'Nombre de la institución:',
        entity.nombreInstitucion,
        '');
    token = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'INgrese el token:',
        entity.token,
        'Ej:546AMDEr');
    direccion = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'Dirección/ubicacion:',
        entity.direccion,
        '');
    telefono = InputPhoneField(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Telefono de referencia',
        entity.telefono,
        '');
    informacion = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'Información complementaria:',
        entity.perInformacionComp,
        '');
    facebook = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'Cuenta Facebook:',
        entity.perFacebbok,
        '');
    twitter = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'Cuenta Twitter:',
        entity.perTwitter,
        '');
    paginaWeb = InputUrlField(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Pagina Web/block:',
        entity.perPaginaWeb,
        '');
    youtube = InputTextField(
        FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
        'Cuenta YouTube:',
        entity.perYouTube,
        '');
    email = InputEmailField(
        FaIcon(FontAwesomeIcons.userMd, color: Colors.orange),
        'Correo Electronico:',
        entity.perCorreoElectronico,
        '',
        'Ingrese su correo electronico');

    return Column(
      children: <Widget>[
        Text(
          'INFORMACION GENERAL',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        tipoInstitucion,
        ubicacion,
        token,
        nombre,
        direccion,
        telefono,
        informacion,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Divider(
            color: Colors.orange,
            thickness: 2.0,
          ),
        ),
        Text(
          'REDES SOCIALES',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        facebook,
        twitter,
        paginaWeb,
        youtube,
        email,
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
        ]);
  }

  _crearIconAppImagenes() {
    return IconButton(
      icon: Icon(Icons.photo_size_select_actual, color: Colors.blueGrey,),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppMap() {
    return IconButton(
        icon: Icon(Icons.photo_size_select_actual, color: Colors.blueGrey,),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapAdressModule()),
            ));
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: Icon(Icons.camera_alt, color: Colors.blueGrey,),
      onPressed: _tomarFoto,
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
    latLng = await getLocation().then((onvalue) => latLng = onvalue);
    entity.foto = imagen;

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    entity.idInstitucion = 0;
    entity.insLat = latLng.latitude;
    entity.insLng = latLng.longitude;
    entity.tipoInstitucion = int.parse(tipoInstitucion.objectValue);
    entity.token = token.objectValue;
    entity.nombreInstitucion = nombre.objectValue;
    entity.ubicacion = int.parse(ubicacion.objectValue);
    entity.direccion = direccion.objectValue;
    entity.telefono = telefono.objectValue;
    entity.perInformacionComp = informacion.objectValue;
    entity.perFacebbok = facebook.objectValue;
    entity.perTwitter = twitter.objectValue;
    entity.perPaginaWeb = paginaWeb.objectValue;
    entity.perYouTube = youtube.objectValue;
    entity.perCorreoElectronico = email.objectValue;
    entity.usuario = prefs.nombreUsuario;

    final dataMap = generic.add(entity, urlAddInstitucion);
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');

    if (result == "0") {
      // scaffoldKey.currentState
      //     .showSnackBar(messageOk("Se insertó correctamente"));
          Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => ListEntityModule()));
    }
    if (result == "-1") {
      scaffoldKey.currentState
          .showSnackBar(messageNOk('Error, vuelta a intentarlo'));
    }
    if (result == "-2") {
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, El TOKEN esta siendo utilizado"));
    }

    setState(() {
      _save = false;
    });
  }

  _seleccionarFoto() async => _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => _procesarImagen(ImageSource.camera);
  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      imagen = await generic.subirImagen(foto);
      entity.foto = imagen;
      print('cargadod e iagen ${entity.foto}');
    }
  }
}