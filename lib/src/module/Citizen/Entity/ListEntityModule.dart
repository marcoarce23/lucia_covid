import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
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
  int _currentIndex = 0;
  var result;

 @override
  void initState() {
    prefs.ultimaPagina = ListEntityModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("INSTITUCIONES"),
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
                    hintText: "Busca una institución",
                  ),
                ),
              ),
            ),
            // colcoamos las cajas de instituciones
            Divider(color: Colors.orange, thickness: 1.0),
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
              callPageInstitucion(_currentIndex, context);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Institucion')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Atención')),
           BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Instituciones')),
        ],
      ),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(new Institucion(), urlGetInstitucion, primaryKeyGetInsitucion),
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
          Institucion entityItem = snapshot.data[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListEntityModule(),
                  ));
            },
            child: Card(
                elevation: 2,
                //margin:                      const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 7.0,
                              offset: Offset(0.0, 5.0),
                              spreadRadius: 7.0)
                        ]),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 30,
                    height: 90,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        iconEntity(entityItem),
                        dividerLine(),
                        listEntity(context, entityItem),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, Institucion entityItem) {
    final item = entityItem.direccion;

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
          generic.add(new RegistroAmigo(),'$urlDeleteVoluntario${item.toString()}/marcoarce23');
          final dataMap = generic.add(entityItem, '$urlDeleteVoluntario${item.toString()}/marcoarce23');
     
     dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');


        });

        if(result != null || result != '-1')
            Scaffold.of(context).showSnackBar( new SnackBar(content: new Text('Registro eliminado')));
        else
        Scaffold.of(context).showSnackBar( new SnackBar(content: new Text('Problemas al eliminar el registro!!!')));

      },

      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width - 160,
                  child: Text('${entityItem.nombreInstitucion} ',
                      style: TextStyle(color: Colors.black45, fontSize: 14))),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: Colors.black54,
                    size: 15,
                  ),
                  Text(
                    'Telefono: ${entityItem.telefono}',
                  )
                ],
              ),
              Container(
                  child: Text(
                'Correo: ${entityItem.perCorreoElectronico}',
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
                    'Ubicación: ${entityItem.desUbicacion}',
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
        Icon(
          Icons.person_pin,
          size: 35,
          color: AppTheme.themeColorNaranja,
        ),
        Text(
          '${entityItem.desInsitucion}',
          style: TextStyle(
              fontSize: 11,
              color: AppTheme.themeColorNaranja,
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
