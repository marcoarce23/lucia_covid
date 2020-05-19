import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class ListCitizenHelpModule extends StatefulWidget {
  static final String routeName = 'ListaCiudadanoAyuda';
  @override
  _ListCitizenHelpModuleState createState() => _ListCitizenHelpModuleState();
}

class _ListCitizenHelpModuleState extends State<ListCitizenHelpModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ListCitizenHelpModule.routeName;
    super.initState();
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
            new RegistroAmigo(), urlGetDevuelveAyuda, primaryKeyGetAyudaAmigo),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
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
          RegistroAmigo entityItem = snapshot.data[index];

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

  Widget listEntity(BuildContext context, RegistroAmigo entityItem) {
    final item = entityItem.idcovRegistroAmigo;

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
           generic.add(new RegistroAmigo(), '$urlDeleteVoluntario${item.toString()}/${prefs.idPersonal}');
          final dataMap = generic.add(new RegistroAmigo(), '$urlDeleteVoluntario${item.toString()}/${prefs.idPersonal}');

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
                      Text('Persona: ${entityItem.regPersona} ',
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
                  Text('Prioridad: ${entityItem.regPrioridad}',
                      style: TextStyle(color: Colors.red, fontSize: 14))
                ],
              ),
              Container(
                  child: Text(
                'Telefono: ${entityItem.regTelefono}',
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
                    'Ubicacion: ${entityItem.regUbicacion}',
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

  Container iconEntity(RegistroAmigo entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: prefs.avatarImagen, sizeImage: Size.fromWidth(40)),
        Text(
          '${entityItem.regPrioridad}',
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
