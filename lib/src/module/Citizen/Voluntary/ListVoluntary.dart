import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[SizedBox(height: 10.0), futureItemsEntity(context)],
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
                color: Color.fromRGBO(22, 23, 22, 0.9),
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

          //    print('El registro:$urlDeleteAyudaAmigo${item.toString()}/marcoarce23');

          final dataMap = generic.add(entityItem, '$urlDeleteVoluntario${item.toString()}/${prefs.idPersonal}');

          dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
          print('resultado:$result');
        });

       if (result != null || result != '-1')
          Scaffold.of(context)
          .showSnackBar(messageOk("Se elimino el registro."));
        else
          Scaffold.of(context)
          .showSnackBar(messageNOk("Se  produjo un error. Vuelva a intentarlo."));
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
                      Text('Voluntario: ${entityItem.perNombrepersonal} ',
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
                  Text('Telefono: ${entityItem.perTelefono}',
                      style: TextStyle(color: Colors.red, fontSize: 14))
                ],
              ),
              Container(
                  child: Text(
                'Tipo: ${entityItem.perAyudacovid}',
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
                    'Correo: ${entityItem.perCorreo}',
                    style: TextStyle(color: Colors.yellow, fontSize: 14),
                  )
                ],
              ),


               Wrap(
        children: <Widget>[
          InkWell(
            child: FaIcon(
              FontAwesomeIcons.phoneVolume,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {
              callNumber(int.parse(entityItem.perTelefono));
            },
          ),
         
          InkWell(
            child: FaIcon(
              FontAwesomeIcons.comment,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {
              sendSMS(int.parse(entityItem.perTelefono));
            },
          ),
         
          InkWell(
            child: FaIcon(
              FontAwesomeIcons.mailBulk,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {
              sendEmailAdvanced(
                  entityItem.perCorreo,
                  "Colaboración ${entityItem.desEspecialidad}",
                  "Estimad@:  ${entityItem.perNombrepersonal}, favor su colaboración en: ");
            },
          ),

          InkWell(
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {
              callWhatsApp(int.parse(entityItem.perTelefono));
            },
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
          '${entityItem.desEspecialidad}',
          style: TextStyle(
              fontSize: 11, color: Colors.yellow, fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }

  Container dividerLine() {
    return Container(
        height: 20, child: VerticalDivider(color: AppTheme.themeColorNaranja));
  }
}
