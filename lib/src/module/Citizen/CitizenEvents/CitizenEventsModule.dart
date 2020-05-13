import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';

import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

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
        future: Generic().getAll(
            new EventosItem(), urlGetListaEventos, primaryKeyListaEventos),
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
            return noticia(item);
          }),
    );
  }

  Widget noticia(EventosItem eventoItem) {
    DateTime tempDate = new DateFormat("dd/MM/yyyy").parse(eventoItem.fecha);

    String mes;
    switch (tempDate.month) {
      case 1:
        mes = "Ene";
        break;
      case 2:
        mes = "Feb";
        break;
      case 3:
        mes = "Mar";
        break;
      case 4:
        mes = "Abr";
        break;
      case 5:
        mes = "May";
        break;
      case 6:
        mes = "Jun";
        break;
      case 7:
        mes = "Jul";
        break;
      case 8:
        mes = "Ago";
        break;
      case 9:
        mes = "Sep";
        break;
      case 10:
        mes = "Oct";
        break;
      case 11:
        mes = "Nov";
        break;
      case 12:
        mes = "Dic";
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CitizenEventsDetailModule(
                      eventosItem: eventoItem,
                    )));
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(top: 5, bottom: 16, right: 8),
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: <Widget>[
            ImageOpaqueNetworkCustomize(
                eventoItem.url,
                AppTheme.themeColorVerde,
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
                      new DateFormat("dd").format(tempDate),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      mes,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      eventoItem.hora,
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
                          eventoItem.titulo,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          eventoItem.objetivo,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Institucion: " + eventoItem.institucion,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            eventoItem.voluntario.length > 0
                                ? Text(
                                    "Expositor: " + eventoItem.expositor,
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
