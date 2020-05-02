import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenAtentionRegisterModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenHelpModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenInfoModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHome/CitizenHomeModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenInstitution/CitizenListInstitucionModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenMultimedia/CitizenMultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenPanicButton/CitizenPanicButtonModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenTestCovid/CitizenTestCovidModule.dart';
import 'package:lucia_covid/src/module/Entity/EntityModule.dart';
import 'package:lucia_covid/src/module/Multimedia/MultimediaModule.dart';

import 'package:lucia_covid/src/module/Voluntary/VoluntaryModule.dart';


class CitizenLayoutMenuModule extends StatefulWidget {
  @override
  _CitizenLayoutMenuModuleState createState() =>
      _CitizenLayoutMenuModuleState();
}

class _CitizenLayoutMenuModuleState extends State<CitizenLayoutMenuModule> {

  @override
  void initState() {
    /*
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Inicio',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenHomeModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Consulta a un Voluntario',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenListInstitucionModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Eventos',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenListInstitucionModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Material Multimedia',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenListInstitucionModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Botón de ayuda',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenPanicButtonModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Ayuda a un amig@',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenHelpModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Test Covid',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenTestCovidModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Mapa de ayuda',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenTestCovidModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: '-- ADMINSITRACIÓN --',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenTestCovidModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Institucion',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        EntityModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Voluntario',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        VoluntaryModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Imágenes Multimedia',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenInfoModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Atencion médica',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenAtentionRegisterModule()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Administración',
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18.0),
          colorLineSelected: Colors.white,
        ),
        CitizenTestCovidModule()));
*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Post COVID-19"),
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
          UserAccountsDrawerHeader(
            accountName:
                Container(color: Colors.white, child: Text("hola mundo")),
            accountEmail:
                Container(color: Colors.white, child: Text("hola@mundo")),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text("CA"),
            ),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: ExactAssetImage(
                      'assets/image/COVID-19.png',
                    ),
                    fit: BoxFit.cover)),
          ),
    
          // ListTile(
          //   title: Text('Inicio'),
          //   trailing: Icon(Icons.keyboard_arrow_right),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => CitizenHomeModule()),
          //     );
          //   },
          // ),
 ListTile(
            title: Text('Visita las institucion'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitizenListInstitucionModule()),
              );
            },
          ),

          Divider(color: Colors.black, thickness: 1.0,),

          ListTile(
            title: Text('Encuentra a un voluntario'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitizenHomeModule()),
              );
            },
          ),
          ListTile(
            title: Text('Eventos de las insituciones'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitizenHomeModule()),
              );
            },
          ),
          ListTile(
            title: Text('Material Multimedia'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitizenMultimediaModule()),
              );
            },
          ),
          ListTile(
            title: Text('Botón de ayuda'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CitizenPanicButtonModule()),
              );
            },
          ),
          ListTile(
            title: Text('Ayuda a un amig@'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitizenHelpModule()),
              );
            },
          ),
          // ListTile(
          //   title: Text('Test Covid'),
          //   trailing: Icon(Icons.keyboard_arrow_right),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => CitizenTestCovidModule()),
          //     );
          //   },
          // ),
          ListTile(
            title: Text('Mapa de ayuda'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitizenHomeModule()),
              );
            },
          ),
          Divider(color: Colors.black, thickness: 1.0,),
         
         ListTile(
            title: Text('Entidades'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EntityModule()),
              );
            },
          ),

          ListTile(
            title: Text('Voluntario'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VoluntaryModule()),
              );
            },  
          ),
          ListTile(
            title: Text('Imágenes Multimedia'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MultimediaModule()),
              );
            },
          ),
          ListTile(
            title: Text('Atención médica'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CitizenAtentionRegisterModule()),
              );
            },
          ),
          ListTile(
            title: Text('Administración'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CitizenTestCovidModule()),
              );
            },
          ),
          Divider(),

/*
          ListTile(
            leading: CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/LuciaAvatar.png'),
              ),
            ),
            title: Text("Lucia te cuida"),
            subtitle: Text("  "),
          ),
          ListTile(leading: Icon(Icons.home), title: Text("Home")),
          ListTile(leading: Icon(Icons.grid_on), title: Text("Products")),
          ListTile(leading: Icon(Icons.contacts), title: Text("Contact Us")),
          */
        ],
      ));
  }
}