import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class ListEntityModule extends StatefulWidget {
  static final String routeName = 'listaEntidad';
  ListEntityModule({Key key}) : super(key: key);

  @override
  _ListEntityModuleState createState() => _ListEntityModuleState();
}

class _ListEntityModuleState extends State<ListEntityModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ListEntityModule.routeName;
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
            new Institucion(), urlGetInstitucion, primaryKeyGetInsitucion),
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
          Institucion entityItem = snapshot.data[index];

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
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Institucion entityItem) {
    final item = entityItem.idInstitucion;

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
          final dataMap = generic.add(new RegistroAmigo(),
              '$urlDeleteInstitucion${item.toString()}/${prefs.userId}');

          dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
          print('resultado:$result');
        });

        if (result != null || result != '-1')
          Scaffold.of(context)
              .showSnackBar(messageOk("Se elimino el registro."));
        else
          Scaffold.of(context).showSnackBar(
              messageNOk("Se  produjo un error. Vuelva a intentarlo."));
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
                      Text('Nombre: ${entityItem.nombreInstitucion} ',
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
                  Text('Departamento: ${entityItem.desUbicacion}',
                      style: TextStyle(color: Colors.red, fontSize: 14))
                ],
              ),
              Container(
                  child: Text(
                'Telefono: ${entityItem.telefono}',
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
                    'Ubicacion: ${entityItem.desUbicacion}',
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
                      callNumber(int.parse(entityItem.telefono));
                    },
                  ),
                  SizedBox(width: 20.0),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.comment,
                      color: Colors.blue,
                      size: 25,
                    ),
                    onTap: () {
                      sendSMS(int.parse(entityItem.telefono));
                    },
                  ),
                  SizedBox(width: 20.0),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.mailBulk,
                      color: Colors.blue,
                      size: 25,
                    ),
                    onTap: () {
                      sendEmailAdvanced(
                          entityItem.perCorreoElectronico,
                          "Colaboración ${entityItem.desInsitucion}",
                          "Estimad@:  ${entityItem.nombreInstitucion}, favor su colaboración en: ");
                    },
                  ),
                  SizedBox(width: 20.0),
                  InkWell(
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.blue,
                      size: 25,
                    ),
                    onTap: () {
                      callWhatsApp(int.parse(entityItem.telefono));
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

  Container iconEntity(Institucion entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: entityItem.foto, sizeImage: Size.fromWidth(40)),
        Text(
          '${entityItem.telefono}',
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
