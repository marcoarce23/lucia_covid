import 'dart:io';

import 'package:flutter/material.dart';

import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:image_picker/image_picker.dart';

class ForgetPassword extends StatefulWidget 
{
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
{
 
 bool _save = false;
    File foto;
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final generic = new Generic();
    final prefs = new PreferensUser();

    Hospital hospital = new Hospital();
    
    @override
    Widget build(BuildContext context) {
      final Hospital hospitalData = ModalRoute.of(context).settings.arguments;

      if (hospitalData != null) hospital = hospitalData;

      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('CAMBIO DE CONTRASEÑA'),
          backgroundColor: Colors.deepOrange,
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  _crearNombre('Correo Electrónico.'),
                  _crearPassword('Contraseña.'),
                  _crearPassword2('Repita la contraseña.'),
                  Divider(height: 10.0),
                  _crearBoton(),
                ],
              ),
            ),
          ),
        ),
      );
    }


  
    Widget _crearNombre(String text) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical:16.0, horizontal: 20.0),
        child: TextFormField(
          initialValue: prefs.avatarImagen,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: text,
            hintText: 'ej: juan.perez@gmail.com',
          ),
          validator: (value) => validator.validateTextfieldEmpty(value),
          onSaved: (value)   => hospital.nombre = value,
        ),
      );
    }

    Widget _crearPassword(String text) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0),
        child: TextFormField(
          initialValue: hospital.ubicacion,
          obscureText: true,
          decoration: InputDecoration(
            labelText: text,
         ),
         validator: (value) => validator.validateTextfieldEmpty(value),
          onSaved: (value)   => hospital.ubicacion = value,
        ),
      );
    }

 Widget _crearPassword2(String text) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0),
        child: TextFormField(
          initialValue: hospital.ubicacion,
          obscureText: true,
          decoration: InputDecoration(
            labelText: text,
         ),
         validator: (value) => validator.validateTextfieldEmpty(value),
          onSaved: (value)   => hospital.ubicacion = value,
        ),
      );
    }
    Widget _crearBoton() {
      return RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.deepOrange,
        textColor: Colors.white,
        label: Text('Guardar'),
        icon: Icon(Icons.save),
        onPressed: (_save) ? null : _submit,
      );
    }

    void _submit() async 
    {
      if (!formKey.currentState.validate()) return;

      formKey.currentState.save();
      setState(() { _save = true; });

       if ( foto != null ) {
      //        producto.fotoUrl = await productoProvider.subirImagen(foto);
        }

         if (hospital.nombre == null) {
      // generic.add(citizen);
          print("INSERTOOOO");
          } else {
          //  generic.update(citizen);
          print("MODIFICO");
          }

      setState(() { _save = false; });
      mostrarSnackbar(resource.saved);
    //  Navigator.pop(context);
    }

    Widget _mostrarFoto() {
      if (hospital.nombre != null) {
        return FadeInImage(
          image: NetworkImage('https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14046.jpg'),
          placeholder: AssetImage('assets/image/jar-loading.gif'),
          height: 200.0,
          fit: BoxFit.contain,
        );
      } else {
        return Image(
          image: AssetImage(foto?.path ?? 'assets/image/no-image.png'),
          height: 200.0,
          fit: BoxFit.cover,
        );
      }
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

     void mostrarSnackbar(String mensaje) {
      final snackbar = SnackBar(
        content: Text(mensaje),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 1500),
      );

      scaffoldKey.currentState.showSnackBar(snackbar);
    }
}