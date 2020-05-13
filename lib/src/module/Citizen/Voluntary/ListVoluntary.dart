import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';


import 'dart:async';

import 'package:flutter/services.dart';



class ListVoluntaryModule extends StatefulWidget {
  const ListVoluntaryModule({
    Key key,
  }) : super(key: key);

  @override
  _ListVoluntaryModuleState createState() => _ListVoluntaryModuleState();
}

class _ListVoluntaryModuleState extends State<ListVoluntaryModule> {
final generic = new Generic();
  int _currentIndex = 0;
  var result;
  String _platformVersion = 'Unknown';

 @override
  void initState() {
    super.initState();
    initPlatformState();
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
  

    void whatsAppOpen() async {
  //     print("000");
  //  // bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

  //   if (whatsapp) {
  //     print("111");
  //    // await FlutterLaunch.launchWathsApp(phone: "+59176427275", message: "bola gilll");
  //     print("222");
  //   } else {
  //     print("333");
  //     print("Whatsapp não instalado");
  //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LISTA DE VOLUNTARIOS"),
          backgroundColor: Colors.orange,
     
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Busca a un voluntario",
                  ),
                ),
              ),
            ),
            // colcoamos las cajas de instituciones
            Divider(color: Colors.orange, thickness: 1.0),
            futureItemsEntity(context)
          ],
        ),
        drawer: DrawerCitizen(),
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
            new Voluntary(), urlGetVoluntario, primaryKeyGetVoluntario),
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
         //     border: BoxBorder.,
        //  borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(0.0, 5.0),
              spreadRadius: 7.0)
        ],
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(254, 253, 252, 1.0),
        Color.fromRGBO(255, 205, 90, 3.0),
        Color.fromRGBO(243, 174, 61, 1.0),
      //  Color.fromRGBO(243, 223, 18, 1.0)
      ])),
            child: ListTile(
              leading: iconEntity(entityItem),
              title: listEntity(context, entityItem),
              trailing:  FaIcon(FontAwesomeIcons.phoneVolume, color: Colors.black, size: 35,),
               onTap: () { 

                 whatsAppOpen();

               }
               //{ FlutterOpenWhatsapp.sendSingleMessage("59176427275", "bruto oooo");
              //  print('Running on: $_platformVersion');}
              
              //callWhatsApp(59176427275),
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
           Scaffold.of(context).showSnackBar(messageOk("Registro eliminado."));
        else
          Scaffold.of(context).showSnackBar(messageNOk("Se produjo un error, vuelva a intentarlo."));
      },

      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width - 160,
                  child: Text('${entityItem.perNombrepersonal} ',
                      style: TextStyle(color: Colors.black45, fontSize: 14))),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: Colors.black54,
                    size: 15,
                  ),
                  Text(
                    'Grupo: ${entityItem.idcovInstitucion}',
                  )
                ],
              ),
              Container(
                  child: Text(
                'Especialidad: ${entityItem.idaTipopersonal}',
                style: TextStyle(color: Colors.black45, fontSize: 14),
              )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: Colors.black54,
                    size: 15,
                  ),
                  Text(
                    'Correo: ${entityItem.perCorreo}',
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
       
           FaIcon(FontAwesomeIcons.userTie, color: Colors.black, size: 35,),
          
 

        Text(
          '${entityItem.perCI}',
          style: TextStyle(
              fontSize: 11,
              color: Colors.black,
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