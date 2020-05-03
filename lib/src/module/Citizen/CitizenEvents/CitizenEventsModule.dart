import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/ListEntity.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'dart:math' as math;

import 'CitizenEventsDetailModule.dart';

String selectedCategorie = "Recomendaciones";

class CitizenEventsModule extends StatefulWidget {
  @override
  _CitizenEventsModuleState createState() => _CitizenEventsModuleState();
}

class _CitizenEventsModuleState extends State<CitizenEventsModule> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme:
                IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
            elevation: 0,
            title: Text(
              "Eventos",
              style: TextStyle(
                  color: AppTheme.themeColorNaranja,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            //backgroundColor: AppTheme.themeColorNaranja,
          ),
          drawer: DrawerCitizen(),
          body: SingleChildScrollView(
              child: listadoDeNoticias()) //CollapsingList(),

          //ejemploNoticias(),
          ),
    );
  }

  Widget listadoDeNoticias() {
    return Column(
      children: <Widget>[
        Padding(
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
                  hintText: "Buscar por institución / categoria",
                  hintStyle: TextStyle(
                      fontSize: 12, color: AppTheme.themeColorNaranja),
                ),
              ),
              Text(
                "Listado de eventos",
                style: AppTheme.themeTitulo,
              ),
              futureEvento(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget futureEvento(BuildContext context) {
    return FutureBuilder(
        future: getEventos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildEvento(context, snapshot);
          }
        });
  }

  Widget buildEvento(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            EventosItem item = snapshot.data[index];
            return noticia(item.titulo, item.objetivo, item.url,
                item.fechaYhora, item.institucion, item.voluntario);
          }),
    );
  }

  Widget noticia(String titulo, String objetivo, String url,
      DateTime fechaYhora, String institucion, String voluntario) {
    return InkWell(
      onTap: () {       
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 5, bottom: 16, right: 8),
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: <Widget>[
            ImageOpaqueNetworkCustomize(
                url,
                AppTheme.themeColorVerde  ,
                Size(MediaQuery.of(context).size.width, 100),
                0.5,
                BoxFit.cover),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 7,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      new DateFormat("dd").format(fechaYhora),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      new DateFormat("MMM").format(fechaYhora),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      new DateFormat("HH:mm").format(fechaYhora),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    width: MediaQuery.of(context).size.width - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          titulo,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          objetivo,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Institucion: ${objetivo}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            voluntario.length > 0
                                ? Text(
                                    "Institucion: ${voluntario}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                : Text("")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
