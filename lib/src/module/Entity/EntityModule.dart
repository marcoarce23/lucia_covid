import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class EntityModule extends StatefulWidget {
  EntityModule({Key key}) : super(key: key);

  @override
  _EntityModuleState createState() => _EntityModuleState();
}

class _EntityModuleState extends State<EntityModule> {
  InputDropDown tipoInstitucion ;
   InputDropDown ubicacion ;
   InputTextField nombre ;
   InputTextField  token;
   InputTextField direccion ;
   InputPhoneField telefono ;
   InputTextField informacion ;
  InputTextField  facebook ;
  InputTextField  twitter ;
  InputUrlField  paginaWeb ;
  InputTextField  youtube ;
   InputEmailField email ;

 bool _save = false;
  File foto;
  int _currentIndex;
  var result;
  
 
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Institucion entity = new Institucion();

  @override
  void initState() {
  _currentIndex = 0;
  super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    final Institucion entityData = ModalRoute.of(context).settings.arguments;

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
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('REGISTRO DE INSTITUCIONES', style: TextStyle(fontSize: 18, color: Colors.black),),
      backgroundColor: Colors.orange,
      actions: <Widget>[_crearIconAppImagenes(), _crearIconAppCamara()],
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

    tipoInstitucion = InputDropDown(Icons.person_pin ,'Tipo institución:','26', urlGetClasificador +'23');
    ubicacion = InputDropDown(Icons.person_pin ,'Departamento/ciudad:','26', urlGetClasificador +'23');
    nombre = InputTextField(Icon(Icons.business), 'Nombre de la institución:', '', '');
    token = InputTextField(Icon(Icons.business), 'Nombre de la institución:', '', '');
    direccion = InputTextField(Icon(Icons.business), 'Dirección/ubicacion:', '', '');
    telefono =  InputPhoneField(Icon(Icons.business), 'Telefono de referencia', '', '');
    informacion = InputTextField(Icon(Icons.business), 'Información complementaria:', '', '');
    facebook =   InputTextField(Icon(Icons.business), 'Cuenta Facebook:', '', '');
    twitter =   InputTextField(Icon(Icons.business), 'Cuenta Twitter:', '', '');
    paginaWeb =   InputUrlField(Icon(Icons.business), 'Pagina Web/block:', '', '');
    youtube =   InputTextField(Icon(Icons.business), 'Cuenta YouTube:', '', '');
    email =   InputEmailField(Icon(Icons.business), 'Correo Electronico:', '', '','Ingrese su correo electronico');

    return Column(
      children: <Widget>[
        Text('INFORMACION GENERAL',  style: TextStyle(fontSize: 18, color: Colors.black),),
        tipoInstitucion,
        ubicacion,
        token,
        nombre,
        direccion,
        telefono,
        informacion,

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Divider(color: Colors.orange, thickness: 2.0,),
        ),

        Text('REDES SOCIALES',  style: TextStyle(fontSize: 18, color: Colors.black),),

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

    entity.idInstitucion = 0;
    entity.foto = entity.foto;
    entity.insLat= -7.78;
    entity.insLng = -18.89;
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
    entity.usuario = 'marcoarce23@gmail.com';

    final dataMap = generic.add(entity, urlAddInstitucion);

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
      entity.foto = foto.path;
    }
    setState(() {});
  }
}


//"/data/user/0/com.example.lucia_covid/cache/image_picker683481716845763518.jpg"


  // Widget _crearEstadoCovid() {
  //   bool valor=true;
  //   return SwitchListTile(
  //     value: valor,
  //     title: Text('Centinela Covid',),
  //     activeColor: Colors.orange,
  //     onChanged: (value) => setState(() {
  //       valor= value;
  //     }),
  //   );
  // }