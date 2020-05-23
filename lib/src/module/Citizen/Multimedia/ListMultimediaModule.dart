import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class ListMultimediaModule extends StatefulWidget {
  static final String routeName = 'listMultimedia';
  const ListMultimediaModule({
    Key key,
  }) : super(key: key);

  @override
  _ListMultimediaModuleState createState() => _ListMultimediaModuleState();
}

class _ListMultimediaModuleState extends State<ListMultimediaModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ListMultimediaModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            width: size.width * 0.96,
            margin: EdgeInsets.symmetric(vertical: 0.0),
            child: contenedorTitulo(
              context,
              40.0,
              'LISTADO MATERIAL MULTIMEDIA',
              FaIcon(FontAwesomeIcons.photoVideo, color: Colors.white60),
            ),
          ),
          divider(),
          futureItemsEntity(context),
          copyRigth(),
        ],
      ),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new Multimedia(), urlGetMultimedia + '74', primaryKeyGetMultimedia),
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
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          Multimedia entityItem = snapshot.data[index];

          return Column(
            children: <Widget>[
              Container(
                width: size.width * 0.97,
                margin: EdgeInsets.symmetric(vertical: 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 7.0,
                          offset: Offset(2.0, 3.0),
                          spreadRadius: 4.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: iconEntity(entityItem),
                      title: listEntity(context, entityItem),
     
                    ),
                  ],
                ),
              ),
           //   divider(),
            ],
          );
        },
      ),
    );
  }
  Widget listEntity(BuildContext context, Multimedia entityItem) {
    final item = entityItem.idcovMultimedia;

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
          generic.add(new Multimedia(),
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
                        color: AppTheme.themeVino,
                        size: 15,
                      ),
                      Text('Material: ${entityItem.mulTitulo} ',
                          style: kSubTitleCardStyle),
                    ],
                  )),
                  SizedBox(height:5.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text('Resumen: ${entityItem.mulResumen}',
                      style:kSubTitleCardStyle)
                ],
              ),
              SizedBox(height:5.0),
              Container(
                  child: Text(
                'inicio: ${entityItem.detFechaInicio} - Conclusión: ${entityItem.detFechaFin}',
                style: kSubTitleCardStyle,
              )),
            ],
          ),
        ],
      ),

      
    );
  }

  Container iconEntity(Multimedia entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: entityItem.mulEnlace,
            sizeImage: Size.fromWidth(40)),
            SizedBox(height:3.0),
        Text(
          '${entityItem.tipoMaterial}',
          style: TextStyle(
              fontSize: 11, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }


}
