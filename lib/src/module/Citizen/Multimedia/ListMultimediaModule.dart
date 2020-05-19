import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/SearchDelegate/DataSearch.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class ListMultimediaModule extends StatefulWidget {
    static final String routeName = 'lisMultimedia';
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
    return Scaffold(
        appBar: AppBar(
          title: Text("IMAGENES MULTIMEDIA"),
          backgroundColor: Color.fromRGBO(22, 23, 22 , 0.4),
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {  
               showSearch(context: context, delegate: DataSearchMultimedia()  );
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
    );
  }

 

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll( new Multimedia(), urlGetMultimedia, primaryKeyGetMultimedia),
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
          Multimedia entityItem = snapshot.data[index];

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
                    color: Colors.green,
                    size: 15,
                  ),
                      Text('Material: ${entityItem.mulTitulo} ',
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
                    'Resumen: ${entityItem.mulResumen}',
                    style: TextStyle(color: Colors.red, fontSize: 14)
                  )
                ],
              ),
              Container(
                  child: Text(
                'Categoria: ${entityItem.idaCategoria}',
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
                    'Tipo Material: ${entityItem.idaTIpoMaterial}',
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

  Container iconEntity(Multimedia entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        Icon(
          Icons.person_pin,
          size: 35,
          color: Colors.yellow,
        ),
        Text(
          '${entityItem.idaTIpoMaterial}',
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
