import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/SearchDelegate/DataSearch.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';


import 'dart:async';

import 'package:flutter/services.dart';



class ListVoluntaryModule extends StatefulWidget {
  static final String routeName = 'lisVoluntary';
  const ListVoluntaryModule({
    Key key,
  }) : super(key: key);

  @override
  _ListVoluntaryModuleState createState() => _ListVoluntaryModuleState();
}

class _ListVoluntaryModuleState extends State<ListVoluntaryModule> {
final generic = new Generic();
final prefs = new PreferensUser();
  int _currentIndex = 0;
  var result;
  String _platformVersion = 'Unknown';

 @override
  void initState() {
    super.initState();
    initPlatformState();
    prefs.ultimaPagina = ListVoluntaryModule.routeName;
  }

Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      print('Running on: $_platformVersion');
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("VOLUNTARIOS"),
          backgroundColor: Color.fromRGBO(22, 23, 22 , 0.4),
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {  
               showSearch(context: context, delegate: DataSearchVoluntary()  );
            },
          )
        ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           SizedBox(height: 10.0),

            futureItemsEntity(context)
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context));
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
              icon: FaIcon(FontAwesomeIcons.userCircle, size: 25,),
              title: Text('Voluntario')),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendarCheck,size: 25, ),
              title: Text('Atención')),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.users, size: 25, ),
              title: Text('Integrantes')),
        ],
      ),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    

    return FutureBuilder(
        future: generic.getAll(
            new Evento(), urlGetEvento, primaryKeyGetEvento),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return listItemsEntity(context, snapshot);
          }
        });
  }

  Widget listItemsEntity(BuildContext context, AsyncSnapshot snapshot) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          Voluntary entityItem = snapshot.data[index];

          return Container(
            decoration: BoxDecoration(
        color:  Color.fromRGBO(22, 23, 22 , 0.9),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.yellow,
              blurRadius: 3.0,
              offset: Offset(5.0, 5.0),
              spreadRadius: 1.0)
        ]),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: iconEntity(entityItem),
                  title: listEntity(context, entityItem),
                  trailing: Icon(Icons.arrow_right),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Voluntary entityItem) {
    final item = entityItem.idcovPersonal;

    return Dismissible(
      key: Key(item.toString()), //UniqueKey(),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          'Eliminar registro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onDismissed: (value) {
        setState(() {
          //   items.
          //    print('El registro:$urlDeleteAyudaAmigo${item.toString()}/marcoarce23');
          generic.add(new RegistroAmigo(),
              '$urlDeleteVoluntario${item.toString()}/marcoarce23');
          final dataMap = generic.add(
              entityItem, '$urlDeleteVoluntario${item.toString()}/marcoarce23');

          dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
          print('resultado:$result');
        });

        if (result != null || result != '-1')
          Scaffold.of(context).showSnackBar(
              new SnackBar(content: new Text('Registro eliminado')));
        else
          Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text('Problemas al eliminar el registro!!!')));
      },

      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width - 160,
                  child: Row(
                    children: <Widget>[
                      Icon(
                    Icons.gamepad,
                    color: Colors.green,
                    size: 15,
                  ),
                      Text('Material: ${entityItem.perNombrepersonal} ',
                          style: TextStyle(color: Colors.red, fontSize: 14)),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: Colors.green,
                    size: 15,
                  ),
                  Text(
                    'Resumen: ${entityItem.idcovInstitucion}',
                    style: TextStyle(color: Colors.red, fontSize: 14)
                  )
                ],
              ),
              Container(
                  child: Text(
                'Tipo: ${entityItem.idaTipopersonal}',
                style: TextStyle(color: Colors.yellow, fontSize: 14),
              )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: Colors.green,
                    size: 15,
                  ),
                  Text(
                    'Fecha publicación: ${entityItem.perCorreo}',
                    style: TextStyle(color: Colors.yellow, fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container iconEntity(Voluntary entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        Icon(
          Icons.person_pin,
          size: 35,
          color: Colors.yellow,
        ),
        Text(
          '${entityItem.perCI}',
          style: TextStyle(
              fontSize: 11,
              color: Colors.yellow,
              fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }

  Container dividerLine() {
    return Container(
        height: 20, child: VerticalDivider(color: AppTheme.themeColorNaranja));
  }
}
