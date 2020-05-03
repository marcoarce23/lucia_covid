import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';

class VoluntaryModule extends StatefulWidget {
  const VoluntaryModule({Key key}) : super(key: key);

  @override
  _VoluntaryModuleState createState() => _VoluntaryModuleState();
}

class _VoluntaryModuleState extends State<VoluntaryModule> {
  InputTextField entidad;
  InputTextField token;
  InputTextField nombre;
  InputTextField apellido;
  InputTextField ci;
  InputTextField telefono;
  InputTextField email;
  InputTextField complmementario;
  InputSexo sexo;

  bool _save = false;
  File foto;

  String _opcionSeleccionada = '';
  String _opcionEntidad = '';
  String _opcionEspecialidad;
  String _fecha = '';
  TextEditingController _inputFieldDateController = new TextEditingController();
  List<String> _expedido = [
    'CHQ',
    'LPZ',
    'CBB',
    'ORU',
    'PTS',
    'TRJ',
    'SCZ',
    'BNI',
    'PND'
  ];
  List<String> _entidad = [
    'Seleccionar',
    'Dejame Apoyarte',
    'BOL -110',
    'SAR',
    'Narices Frias'
  ];

  List<String> _tipoEntidad = [
    'Medicina',
    'Psicologia',
    'Religioso',
    'Medicina Tradicional',
    'Psquiatria'
  ];

  int _currentIndex;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Voluntary voluntario = new Voluntary();

  @override
  void initState() {
    _currentIndex = 0;
    _opcionSeleccionada = 'LPZ';
    _opcionEntidad = 'Seleccionar';
    _opcionEspecialidad = 'Medicina'; 
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
              icon: Icon(Icons.person, size: 25.0, color: Colors.black),
              title: Text('Voluntario')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 25.0),
              title: Text('Atención-RRSS')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Integrantes')),
        ],
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2020, 3),
      lastDate: new DateTime(2025, 12),
      //    locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.toString().substring(0, 10);
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _expedido.forEach((expedido) {
      lista.add(DropdownMenuItem(
        child: Text(expedido),
        value: expedido,
      ));
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final Voluntary voluntaryData = ModalRoute.of(context).settings.arguments;

    if (voluntaryData != null) voluntario = voluntaryData;

    return Scaffold(
        key: scaffoldKey,
        appBar: _appBar(),
        body: Stack(
          children: <Widget>[
            crearFondoForm(context),
            _crearForm(context),
          ],
        ),
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
    entidad =
        InputTextField(Icon(Icons.business), 'Institución/entidad', '', '');
    token = InputTextField(Icon(Icons.security), 'Ingrese el token', '', '');
    nombre = InputTextField(Icon(Icons.person_add), 'Nombre:', '', '');
    apellido = InputTextField(Icon(Icons.person_pin), 'Apellidos:', '', '');
    ci = InputTextField(
        Icon(Icons.access_alarm), 'Documento de Identidad:', '', '');
    telefono = InputTextField(Icon(Icons.phone_android), 'Telefono:', '', '');
    email = InputTextField(
        Icon(Icons.alternate_email), 'Correo electrónico:', '', '');
    complmementario = InputTextField(
        Icon(Icons.insert_comment), 'Información complementaria', '', '');
    sexo = InputSexo();

    return Column(
      children: <Widget>[
        _crearEntidad(),
        entidad,
        token,
        nombre,
        apellido,
        _crearTipoEspecialidad(),
        Row(
          children: <Widget>[
            Expanded(
              child: ci,
            ),
            _crearExpedido(),
          ],
        ),
        telefono,
        sexo,
        email,
        _crearEsCovid('Ayuda Covid'),

        complmementario,
        _crearBoton(resource.save),
      ],
    );
  }

  Widget _crearEsCovid(String text) {
    return SwitchListTile(
      value: true,
      title: Text(text),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        //   producto.disponible = value;
      }),
    );
  }

  Widget _crearExpedido() {
    return Row(
      children: <Widget>[
        DropdownButton(
          value: _opcionSeleccionada,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionada = opt;
            });
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getEntidadDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _entidad.forEach((entidad) {
      lista.add(DropdownMenuItem(
        child: Text(entidad),
        value: entidad,
      ));
    });
    return lista;
  }

  Widget _crearEntidad() {
    return Row(
      children: <Widget>[
        SizedBox(width: 30.0),
        Text('Entidad:'),
        SizedBox(width: 30.0),
        DropdownButton(
          value: _opcionEntidad,
          items: getEntidadDropdown(),
          icon: Icon(Icons.supervised_user_circle, color: Colors.orange),
          onChanged: (opt) {
            setState(() {
              _opcionEntidad = opt;
            });
          },
        ),
      ],
    );
  }

List<DropdownMenuItem<String>> getTipoEntidadDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoEntidad.forEach((tipoEntidad) {
      lista.add(DropdownMenuItem(
        child: Text(tipoEntidad),
        value: tipoEntidad,
      ));
    });
    return lista;
  }

  Widget _crearTipoEspecialidad() {
    return Row(
      children: <Widget>[
        SizedBox(width: 30.0),
        Text('Especialidad:'),
        SizedBox(width: 30.0),
        DropdownButton(
          value: _opcionEspecialidad,
          items: getTipoEntidadDropdown(),
          icon: Icon(Icons.supervised_user_circle, color: Colors.orange),
          onChanged: (opt) {
            setState(() {
              _opcionEspecialidad = opt;
            });
          },
        ),
      ],
    );
  }
  // List<DropdownMenuItem<String>>  _crearEntidad()
  // {
  //   return FutureBuilder(
  //     future: generic.getAll(new Hospital()),
  //     builder: (BuildContext context, AsyncSnapshot<List<Entity>> snapshot) {
  //       if (snapshot.hasData) {

  //       } else
  //         return Center(child: CircularProgressIndicator());
  //     },

  //   );
  // }

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

    voluntario.perNombrepersonal = nombre.objectValue;
    voluntario.perApellido = apellido.objectValue;
    print('NOMBREERE: ${voluntario.perNombrepersonal}');
    print('ubicaion: ${voluntario.perApellido}');

    // if (hospital.nombre == null) {
    //   // generic.add(citizen);
    //   print("INSERTOOOO");
    // } else {
    //   //  generic.update(citizen);
    //   print("MODIFICO");
    // }

    // setState(() {
    //   _save = false;
    // });

    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
  }

  _seleccionarFoto() async => _procesarImagen(ImageSource.gallery);
  _tomarFoto() async => _procesarImagen(ImageSource.camera);
  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      voluntario.perNombrepersonal = null;
    }
    setState(() {});
  }
}
