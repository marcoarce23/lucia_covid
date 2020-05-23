import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';
import 'FoundAllVoluntaryModule.dart';
import 'package:lucia_covid/src/Util/SearchDelegate/DataSearch.dart';

class FoundVoluntaryModule extends StatefulWidget {
  static final String routeName = 'EncuentraVoluntario';
  @override
  _FoundVoluntaryModuleState createState() => _FoundVoluntaryModuleState();
}

class _FoundVoluntaryModuleState extends State<FoundVoluntaryModule> {
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = FoundVoluntaryModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.themeVino,
            toolbarOpacity: 0.7,
            iconTheme:
                IconThemeData(color: AppTheme.themeColorBlanco, size: 12),
            elevation: 0,
            title: Text("Encuentra un voluntario", style: kTitleAppBar),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: DataSearchEncuentraUnAmigo());
                },
              )
            ],
          ),
          drawer: DrawerCitizen(),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                contenedorTitulo(
                  context,
                  40.0,
                  "Voluntarios".toUpperCase(),
                  FaIcon(FontAwesomeIcons.peopleCarry, color: Colors.white60),
                ),
                SizedBox(
                  height: 15,
                ),
                futureCuerpoProfesionales(context),
              ],
            ),
          )) //CollapsingList(),

          //ejemploNoticias(),
          ),
    );
  }

  Widget futureCuerpoProfesionales(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(new ProfesionalesAgrupados(),
            urlGetTodosGruposProfesionales, primaryKeyTodosGruposProfesionales),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return cuerpoProfesionales(context, snapshot);
          }
        });
  }

  Widget cuerpoProfesionales(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> lista = new List<Widget>();
    for (var i = 0; i < snapshot.data.length; i++) {
      ProfesionalesAgrupados listaProfesionales = snapshot.data[i];
      lista.add(tarjetaProfessional(context, listaProfesionales));
    }
    return Wrap(
      children: lista,
    );
  }

  Widget tarjetaProfessional(
      BuildContext context, ProfesionalesAgrupados profesional) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          if (profesional.cantidadProfesionales > 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoundAllVoluntaryModule(
                        profesional: profesional,
                      )),
            );
          } else {
            Scaffold.of(context).showSnackBar(messageHelp(
                "Aun no cuenta con miembros en el grupo de ${profesional.profesion}"));
          }
        },
        child: Container(
          height: 150,
          width: 150,
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  ImageOpaqueNetworkCustomize(
                    profesional.imagenFondo,
                    Colors.white,
                    Size(150, 150),
                    0.5,
                    BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          profesional.profesion,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Text(
                          "Contamos con " +
                              profesional.cantidadProfesionales.toString() +
                              " profesionales",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
