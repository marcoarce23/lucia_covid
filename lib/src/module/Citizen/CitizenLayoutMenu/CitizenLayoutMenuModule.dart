import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenEvents/CitizenEventsModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenAtentionRegisterModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenHelpModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHome/CitizenHomeModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenInstitution/CitizenListInstitucionModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenMultimedia/CitizenMultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenPanicButton/CitizenPanicButtonModule.dart';
import 'package:lucia_covid/src/module/Entity/EntityModule.dart';
import 'package:lucia_covid/src/module/Map/MapModule.dart';
import 'package:lucia_covid/src/module/Multimedia/MultimediaModule.dart';
import 'package:lucia_covid/src/module/Voluntary/FoundVoluntaryModule.dart';

import 'package:lucia_covid/src/module/Voluntary/VoluntaryModule.dart';

class CitizenLayoutMenuModule extends StatefulWidget {
  @override
  _CitizenLayoutMenuModuleState createState() =>
      _CitizenLayoutMenuModuleState();
}

class _CitizenLayoutMenuModuleState extends State<CitizenLayoutMenuModule> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("LUCIA TE CUIDA."),
          backgroundColor: AppTheme.themeColorNaranja),
      drawer: DrawerCitizen(),
    );
  }
}

class DrawerCitizen extends StatelessWidget {
  const DrawerCitizen({Key key}) : super(key: key);

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
                    child: Image.asset(
                      'assets/image/COVID-19.png',
                      width: 70,
                      height: 70,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Marco Antonio Arce Valdivia',
                      style: TextStyle(color: Colors.black54, fontSize: 18.0),
                    ),
                    Text(
                      'marcoarce23@gmail.com',
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
                  MaterialPageRoute(builder: (context) => FoundVoluntaryModule()),
                )),
        CustomListTile(
            Icons.event_available,
            'Eventos de las instituciones',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CitizenEventsModule()),
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
                  MaterialPageRoute(builder: (context) => MapModule()),
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
                  MaterialPageRoute(builder: (context) => EntityModule()),
                )),
        CustomListTile(
            Icons.edit_location,
            'Registo voluntario',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EntityModule()),
                )),
        CustomListTile(
            Icons.person_add,
            'Eventos Voluntarios',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryModule()),
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
                      builder: (context) => CitizenAtentionRegisterModule()),
                )),
        CustomListTile(
            Icons.exit_to_app,
            'Salir',
            () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenAtentionRegisterModule()),
                )),
      ],
    ));
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: InkWell(
          splashColor: Colors.orange,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Icon(icon),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ]),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
