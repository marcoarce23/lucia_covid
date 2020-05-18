import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/SearchDelegate/DataSearch.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class ListCitizenHelpModule extends StatefulWidget {
  static final String routeName = 'ListaCiudadanoAyuda';
  @override
  _ListCitizenHelpModuleState createState() => _ListCitizenHelpModuleState();
}

class _ListCitizenHelpModuleState extends State<ListCitizenHelpModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  int _currentIndex = 0;
  var result;

  @override
  void initState() {
    prefs.ultimaPagina = ListCitizenHelpModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AYUDA A UN AMIGO"),
          backgroundColor: Color.fromRGBO(22, 23, 22 , 0.4),
          actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {  
               showSearch(context: context, delegate: DataSearchHelp()  );
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
            callHelp(_currentIndex, context);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Ayudalo')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Solicitudes')),
        ],
      ),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    

    return FutureBuilder(
        future: generic.getAll(
            new RegistroAmigo(), urlGetVoluntario, primaryKeyGetVoluntario),
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
