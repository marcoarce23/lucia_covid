import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'package:imei_plugin/imei_plugin.dart';

class SignUpModule extends StatefulWidget {
  static final String routeName = 'login';

  @override
  _SignUpModuleState createState() => _SignUpModuleState();
}

class _SignUpModuleState extends State<SignUpModule> {
  InputEmailField correo;
  InputTextPassword contrasenia;

  //bool _save = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  LoginSigIn entity = new LoginSigIn();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  var result;
    var result1;
    String  result2;

  GoogleSignInAccount currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  get respuesta => null;

  @override
  void initState() {
    super.initState();
    prefs.ultimaPagina = SignUpModule.routeName;
    initPlatformState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> initPlatformState() async {
    String platformImei = 'Failed to get platform version.';
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      idunique = await ImeiPlugin.getId();
    } catch (error) {
      print(error);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
      uniqueId = idunique;
    });
  }

  Future<void> handleSignIn() async
  {
        try 
        {
          await _googleSignIn.signIn();
        

        final dataMap1 = generic.getAll(entity, getLogin+'${currentUser.email}', primaryKeyGetLogin);

         dataMap1.then((value)
         {
           print('tamaño: ${value.length} ');
            if(value.length > 0)
            {
                for(int i=0; i < value.length; i++) {
                  entity = value[i];
                }
                  prefs.imei = entity.imei;
                  prefs.nombreUsuario= entity.nombrePersona;
                  prefs.correoElectronico = entity.correo;
                  prefs.avatarImagen =  entity.avatar;
                  
                  prefs.nombreInstitucion = entity.nombreInstitucion;
                  prefs.idInsitucion = entity.idInstitucion;
                  prefs.idPersonal = entity.idPersonal;
                  prefs.userId =entity.idUsuario;


                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.bounceOut,
                      type: PageTransitionType.rotate,
                      alignment: Alignment.topCenter,
                      child: IntroScreenModule(),
                    ));
      
            }
            else
            {
                entity.idUsuario = currentUser.id;
                entity.idInstitucion = '-1';
                entity.nombrePersona = currentUser.displayName;
                entity.nombreInstitucion = '-1';
                entity.usuario = currentUser.email;
                entity.correo = currentUser.email;
                entity.avatar =  (currentUser.photoUrl == null) ? 'https://definicionyque.es/wp-content/uploads/2017/11/Medicina_Preventiva.jpg': currentUser.photoUrl;
                entity.password = '-1';
                entity.tokenDispositivo = prefs.token;
                entity.imei = _platformImei;
                entity.primeraVez = '-1';

                final dataMap = generic.add(entity, urlAddSignIn);
                dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
                print('resultado:$result ');

                if (result != "-1") 
                {
                    prefs.imei = _platformImei;
                    prefs.nombreUsuario= currentUser.displayName;
                    prefs.correoElectronico = currentUser.email;
                    prefs.avatarImagen =  currentUser.photoUrl;
                    prefs.userId =result;

                    Navigator.push(
                      context,
                      PageTransition(
                        curve: Curves.bounceOut,
                        type: PageTransitionType.rotate,
                        alignment: Alignment.topCenter,
                        child: IntroScreenModule(),
                      ));
                }
                else{
                    scaffoldKey.currentState.showSnackBar(messageNOk("Se produjo un error, vuelta a intentarlo"));
                }
            }
         });
       } catch (error) {
         print('rrrr: $error ');
     }
  }

  Future<void> handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        body: Stack(
      children: <Widget>[
     //   crearFondo(context),
        _crearForm(context),
      ],
    ));
  }

  Widget _crearForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                 decoration: BoxDecoration(
                    gradient: RadialGradient(
                    colors: [
                      Color(0xFF3594DD),
                      Color(0xFF4563DB),
                      Color(0xFF5036D5),
                      Color(0xFF5B16D0),
                  ],
      ),
                 )
                 
                 
               
              //  height: 170.0,
              ),
            ),
        //     Container(
        //       width: size.width * 0.85,
        //       margin: EdgeInsets.symmetric(vertical: 10.0),
        //       // padding: EdgeInsets.symmetric( vertical: 30.0 ),
        //      // decoration: _crearContenedorCampos(),
        //  //     child: _crearCampos(),
        //     ),


             Container(
             
               child: Column(
                 children: <Widget>[
                   Text('Estamos contigo. Beinvenido'),
                   Text('Lucia Te Cuida. La App de nuestro corazón'),
                   Image(image: AssetImage("assets/buu.PNG"), height: 250.0),
                 ],
               ),
             ),

            SizedBox(height: 20.0),
            acuerdo(),
               _leerAcuerdo(),
            _dividerOr(),
            _gmailButton(),
            _gmailButtonCerrar(),
         //   _crearBoton('Cerrar Sesión'),
           

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: Colors.orange,
                thickness: 2.0,
              ),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  // Widget _crearCampos() {
  //   correo = InputEmailField(
  //       FaIcon(FontAwesomeIcons.user, color: Colors.orange),
  //       'Correo electrónico',
  //       '',
  //       'Ingresar su correo electrónico',
  //       'ej: cuenta@correo.com');
  //   contrasenia = InputTextPassword(
  //       FaIcon(FontAwesomeIcons.expeditedssl, color: Colors.orange),
  //       'Contraseña:',
  //       '',
  //       'Ingrese su contraseña');
  //   return Column(
  //     children: <Widget>[
  //       SizedBox(height: 15.0),
  //       Text(
  //         'LUCIA TE CUIDA',
  //         style: TextStyle(fontSize: 18, color: Colors.black),
  //         textAlign: TextAlign.center,
  //       ),
  //       SizedBox(width: 5.0),
  //       FaIcon(
  //         FontAwesomeIcons.keybase,
  //         color: Colors.blue,
  //         size: 20,
  //       ),
  //       correo,
  //       contrasenia,
  //      // _crearBoton('Cerrar Sesión'),
  //       _forgetPassword(),
  //     ],
  //   );
  // }

  // _crearContenedorCampos() {
  //   return BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(5.0),
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Colors.black26,
  //             blurRadius: 3.0,
  //             offset: Offset(0.0, 5.0),
  //             spreadRadius: 3.0)
  //       ]);
  // }

  // Widget _crearBoton(String text) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 65.0),
  //     width: MediaQuery.of(context).size.width,
  //     child: RaisedButton.icon(
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
  //       color: Colors.blue,
  //       textColor: Colors.white,
  //       label: Text(
  //         text,
  //         style: TextStyle(
  //           fontSize: 18,
  //           color: Colors.white,
  //         ),
  //       ),
  //       icon: Icon(Icons.check),
  //       onPressed: handleSignOut,// (_save) ? null : _submit,
  //     ),
  //   );
  // }

  // void _submit() async {
  //   if (!formKey.currentState.validate()) return;

  //   formKey.currentState.save();
  //   setState(() {
  //  //   _save = true;
  //   });

  //   entity.idUsuario = '0';
  //   entity.idInstitucion = '-1';
  //   entity.nombrePersona = '0';
  //   entity.nombreInstitucion = '0';
  //   entity.usuario = correo.objectValue;
  //   entity.avatar = '';
  //   entity.password = contrasenia.objectValue;
  //   entity.tokenDispositivo = prefs.token;
  //   entity.imei = _platformImei;

  //   final dataMap = generic.add(entity, urlAddSignIn);

  //   await dataMap.then((x) => result = x["TIPO_RESPUESTA"]);
  
  //   if (result != '-1') {
  //     print('valro de result de login es: $result');
  //     prefs.imei = int.parse(_platformImei);
  //     prefs.nombreUsuario = currentUser.displayName;
  //     prefs.correoElectronico = currentUser.email;
  //     prefs.avatarImagen = currentUser.photoUrl;
  //     prefs.userId = result;
      
  //     Navigator.push(
  //         context,
  //         PageTransition(
  //           curve: Curves.bounceOut,
  //           type: PageTransitionType.rotate,
  //           alignment: Alignment.topCenter,
  //           child: IntroScreenModule(),
  //         ));
  //   } else {
  //     Navigator.push(
  //         context,
  //         PageTransition(
  //           curve: Curves.bounceOut,
  //           type: PageTransitionType.rotate,
  //           alignment: Alignment.topCenter,
  //           child: SignUpModule(),
  //         ));
  //   }
  //   setState(() {
  //    // _save = false;
  //   });
  // }

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
          Text('SI CUENTAS CON CORREO GMAIL'),
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

  Widget acuerdo() {
    bool valor = false;
    return CheckboxListTile(
        title:  Text('Acepto los terminos'),
        subtitle: Text('Lea los terminos y acuerdos'),
        value: valor,
        onChanged: (value) {
          setState(() {
            valor= value;
          });
        });
  }

   _leerAcuerdo() {
    return FlatButton(
        child: Text('Leer el acuerdo aca.. Aqui.'), onPressed: () => Navigator.push(
          context,
          PageTransition(
            curve: Curves.bounceOut,
            type: PageTransitionType.rotate,
            alignment: Alignment.topCenter,
            child: ForgetPassword(),
          ))
        
      );
    //       Navigator.of(context).push(PageRouteTheme(AgreeLoginModule())));
  }

  Widget _gmailButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Registrate con Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _gmailButtonCerrar() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Cerrar Sesión Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
