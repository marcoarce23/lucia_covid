import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Util/SearchDelegate/DataSearch.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/ListCitizenHelpModule.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

// class _HeaderWaveGradientPainter extends CustomPainter {

//   @override

//   void paint(Canvas canvas, Size size) {

//     final Rect rect = new Rect.fromCircle(

//       center: Offset(0.0, 55.0),

//       radius: 180

//     );

//     final Gradient gradiente = new LinearGradient(

//       begin: Alignment.topCenter,

//       end: Alignment.bottomCenter,

//       colors: <Color>[

//         Color(0xff6D05E8),

//         Color(0xffC012FF),

//         Color(0xff6D05FA),

//       ],

//       stops: [

//         0.2,

//         0.5,

//         1.0,

//       ]

//     );

//     final lapiz = new Paint()..shader = gradiente.createShader(rect);

//     // Propiedades

//     // lapiz.color = Color(0xff615AAB);

//     // lapiz.color = Colors.red;

//     lapiz.style = PaintingStyle.fill; // .fill .stroke

//     lapiz.strokeWidth = 20;

//     final path = new Path();

//     // Dibujar con el path y el lapiz

//     path.lineTo( 0, size.height * 0.25 );

//     path.quadraticBezierTo(size.width * 0.25, size.height * 0.30, size.width * 0.5, size.height * 0.25 );

//     path.quadraticBezierTo(size.width * 0.75, size.height * 0.20, size.width, size.height * 0.25 );

//     path.lineTo( size.width, 0 );

//     canvas.drawPath(path, lapiz );

//   }

//   @override

//   bool shouldRepaint(CustomPainter oldDelegate) {

//     return true;

//   }

// }

class HelpFriendAllModule extends StatefulWidget {
  static final String routeName = 'amigo';
  const HelpFriendAllModule({Key key}) : super(key: key);

  @override
  _HelpFriendAllModuleState createState() => _HelpFriendAllModuleState();
}

class _HelpFriendAllModuleState extends State<HelpFriendAllModule> {
  final prefs = new PreferensUser();
  final generic = new Generic();
  int page = 0;
  final List<Widget> optionPage = [
    CitizenHelpModule(),
    ListCitizenHelpModule()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = HelpFriendAllModule.routeName;
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.themeVino,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeColorBlanco, size: 12),
        elevation: 0,
        title: Text(
          "AYUDA A UN AMIGO(A)",
          style: TextStyle(
              color: Colors.white,
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
        backgroundColor: Color.fromRGBO(165, 5, 5 , 0.7),
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.userCircle,
                size: 25,
              ),
              title: Text('Ayudalo')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendarCheck,
                size: 25,
              ),
              title: Text('Solicitudes')),
        ],
        currentIndex: page,
        unselectedItemColor: Colors.white,
        selectedItemColor: AppTheme.themeAmarillo,
        onTap: _onItemTapped,
      ),
      body: optionPage[page],
    );
  }
}

class CitizenHelpModule extends StatefulWidget {
  static final String routeName = 'helpCitizen';
  @override
  _CitizenHelpModuleState createState() => _CitizenHelpModuleState();
}

class _CitizenHelpModuleState extends State<CitizenHelpModule> {
  InputTextField nombre;
  InputPhoneField telefono;
  InputMultilineField ubicacion;
  InputDropDown tipoAyuda;

  bool _save = false;
  String _opcionSeleccionadaPrioridad = '';
  var result;
  var list;

  List<String> _tipoPrioridad = ['Muy Alta', 'Alta', 'Media'];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  final prefs = new PreferensUser();
  RegistroAmigo registroAmigo = new RegistroAmigo();

  @override
  void initState() {
    _opcionSeleccionadaPrioridad = 'Muy Alta';
    prefs.ultimaPagina = CitizenHelpModule.routeName;
    super.initState();
  }

  List<DropdownMenuItem<String>> getOpcionesPrioridad() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoPrioridad.forEach((tipoPrioridad) {
      lista.add(DropdownMenuItem(
        child: Text(tipoPrioridad),
        value: tipoPrioridad,
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> getipoAy(AsyncSnapshot snapshot) {
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(), //tipoPrioridad.id,
      ));
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final RegistroAmigo registroAmigoData =
        ModalRoute.of(context).settings.arguments;

    if (registroAmigoData != null) registroAmigo = registroAmigoData;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
         // fondoApp1(),
          _crearForm(),
        ],
      ),
    );
  }

  Widget informacionProfesional(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(5.0),
        width: MediaQuery.of(context).size.width - 30,
         decoration: contenedorCabecera(),
         
        //  BoxDecoration(
        //     borderRadius: BorderRadius.circular(18),
        //     gradient: LinearGradient(colors: <Color>[
        //       // Color.fromRGBO(243, 124, 18, 1.0),
        //       // Color.fromRGBO(255, 209, 18, 3.0),
        //       // Color.fromRGBO(243, 156, 18, 1.0),
        //       // Color.fromRGBO(243, 223, 18, 1.0)

        //       Color.fromRGBO(252, 252, 250 , 1.0),
        //       Color.fromRGBO(248, 247, 233 , 3.0),
        //       Color.fromRGBO(249, 245, 211 , 1.0),
        //       Color.fromRGBO(247, 224, 155 , 1.0)
        //     ])),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                imagenProfesional(),
                SizedBox(width:15.0),
                RichText(
                  text: TextSpan(
                    text: 'Voluntario(a): ${prefs.nombreUsuario}', // 'Dr Dan MlayahFX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n' + 'Institución: ${prefs.nombreInstitucion}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            divider(),
          ],
        ),
      ),
    );
  }

  ImageOvalNetwork imagenProfesional() {
    return ImageOvalNetwork(imageNetworkUrl:prefs.avatarImagen, sizeImage: Size.fromWidth(45));
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

  Widget _crearForm() {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            informacionProfesional(context),
          //  SizedBox(height:3.0 ),
            contenedorTitulo(context, 45.0, 'REGISTRO DE DATOS',  FaIcon(FontAwesomeIcons.userMd, color: Colors.white60),) ,
                SizedBox(height: 5.0),
            Container(
              width: size.width * 0.90,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: contenedorCampos(),
              child: _crearCampos(context),
            ),
            copyRigth(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos(BuildContext context) {
    nombre = InputTextField(
        FaIcon(FontAwesomeIcons.accessibleIcon, color: Color.fromRGBO(165, 5, 5 , 0.7)),
        'Persona a ayudar',
        registroAmigo.regPersona,
        'Ingrese el nombre de la persona', true);
    telefono = InputPhoneField(
        FaIcon(FontAwesomeIcons.phoneVolume, color: Color.fromRGBO(165, 5, 5 , 0.7)),
        'Telefono de referencia',
        registroAmigo.regTelefono,
        'Registre un numero telefónico de referencia', true);
    ubicacion = InputMultilineField(
        FaIcon(FontAwesomeIcons.home, color: Color.fromRGBO(165, 5, 5 , 0.7)),
        'Donde la encuentro',
        registroAmigo.regUbicacion,
        'Lugar donde se encuentra la persona a ayudar', true);

    tipoAyuda = InputDropDown(
        FaIcon(FontAwesomeIcons.plusCircle, color: Color.fromRGBO(165, 5, 5 , 0.7)),
        'Tipo de ayuda',
        '49',
        urlGetClasificador + '/47');

    return Column(
      children: <Widget>[
      
        nombre,
        telefono,
        ubicacion,
        tipoAyuda,
        _crearTipoPrioridad(),
        divider(),
        _crearBoton(resource.save),
      ],
    );
  }

  Widget _crearTipoPrioridad() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('Prioridad:'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: _opcionSeleccionadaPrioridad,
          icon: FaIcon(FontAwesomeIcons.longArrowAltDown, color: Color.fromRGBO(165, 5, 5 , 0.7)),
          items: getOpcionesPrioridad(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionadaPrioridad = opt;
            });
          },
        ),
      ],
    );
  }

  Widget _crearBoton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Color.fromRGBO(165, 5, 5 , 0.7),// Colors.red,
        textColor: Colors.white,
        label: Text(text, style: kSubtitleStyle,),
        icon:  FaIcon(FontAwesomeIcons.save, color: Colors.white),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }

  _submit() async {

    LatLng latLng;
    latLng = await getLocation().then((onvalue) => latLng = onvalue);

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    registroAmigo.idcovRegistroAmigo = 0;
    registroAmigo.regPersona = nombre.objectValue;
    registroAmigo.regTelefono = telefono.objectValue;
    registroAmigo.regUbicacion = ubicacion.objectValue;
    registroAmigo.regPrioridad = _opcionSeleccionadaPrioridad;
    registroAmigo.regTipoAPoyo = int.parse(tipoAyuda.objectValue);
    registroAmigo.latitud = latLng.latitude;
    registroAmigo.longitud = latLng.longitude;
    registroAmigo.usuario = prefs.userId;

    final dataMap = generic.add(registroAmigo, urlAddVoluntary);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');

    if (result == "0") {
      // scaffoldKey.currentState.showSnackBar(messageOk("Se inserto correctaente"));
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => ListCitizenHelpModule()));
    } else
      scaffoldKey.currentState.showSnackBar(messageNOk("Error, vuelta a intentarlo"));

    setState(() {
      _save = false;
    });
  }
}
