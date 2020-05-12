import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';

class ForgetPassword extends StatefulWidget 
{
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
{
  bool _save = false;
  String imagen = 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';
  File foto;
  final formKey = GlobalKey<FormState>();
  final generic = new Generic();
  final prefs = new PreferensUser();

  Hospital hospital = new Hospital();

@override
  void initState() {
    super.initState();
 }

 Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('RESETEAR CONTRASEÑA'),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _tomarFoto,
            ),
          ],
        ),

        body: Stack(
      children: <Widget>[
        crearFondoForm(context, imagen),
        _crearForm(context),
      ],
    ));
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
              width: size.width * 0.90,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              // padding: EdgeInsets.symmetric( vertical: 30.0 ),
              decoration: _crearContenedorCampos(),
              child     : _crearCampos(),
            ),
             SizedBox(height: 5.0),
            _dividerOr(),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    return Column(
      children: <Widget>[
        SizedBox(height:15.0),
        Text('Cambiar la contraseña."', style: TextStyle(fontSize: 20.0)),
        _crearEmail('Correo ELectrónico'),
        _crearPassword('Contraseña:'),
        _crearPassword('Repetir contraseña:'),
        _crearBoton('Resetear'),
      ],
    );
  }
  
  _crearContenedorCampos() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: Offset(0.0, 5.0),
              spreadRadius: 3.0)
        ]);
  }

  Widget _crearBoton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 65.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: Colors.blue,
        textColor: Colors.white,
        label: Text(
                'Resetear',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
        icon: Icon(Icons.check),
        onPressed: (_save) ? null : _submit,
      ),
    );
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
          labelText:  'Correo electrónico:',
          helperText: 'ej: juan.perez@gmail.com',
          icon: Icon(Icons.alternate_email, color: Colors.orange),
        ),
        validator: (value) => validator.validateTextfieldEmpty(value),
        onSaved: (value) => hospital.nombre = value,
      ),
    );
  }

  Widget _crearPassword(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        maxLength: 10,
        decoration: InputDecoration(
          labelText: text,
          icon: Icon(Icons.lock_outline, color: Colors.orange),
           helperText: 'Nota: caracter especial, un numero.',
        ),
        validator: (value) => validator.validateTextfieldLength(value, 6),
        onSaved: (value) => hospital.nombre = value,
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

    Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SignUpModule()));
  }

  
  Widget _dividerOr() {
    return Container(
      //   margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text('Sabías Que ?'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

    _seleccionarFoto() async { _procesarImagen(ImageSource.gallery); }

    _tomarFoto() async { _procesarImagen(ImageSource.camera); }

    _procesarImagen(ImageSource origen) async 
    {
        foto = await ImagePicker.pickImage(source: origen);

        if (foto != null) {
          hospital.nombre = null;
        }
      setState(() {});
    }
 


 
}

//     bool _save = false;
//     File foto;
//     final formKey = GlobalKey<FormState>();
//     final scaffoldKey = GlobalKey<ScaffoldState>();
//     final generic = new Generic();
//     final prefs = new PreferensUser();

//     Hospital hospital = new Hospital();
    
//     @override
//     Widget build(BuildContext context) {

//       final Hospital hospitalData = ModalRoute.of(context).settings.arguments;

//       if (hospitalData != null) hospital = hospitalData;

//       return Scaffold(
//         key: scaffoldKey,
//         appBar: AppBar(
//           title: Text('RESETEAR CONTRASEÑA'),
//           backgroundColor: Colors.orange,
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.photo_size_select_actual),
//               onPressed: _seleccionarFoto,
//             ),
//             IconButton(
//               icon: Icon(Icons.camera_alt),
//               onPressed: _tomarFoto,
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(15.0),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: <Widget>[
//                   _mostrarFoto(),
//                   _crearNombre('Correo Electrónico.'),
//                   _crearPassword('Contraseña.'),
//                   _crearPassword2('Repita la contraseña.'),
//                   Divider(height: 10.0),
//                   _crearBoton(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }


  
//     Widget _crearNombre(String text) {
//        return Padding(
//       padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
//       child: TextFormField(
//         initialValue: hospital.nombre,
//         enableInteractiveSelection: true,
//         maxLength: 30,
        
//         enableSuggestions: true,
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//         //  hintText: 'Ingrese el correo elecrrónico válido',
//          focusColor: Colors.blue,
//           labelText:  'Correo electrónico:',
//           helperText: 'ej: juan.perez@gmail.com',
//           icon: Icon(Icons.alternate_email, color: Colors.orange),
//         ),
//         validator: (value) => validator.validateTextfieldEmpty(value),
//         onSaved: (value) => hospital.nombre = value,
//       ),
//     );
//     }

//     Widget _crearPassword(String text) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0),
//         child: TextFormField(
//           initialValue: hospital.ubicacion,
//           obscureText: true,
//           decoration: InputDecoration(
//             labelText: text,
//          ),
//          validator: (value) => validator.validateTextfieldEmpty(value),
//           onSaved: (value)   => hospital.ubicacion = value,
//         ),
//       );
//     }

//  Widget _crearPassword2(String text) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0),
//         child: TextFormField(
//           initialValue: hospital.ubicacion,
//           obscureText: true,
//           decoration: InputDecoration(
//             labelText: text,
//          ),
//          validator: (value) => validator.validateTextfieldEmpty(value),
//           onSaved: (value)   => hospital.ubicacion = value,
//         ),
//       );
//     }
//     Widget _crearBoton() {
//       return RaisedButton.icon(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//         color: Colors.orange,
//         textColor: Colors.white,
//         label: Text('Guardar'),
//         icon: Icon(Icons.save),
//         onPressed: (_save) ? null : _submit,
//       );
//     }

//     void _submit() async 
//     {
//       if (!formKey.currentState.validate()) return;

//       formKey.currentState.save();
//       setState(() { _save = true; });

//        if ( foto != null ) {
//       //        producto.fotoUrl = await productoProvider.subirImagen(foto);
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

//     _seleccionarFoto() async { _procesarImagen(ImageSource.gallery); }

//     _tomarFoto() async { _procesarImagen(ImageSource.camera); }

//     _procesarImagen(ImageSource origen) async 
//     {
//         foto = await ImagePicker.pickImage(source: origen);

//         if (foto != null) {
//           hospital.nombre = null;
//         }
//       setState(() {});
//     }

//      void mostrarSnackbar(String mensaje) {
//       final snackbar = SnackBar(
//         content: Text(mensaje),
//         backgroundColor: Colors.green,
//         duration: Duration(milliseconds: 1500),
//       );

//       scaffoldKey.currentState.showSnackBar(snackbar);
//     }
// }