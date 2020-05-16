import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/SearchDelegate/DataSearch.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'CitizenInstitutionModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class CitizenListInstitucionModule extends StatefulWidget {
  static final String routeName = 'ListaInstituciones';
  @override
  _CitizenListInstitucionModuleState createState() =>
      _CitizenListInstitucionModuleState();
}

class _CitizenListInstitucionModuleState
    extends State<CitizenListInstitucionModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = CitizenListInstitucionModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
        elevation: 0,
        title: Text(
          "Instituciones",
          style: TextStyle(
              color: AppTheme.themeColorNaranja,
              fontSize: 17,
              fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearchInstituciones()  );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Lista de instituciones registradas.",
                    style: AppTheme.themeTitulo,
                  )),
            ),
            // colcoamos las cajas de instituciones
            Container(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Resultados",
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w400))),
            ),
            futureItemsInstitution(context)
          ],
        ),
      ),
    );
  }

  Widget futureItemsInstitution(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(new InstitucionesItems(),
            urlGetListaInstituciones, primaryKeyGetListaInstituciones),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              print(snapshot.data);
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
              if (institutionItem.miembros > 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CitizenInstitutionModule(
                            institutionItem: institutionItem,
                          )),
                );
              } else {
                Scaffold.of(context).showSnackBar(messageHelp(
                    "Aun no cuenta con miembros en ${institutionItem.nombreInstitucion}"));
              }
            },
            child: ListTile(
              leading: iconInstitution(institutionItem),
              title: listInstitution(context, institutionItem),
              trailing: Icon(Icons.arrow_right),
            ),
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
              "cuenta con ${institutionItem.miembros} miembros",
              style: TextStyle(color: Colors.black87, fontSize: 12),
            )),
            tieneCovid(institutionItem),
          ],
        ),
      ],
    );
  }

  Text tieneCovid(InstitucionesItems institutionItem) {
    String respuesta;

    if (institutionItem.idaAyudaCovid == 0) {
      respuesta = "";
    } else {
      respuesta = "Ayuda COVID-19 desde ${institutionItem.fechaConCovid}";
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
