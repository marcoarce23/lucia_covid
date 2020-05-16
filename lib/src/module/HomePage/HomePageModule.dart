import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
<<<<<<< refs/remotes/origin/developer
=======
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
>>>>>>> 15/05/2020 22:45 busquedas
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
import 'package:lucia_covid/src/module/Map/MapAdressModule.dart';
import 'package:lucia_covid/src/module/Settings/ConfigurationModule.dart';
import 'package:lucia_covid/src/module/UtilModule/PageViewModule.dart';

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
          title: Row(
            children: <Widget>[
              Text("LUCIA TE CUIDA."),
              SizedBox(width: 10.0),
              FaIcon(
                FontAwesomeIcons.keybase,
                color: Colors.black,
                size: 18,
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            _fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[_titulos(), _botonesRedondeados()],
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
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
             Color.fromRGBO(243, 124, 18, 1.0),
        Color.fromRGBO(255, 209, 18, 3.0),
        Color.fromRGBO(243, 156, 18, 1.0),
        Color.fromRGBO(243, 223, 18, 1.0)
          ])),
    );

    final cajaRosa = Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
          height: 360.0,
          width: 360.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(134, 179, 247, 1.0),
                Color.fromRGBO(78, 103, 205, 1.0)
              ])),
        ));

    return Stack(
      children: <Widget>[gradiente, Positioned(top: -100.0, child: cajaRosa)],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Estamos contigo para ayudarte',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            //    SizedBox( height: 5.0 ),
            //   Text('Puedes hacer consultar y pedir ayuda de forma directa', style: TextStyle( color: Colors.white, fontSize: 18.0 )),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,//Color.fromRGBO(55, 57, 84, 1.0),
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
              title: Text('Materiales')),
        ],
      ),
    );
  }

  Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(Colors.blue, Icons.border_all, 'Pedir ayuda'),
          _crearBotonRedondeado(
              Colors.purpleAccent, Icons.directions_bus, 'Ayuda a un amigo'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.pinkAccent, Icons.shop, 'Eventos'),
          _crearBotonRedondeado(
              Colors.orange, Icons.insert_drive_file, 'Material MUltimedia'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              Colors.blueAccent, Icons.movie_filter, 'Voluntarios'),
          _crearBotonRedondeado(Colors.green, Icons.cloud, 'Intituciones'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.red, Icons.collections, 'Mapas'),
          _crearBotonRedondeado(Colors.teal, Icons.help_outline, 'Pánico'),
        ])
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 100.0,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white54, //Color.fromRGBO(62, 66, 107, 0.7),
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
              
              InkWell(
                            splashColor: AppTheme
                                .backGroundInstitutionPrimary, // inkwell color
                            child: Text(texto, style: TextStyle(color: color)),
                            onTap: () {                          
                            openWeb("http://mapacovid19.ruta88.net/");
                            }
              ),
              // SizedBox( height: 5.0 )
            ],
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.deepOrange, Colors.orangeAccent])),
          child: Container(
              child: Column(
            children: <Widget>[
              Material(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageOvalNetwork(
                          imageNetworkUrl:
                              prefs.avatarImagen,
                          sizeImage: Size.fromWidth(70)),
                  )),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      prefs.nombreUsuario,
                      style: TextStyle(color: Colors.black54, fontSize: 18.0),
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
            Icons.person_pin,
            'Perfil',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenListInstitucionModule()),
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
            'Visita las institucion',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenListInstitucionModule()),
                )),
        CustomListTile(
            Icons.person,
            'Encuentra a un voluntario',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoundVoluntaryModule()),
                )),
        CustomListTile(
            Icons.event_available,
            'Eventos de las instituciones',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenEventsModule()),
                )),
        CustomListTile(
            Icons.photo_size_select_actual,
            'Material Multimedia',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenMultimediaModule()),
                )),
        CustomListTile(
            Icons.hotel,
            'Solicita una ayuda',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenPanicButtonModule()),
                )),
        CustomListTile(
            Icons.hotel,
            'Asistencia de ayuda',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenEmergencyModule()),
                )),
        CustomListTile(
            Icons.accessibility,
            'Ayuda a un amig@',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CitizenHelpModule()),
                )),
        CustomListTile(
            Icons.map,
            'Solicitud de ayuda',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapAdressModule()),
                )),
        CustomListTile(
            Icons.edit_location,
            'Registro Entidades',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EntityModule()),
                )),
        CustomListTile(
            Icons.edit_location,
            'Eventos de Entidades',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventEntityModule()),
                )),
        CustomListTile(
            Icons.edit_location,
            'Registo voluntario',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryModule()),
                )),
        CustomListTile(
            Icons.person_add,
            'Eventos Voluntarios',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventModule()),
                )),
        CustomListTile(
            Icons.add_photo_alternate,
            'Imágenes Multimedia',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MultimediaModule()),
                )),
        CustomListTile(
            Icons.airline_seat_individual_suite,
            'Atención médica',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenAtentionRegisterModule()),
                )),
        CustomListTile(
            Icons.settings,
            'Configuración',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfigurationModule()),
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
