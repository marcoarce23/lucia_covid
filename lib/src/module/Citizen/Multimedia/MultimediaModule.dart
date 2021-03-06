import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Util/SearchDelegate/DataSearch.dart';
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Citizen/Multimedia/ListMultimediaModule.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';
import 'package:file_picker/file_picker.dart';

class MultimediaAllModule extends StatefulWidget {
  static final String routeName = 'voluntario';
  const MultimediaAllModule({Key key}) : super(key: key);

  @override
  _MultimediaAllModuleState createState() => _MultimediaAllModuleState();
}

class _MultimediaAllModuleState extends State<MultimediaAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;
  final List<Widget> optionPage = [MultimediaModule(), ListMultimediaModule()];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = MultimediaAllModule.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(



        
        backgroundColor: Colors.white,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeVino, size: 12),
        elevation: 0,
        title: Text( "MATERIAL MULTIMEDIA",  style: kTitleAppBar),
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
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.userCircle,
                size: 25,
              ),
              title: Text('Multimedia')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendarCheck,
                size: 25,
              ),
              title: Text('Publicaciones')),
        ],
        currentIndex: page,
       unselectedItemColor: Colors.black54,
        selectedItemColor: AppTheme.themeVino,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
    );
  }
}
class MultimediaModule extends StatefulWidget {
  static final String routeName = 'multimedia';
  MultimediaModule({Key key}) : super(key: key);
//
  @override
  _MultimediaModuleState createState() => _MultimediaModuleState();
}

class _MultimediaModuleState extends State<MultimediaModule> {
  InputTextField titulo;
  InputTextField resumen;
  InputTextField detalle;
  InputDropDown especialidad;
  InputDropDown tipoMaterial;

  bool _save = false;
  String _fecha = '';
  File foto;
  var result;
  String imagen =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
  String imagenDefault =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
  TextEditingController _inputFieldDateInicioController =
      new TextEditingController();
  TextEditingController _inputFieldDateFinController =
      new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();

  Multimedia entity = new Multimedia();

  String _pdfPath = '';

  @override
  void initState() {
    prefs.ultimaPagina = MultimediaModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Multimedia entityData = ModalRoute.of(context).settings.arguments;
  
    if (entityData != null) entity = entityData;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          crearFondo(context, imagen),
          _crearForm(context),
        ],
      ),
    );
  }

  _crearIconAppImagenes() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.images, color:  AppTheme.themeVino,),
      onPressed: _seleccionarFoto,
    );
  }

  _crearIconAppCamara() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.cameraRetro,  color: AppTheme.themeVino,),
      onPressed: _tomarFoto,
    );
  }

  _crearIconAppVideo() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.videoSlash,  color: AppTheme.themeVino,),
      onPressed: _pickVideo,
    );
  }
  _crearIconAppPDF() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.solidFilePdf, color: AppTheme.themeVino,),
      onPressed: _pickPDF,
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
              children: <Widget>[],
            ),
            SafeArea(
              child: Container(
                height: 125.0,
              ),
            ),
            Container(
              width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCarretes(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('CARGAR MATERIAL',
                      style: TextStyle(
                        color: AppTheme.themeVino,
                        fontSize: 16.0,
                      )),
                  _crearIconAppImagenes(),
                  _crearIconAppCamara(),
                  _crearIconAppVideo(),
                  _crearIconAppPDF() ,
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCampos(),
              child: _crearCampos(),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    titulo = InputTextField(
        FaIcon(FontAwesomeIcons.chalkboardTeacher, color: AppTheme.themeVino),
        'Nombre del material',
        entity.mulTitulo,
        'Ingrese el nombre del material',
        true);
    resumen = InputTextField(
          FaIcon(FontAwesomeIcons.clipboardList, color: AppTheme.themeVino),
        'Resumen sobre material',
        entity.mulResumen,
        'Registre resumen sobre el matarial',
        true);

    especialidad = InputDropDown(
        FaIcon(FontAwesomeIcons.userMd, color: AppTheme.themeVino),
        'Especialidad:',
        '11',
        urlGetClasificador + '10');

    tipoMaterial = InputDropDown(
        FaIcon(FontAwesomeIcons.userMd, color: AppTheme.themeVino),
        'Tipo Material:',
        '74',
        urlGetClasificador + '73');

    return Column(
      children: <Widget>[

        tipoMaterial,
        especialidad,
        titulo,
        resumen,
        _crearFechaInicio('Fecha Inicio'),
        _crearFechaFin('Fecha Fin'),
        divider(),
        _crearBoton(resource.save),
      ],
    );
  }

  _selectDateInicio(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020, 4),
      lastDate: new DateTime(2025, 12),
           locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateInicioController.text = _fecha;
        entity.detFechaInicio = _inputFieldDateInicioController.text;
      });
    }
  }

  _selectDateFin(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020, 4),
      lastDate: new DateTime(2025, 12),
          locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("dd/MM/yyyy").format(picked);
        _inputFieldDateFinController.text = _fecha;
        entity.detFechaFin = _inputFieldDateFinController.text;
      });
    }
  }

  Widget _crearFechaInicio(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateInicioController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: 'Fecha inicio del material',
            labelText: 'Fecha inicio del material',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeVino)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateInicio(context);
        },
      ),
    );
  }

  Widget _crearFechaFin(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _inputFieldDateFinController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            hintText: 'Fecha fin del material',
            labelText: 'Fecha fin del material',
            //    suffixIcon: Icon(Icons.perm_contact_calendar),
            icon: FaIcon(FontAwesomeIcons.calendarAlt,
                color: AppTheme.themeVino)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDateFin(context);
        },
      ),
    );
  }

_crearBoton(String text) {
   return Container(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Color.fromRGBO(165, 5, 5, 0.7),
        textColor: Colors.white,
        label: Text(
          text,
          style: kBotontitleStyle,
        ),
        icon: FaIcon(FontAwesomeIcons.checkCircle, color: Colors.white),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }

  _submit() async {
    entity.mulEnlace = imagen;

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    entity.idcovMultimedia = 0;
    entity.idaCovInstitucion = int.parse(prefs.idInsitucion);
    entity.idaTIpoMaterial = int.parse(especialidad.objectValue);
    entity.idaCategoria = int.parse(tipoMaterial.objectValue);
    entity.mulTitulo = titulo.objectValue;
    entity.mulResumen = resumen.objectValue;
    entity.detFechaFin = _inputFieldDateFinController.text;
    entity.detFechaInicio = _inputFieldDateInicioController.text;
    entity.usuario = prefs.userId;

    final dataMap = generic.add(entity, urlAddMultimedia);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');

    if (result == "0") {
      scaffoldKey.currentState
          .showSnackBar(messageOk("Se insertó correctamente"));
    } else
      scaffoldKey.currentState
          .showSnackBar(messageNOk("Error, vuelta a intentarlo"));

    setState(() {
      _save = false;
    });

    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
  }

  // _seleccionarVideo() async => _procesarVideo(VideoSource.gallery);
  _seleccionarFoto() async => _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => _procesarImagen(ImageSource.camera);
  _tomarVideo() async => _procesarVideo(ImageSource.gallery);

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);
    if (foto != null) {
      imagen = await generic.subirImagen(foto);
    }
    setState(() {
      entity.mulEnlace = imagen;
      print('cargadod e iagen ${entity.mulEnlace}');
    });
  }

  _procesarFile(String file) async {
    print('FOTOSSSSS FILE: $file');

    if (file != null) {
      imagen = await generic.subirImagenFile(file);
    }
    setState(() {
      entity.mulEnlace = imagen;
      print('cargadod e iagen ${entity.mulEnlace}');
    });
  }

  _procesarVideo2(String file) async {
    print('FOTOSSSSS FILE: $file');

    if (file != null) {
      imagen = await generic.subirVideo(file);
    }
    setState(() {
      entity.mulEnlace = imagen;
      print('cargadod e iagen ${entity.mulEnlace}');
    });
  }

  _procesarVideo(ImageSource origen) async {
    foto = await ImagePicker.pickVideo(source: origen);

    if (foto != null) {
      // imagen = await generic.subirVideo(foto);
    }
    setState(() {
      entity.mulEnlace = imagen;
      print('cargadod e iagen ${entity.mulEnlace}');
    });
  }

  void _pickPDF() async {
    try {
      var _extension = 'PDF';
      _pdfPath = await FilePicker.getFilePath(
          type: FileType.custom,
          allowedExtensions: (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '')?.split(',')
              : null);

      setState(() {});
      if (_pdfPath == '') {
        return;
      }
      print("File path11: " + _pdfPath);
      _procesarFile(_pdfPath);
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  void _pickVideo() async {
    try {
      var _extension = 'MP4';
      _pdfPath = await FilePicker.getFilePath(
          type: FileType.custom,
          allowedExtensions: (_extension?.isNotEmpty ?? false)
              ? _extension?.replaceAll(' ', '')?.split(',')
              : null);

      setState(() {});
      if (_pdfPath == '') {
        return;
      }
      print("File path11: " + _pdfPath);
      _procesarVideo2(_pdfPath);
      // setState(() {
      //   _isLoading = true;
      // });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }
}
