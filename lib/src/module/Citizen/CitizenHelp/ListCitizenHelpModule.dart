import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/ListEntity.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenInstitution/CitizenInstitutionModule.dart';

import 'package:lucia_covid/src/Theme/ThemeModule.dart';

class ListCitizenHelpModule extends StatefulWidget {
  @override
  _ListCitizenHelpModuleState createState() => _ListCitizenHelpModuleState();
}

class _ListCitizenHelpModuleState extends State<ListCitizenHelpModule> {
final generic = new Generic();
 int _currentIndex =0; 

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Ayuda a un amig@"),
      ),
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Ayuda a un amig@")),
          ),
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Buscar",
                ),
              ),
            ),
          ),
          // colcoamos las cajas de instituciones
          Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Resultados",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400))),
          ),
          futureItemsInstitution(context)
        ],
      ),
       bottomNavigationBar: _bottomNavigationBar(context)
    );
  }
  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Colors.blueGrey))),
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
              icon: Icon(Icons.person, size: 25.0), title: Text('Colabora')),
        
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Listado solicitudes')),
         ],
      ),
    );
  }

  Widget futureItemsInstitution(BuildContext context) {
    return FutureBuilder(
        future: getInstitucionesItems(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return listItemsInstitution(context, snapshot);
          }
        });
  }

  Widget listItemsInstitution(BuildContext context, AsyncSnapshot snapshot) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          InstitucionesItems institutionItem = snapshot.data[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CitizenInstitutionModule(
                          institutionItem: institutionItem,
                        )),
              );
            },
            child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                //margin:                      const EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 30,
                    height: 85,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        iconInstitution(institutionItem),
                        dividerLine(),
                        listInstitution(context, institutionItem),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget listInstitution(
      BuildContext context, InstitucionesItems institutionItem) {
    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width - 260,
                child: Text(institutionItem.nombreInstitucion)),
            Row(
              children: <Widget>[
                Icon(
                  Icons.place,
                  color: Colors.black54,
                  size: 15,
                ),
                Text(institutionItem.ubicacion),
              ],
            ),
            Container(
                child: Text(
              " 53 miembreos ",
              style: TextStyle(color: Colors.black45, fontSize: 12),
            )),
            tieneCovid(institutionItem),
          ],
        ),
      ],
    );
  }

  Text tieneCovid(InstitucionesItems institutionItem) {
    String respuesta;

    if (institutionItem.ayudaConCovid == "0") {
      respuesta = "";
    } else {
      var formatter = new DateFormat('dd/MM/yyyy');
      respuesta =
          "Ayuda COVID-19 desde ${formatter.format(institutionItem.fechaConCovid)}";
    }

    return Text(
      respuesta,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
    );
  }

  Container iconInstitution(InstitucionesItems institutionItem) {
    return Container(
        child: Column(
      children: <Widget>[
        Icon(
          Icons.business,
          size: 30,
          color: AppTheme.themeColorNaranja,
        ),
        Text(
          institutionItem.tipoInstitucion,
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
