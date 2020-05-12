
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CitizenModule extends StatefulWidget {
  @override
  _CitizenModuleState createState() => _CitizenModuleState();
}

class _CitizenModuleState extends State<CitizenModule> {
  bool _save = false;
  File foto;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  String _opcionSeleccionada = 'LPZ';
  String _fecha = '';
  String imagen = 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
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
  int _selectedRadio;
  int _currentIndex;
  Hospital hospital = new Hospital();

  @override
  void initState() {
    _selectedRadio = 0;
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Hospital hospitalData = ModalRoute.of(context).settings.arguments;

    if (hospitalData != null) hospital = hospitalData;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Registro de Voluntario'),
          backgroundColor: Colors.orange,
          actions: <Widget>[_crearIconAppImagenes(), _crearIconAppCamara()],
        ),
        body: Stack(
          children: <Widget>[
            crearFondoForm(context, imagen),
            _crearForm(context),
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context));
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
                height: 120.0,
              ),
            ),
            Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              //     padding: EdgeInsets.symmetric( vertical: 30.0 ),
              decoration: _crearContenedorCampos(),
              child: _crearCampos(),
            ),
          ],
        ),
      ),
    );
  }

  _callPage(int currentIdex) {
    print('INDEX:$currentIdex');
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => CitizenModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => SignUpModule()));
    if (currentIdex == 2)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => SignUpModule()));
   
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.black,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Color.fromRGBO(35, 35, 33, 1.0)))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
             _currentIndex = value;
            _callPage(_currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Voluntario')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Materiales')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 25.0),
              title: Text('Agrupación')),
        ],
      ),
    );
  }

  Widget _crearCampos() {
    return Column(
      children: <Widget>[
        //  Text('Bienvenido a "Lucia Te Cuida."', style: TextStyle(fontSize: 20.0)),
        _crearNombre('Nombres:'),
        _crearApellidos('Apellidos:'),
       

        Row(
          children: <Widget>[
            Expanded(child: _crearCI('Documento de Identidad'),),
             _crearExpedido(),
             
          ],
        ),
        _crearTelefono('Telefono'),
        _crearSexo('Sexo'),
        _crearEmail('Correo ELectrónico'),
        _crearFechaNacimiento('Fecha de Nacimiento:'),
        _crearBoton(resource.save),
        // _forgetPassword(),
      ],
    );
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

  Widget _crearExpedido() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        //  SizedBox(width: 30.0),
        //      Expanded(
        DropdownButton(
          value: _opcionSeleccionada,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionada = opt;
            });
          },
        ),
        //   )
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      //    locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.toString().substring(0, 10);
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _crearFechaNacimiento(String text) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20.0)
          // ),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          suffixIcon: Icon(Icons.perm_contact_calendar),
          icon: Icon(Icons.calendar_today)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      _selectedRadio = val;
    });
  }

  Widget _crearSexo(String text) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Masculino'),
          leading: Radio(
            value: 0,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              setSelectedRadio(value);
            },
          ),
        ),
        ListTile(
          title: Text('Femenino'),
          leading: Radio(
            value: 1,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              setSelectedRadio(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _crearApellidos(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        maxLength: 30,
        enableSuggestions: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: text,
          icon: Icon(Icons.person_outline, color: Colors.blue),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearNombre(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        textCapitalization: TextCapitalization.sentences,
        enableInteractiveSelection: true,
        maxLength: 30,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: 'Nombre',
          labelText: text,
          icon: Icon(Icons.person_pin, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearTelefono(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        keyboardType: TextInputType.number,
        enableInteractiveSelection: true,
        maxLength: 30,
        enableSuggestions: true,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: text,
          helperText: text,
          icon: Icon(Icons.phone, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearCI(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        keyboardType: TextInputType.text,
        enableInteractiveSelection: true,
        maxLength: 30,
        enableSuggestions: true,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: text,
          icon: Icon(Icons.note, color: Colors.orange),
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

  void _submit() async {
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

  Widget _crearEmail(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: hospital.nombre,
        enableInteractiveSelection: true,
        maxLength: 30,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          //  hintText: 'Ingrese el correo elecrrónico válido',
          focusColor: Colors.blue,
          labelText: 'Correo electrónico:',
          helperText: 'ej: juan.perez@gmail.com',
          icon: Icon(Icons.alternate_email, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

//       return Scaffold(
//         key: scaffoldKey,
//         appBar: AppBar(
//           title: Text('"Lucia te cuida !!!"'),
//           backgroundColor: Colors.orange,
//           actions: <Widget>[
//            _crearIconAppImagenes(),
//            _crearIconAppCamara()
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Container(

//           //  padding: EdgeInsets.all(15.0),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: <Widget>[

//                   crearFondo( context ),
//           //        _mostrarFoto(),
//                   _crearNombre('Nombres.'),
//                   _crearPrecio('Precio.'),
//                   _crearPrecio('Detalle.'),
//                   Divider(height: 10.0),
//                   _crearBoton(),
//                   _crearShared()
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     Widget _crearNombre(String text) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical:16.0, horizontal: 20.0),
//         child: TextFormField(
//           initialValue: hospital.nombre,
//           textCapitalization: TextCapitalization.sentences,
//           decoration: InputDecoration(
//             labelText: text,
//             hintText: 'ej: <Juan Perez>',
//           ),
//           validator: (value) => validator.validateTextfieldEmpty(value),
//           onSaved: (value)   => hospital.nombre = value,
//         ),
//       );
//     }

//     Widget _crearPrecio(String text) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0),
//         child: TextFormField(
//           initialValue: hospital.ubicacion,
//           keyboardType: TextInputType.numberWithOptions(decimal: true),
//           decoration: InputDecoration(
//             labelText: text,
//             hintText: 'ejemplo: 12.0',
//           ),
//          validator: (value) => validator.validateTextfieldEmpty(value),
//           onSaved: (value)   => hospital.ubicacion = value,
//         ),
//       );
//     }

//     Widget _crearBoton() {
//       return RaisedButton.icon(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//         color: Colors.deepOrange,
//         textColor: Colors.white,
//         label: Text('Guardar'),
//         icon: Icon(Icons.save),
//         onPressed: (_save) ? null : _submit,
//       );
//     }

// Widget _crearShared() {
//       return RaisedButton.icon(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//         color: Colors.deepOrange,
//         textColor: Colors.white,
//         label: Text('Abrir web'),
//         icon: Icon(Icons.share),
//         onPressed:() =>    FlutterOpenWhatsapp.sendSingleMessage("918179015345", "Hello")

//         //callNumber(72038768)

//         //util.sendEmail('coavchristian@hotmail.com', 'envio del correo de covid')

//         //util.openWeb('https://www.google.com/search?q=enlazar+flutter+con+whatsapp&rlz=1C1CHBF_esBO886BO886&oq=enlazar+flutter+con+whatsapp&aqs=chrome..69i57j33.7556j1j8&sourceid=chrome&ie=UTF-8')

//         //util.sharedImage('assets/image/no-image.png', 'test.png', 'test.png', 'png', 'Es una imagen compartida desde la app COVID')
//       );
//     }

//  _submit2(String image) async
//     {
//         final ByteData bytes = await rootBundle.load(image);
//         Share.file('esys image', 'esys.png',
//                         bytes.buffer.asUint8List(),
//                         'image/png', text: 'My optional text.');
//     }

//     void _submit() async
//     {
//       if (!formKey.currentState.validate()) return;

//       formKey.currentState.save();
//       setState(() { _save = true; });

//        if ( foto != null ) {
//    //           hospital.nombre = await generic.subirImagen(foto);
//         }

//          if (hospital.nombre == null) {
//       // generic.add(citizen);
//           print("INSERTOOOO");
//           } else {
//           //  generic.update(citizen);
//           print("MODIFICO");
//           }

//       setState(() { _save = false; });
//       mostrarSnackbar(resource.saved);
//     //  Navigator.pop(context);
//     }

//     Widget _mostrarFoto() {
//       if (hospital.nombre != null) {
//         return FadeInImage(
//           image: NetworkImage('https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14046.jpg'),
//           placeholder: AssetImage('assets/image/jar-loading.gif'),
//           height: 200.0,
//           fit: BoxFit.contain,
//         );
//       } else {
//         return Image(
//           image: AssetImage(foto?.path ?? 'assets/image/no-image.png'),
//           height: 200.0,
//           fit: BoxFit.cover,
//         );
//       }
//     }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      hospital.nombre = null;
    }
    setState(() {});
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
