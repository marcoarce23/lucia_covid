import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/ListEntity.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';

import 'FoundAllVoluntaryModule.dart';

class FoundVoluntaryModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme:
                IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
            elevation: 0,
            title: Text(
              "Encuetra un voluntario",
              style: TextStyle(
                  color: AppTheme.themeColorNaranja,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            //backgroundColor: AppTheme.themeColorNaranja,
          ),
          drawer: DrawerCitizen(),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.themeColorNaranja,
                    ),
                    hintText: "Buscar por categoria al voluntario",
                    hintStyle: TextStyle(
                        fontSize: 12, color: AppTheme.themeColorNaranja),
                  ),
                ),
                Text(
                  "Listado de categorias de los voluntarios",
                  style: AppTheme.themeTitulo,
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
        future: /*generic.getAll(new Hospital())*/ getListaProfesionalesAgrupadosInstitucion(),
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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoundAllVoluntaryModule(
                      profesional: profesional,
                    )),
          );
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
                  GestureDetector(
                    child: Hero(
                      tag: profesional.imagenFondo,
                      child: ImageOpaqueAssets(
                          profesional.imagenFondo,
                          Colors.white,
                          Size(double.maxFinite, double.maxFinite),
                          0.50),
                    ),
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
