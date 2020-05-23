import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/DrawerWidget/DrawerWiguet.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenEmergency/CitizenEmergencyModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenEvents/CitizenEventsModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenAtentionRegisterModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenHelpModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenInstitution/CitizenListInstitucionModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenMultimedia/CitizenMultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenPanicButton/CitizenPanicButtonModule.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/EntityModule.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/EventEntityModule.dart';
import 'package:lucia_covid/src/module/Citizen/Multimedia/MultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/EventModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/FoundVoluntaryModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/VoluntaryModule.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/IntroScreenModule.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';


class HomePageModule extends StatefulWidget {
  static final String routeName = 'home';

  HomePageModule({Key key}) : super(key: key);

  @override
  _HomePageModuleState createState() => _HomePageModuleState();
}

class _HomePageModuleState extends State<HomePageModule> {
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = HomePageModule.routeName;
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
        title: 
        Row(
            children: <Widget>[
        Text( "Accesos rápidos",  style: kTitleAppBar),
              SizedBox(width: 10.0),
              FaIcon(
                FontAwesomeIcons.keybase,
                color: Colors.white,
                size: 18,
              ),
            ],
          )          
        ),
        body: Stack(
          children: <Widget>[
            _fondoApp(),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    //_titulos(),
                    SizedBox(height: 25,),
                     _botonesRedondeados()],
                ),
              ),
            )
          ],
        ),
        drawer: DrawerCitizen(),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: boxDecoration(),
    );

    return Stack(
      children: <Widget>[
        gradiente
      ], // Positioned(top: -100.0, child: cajaRosa)],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child:     
      Container(
            width: MediaQuery.of(context).size.width ,
            margin: EdgeInsets.symmetric(vertical: 0.0),
            child: contenedorTitulo(
              context,
              40.0,
             'Estamos contigo para ayudarte',
              FaIcon(FontAwesomeIcons.photoVideo, color: Colors.white60),
            )),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white, //Color.fromRGBO(55, 57, 84, 1.0),
          primaryColor: Colors.orange,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, size: 20.0),
              title: Text('Notificaciones')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 20.0), title: Text('Mapa')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 20.0),
              title: Text('Multimedia')),
        ],
      ),
    );
  }

  Widget _botonesRedondeados() {
    return Wrap(
      children: <Widget>[
        _crearBotonRedondeado(
            Colors.blue, Icons.border_all, 'Pedir ayuda', '1'),
        _crearBotonRedondeado(
            Colors.purpleAccent, Icons.directions_bus, 'Urgencias', '2'),
        _crearBotonRedondeado(
            Colors.pinkAccent, Icons.shop, 'Ayuda a un amig@', '3'),
        _crearBotonRedondeado(
            Colors.orange, Icons.insert_drive_file, 'Eventos', '4'),
        _crearBotonRedondeado(
            Colors.blueAccent, Icons.movie_filter, 'Voluntarios', '5'),
        _crearBotonRedondeado(Colors.green, Icons.cloud, 'Instituciones', '6'),
      ],
    );
  }

  Widget _crearBotonRedondeado(
      Color color, IconData icono, String texto, String valor) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CitizenListInstitucionModule()),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 100.0,
            width: 150,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white24, //Color.fromRGBO(62, 66, 107, 0.7),
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0),
                CircleAvatar(
                  backgroundColor: color,
                  radius: 35.0,
                  child: Icon(icono, color: Colors.white, size: 30.0),
                ),
                Text(texto, style: TextStyle(color: Colors.white)),

                // SizedBox( height: 5.0 )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerCitizen extends StatelessWidget {
  // const DrawerCitizen({Key key}) : super(key: key);
  final prefs = new PreferensUser();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: boxDecoration(),
          child: Container(
              child: Column(
            children: <Widget>[
              Material(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageOvalNetwork(
                        imageNetworkUrl: prefs.avatarImagen,
                        sizeImage: Size.fromWidth(70)),
                  )),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      prefs.nombreUsuario,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Text(
                      prefs.correoElectronico,
                      style: TextStyle(color: Colors.black87, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
        CustomListTile(
            Icons.home,
            'Inicio',
            () => //openWeb('http://mapacovid19.ruta88.net/'),
                //sharedImage('assets/image/twitter.jpg','twitter','twitter.jpg','jpg','imagen de apoyo JPG'),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageModule()),
                )),
        CustomListTile(
            Icons.notification_important,
            'Notificaciones',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenListInstitucionModule()),
                )),
        CustomListTile(
            Icons.business,
            'Conoce las instituciones',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenListInstitucionModule()),
                )),
        CustomListTile(
            Icons.perm_phone_msg,
            'Solicita una consulta',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoundVoluntaryModule()),
                )),
        CustomListTile(
            Icons.hotel,
            'Pide ayuda urgente',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenPanicButtonModule()),
                )),
        CustomListTile(
            Icons.accessible_forward,
            'Ayuda a un amigo(a)',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HelpFriendAllModule()),
                )),
        CustomListTile(
            Icons.event_available,
            'Eventos vigentes',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenEventsModule()),
                )),
        CustomListTile(
            Icons.play_circle_outline,
            'Ver Multimedia',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenMultimediaModule()),
                )),
        CustomListTile(
            Icons.person_add,
            'Inscribete como voluntario',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryAllModule()),
                )),
        CustomListTile(
            Icons.bubble_chart,
            'Acerca de Lucia Te Cuida',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IntroScreenModule()),
                )),
        CustomListTile(
            Icons.add_comment,
            'Atiende las solicitudes',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenEmergencyModule()),
                )),
        CustomListTile(
          Icons.map,
          'Mapa de solicitudes',
          () => openWeb('http://mapacovid19.ruta88.net/'),
          // Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => MapAdressModule()),
          //     )
        ),
        CustomListTile(
            Icons.edit_location,
            'Registra tu Institución',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EntityAllModule()),
                )),
        CustomListTile(
            Icons.event_available,
            'Crear Eventos-Entidades',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventAllModule()),
                )),
        CustomListTile(
            Icons.event_note,
            'Crear Eventos-Voluntarios',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventVoluntaryAllModule()),
                )),
        CustomListTile(
            Icons.image,
            'Cargar Multimedia',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultimediaAllModule()),
                )),
        CustomListTile(
            Icons.airline_seat_individual_suite,
            'Registrar Atención médica',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AtentionCitizenAllModule()),
                )),
        CustomListTile(
            Icons.exit_to_app,
            'Salir',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpModule()),
                )),
      ],
    ));
  }
}
