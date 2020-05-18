import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenEmergency/CitizenAlertEmergency.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';

import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class CitizenEmergencyModule extends StatefulWidget {
  static final String routeName = 'CiudadanoEmergencia';

  @override
  _CitizenEmergencyModuleState createState() => _CitizenEmergencyModuleState();
}

class _CitizenEmergencyModuleState extends State<CitizenEmergencyModule> {
  final prefs = new PreferensUser();
  int page = 0;
  final List<Widget> optionPage = [
    PageMedicina(),
    PageCovid(),
    PageMedicmanetos(),
    PageBonos()
  ];

  void _onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  @override
  void initState() {
    prefs.ultimaPagina = CitizenEmergencyModule.routeName;
    // TODO: implement initState
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
                "Solicitudes de ayuda",
                style: TextStyle(
                    color: AppTheme.themeColorNaranja,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              //backgroundColor: colorCuadro,
            ),
            drawer: DrawerCitizen(),
            // backgroundColor: Colors.red,
            body: optionPage[page],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_hospital,
                    size: 24,
                  ),
                  title: Text(
                    'Medicina',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.report, size: 24),
                  title: Text('Covid', style: TextStyle(fontSize: 12)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart, size: 24),
                  title: Text('Medicamentos y abastecimientos',
                      style: TextStyle(fontSize: 12)),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.transfer_within_a_station, size: 24),
                  title: Text('bonos', style: TextStyle(fontSize: 12)),
                ),
              ],
              currentIndex: page,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            )));
  }
}

class PageMedicina extends StatefulWidget {
  @override
  _PageMedicinaState createState() => _PageMedicinaState();
}

class _PageMedicinaState extends State<PageMedicina> {
  final generic = new Generic();

  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Listado de solicitudes para ayuda con MEDICINA",
                style: AppTheme.themeTitulo,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: FlatButton(
                        color: AppTheme.themeColorNaranja,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.greenAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CitizenAlertEmergency("-1", "1009")),
                          );
                        },
                        child: Text("Mis atenciones"),
                      ))),
              futureMedicamentoss(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget futureMedicamentoss(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas + '/64',
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);

    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeColorVerde;
      detallePrioridad = "Media";
    }

    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              new DateFormat("HH:mm").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 20,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 20,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitMedicamentosAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }

  _submitMedicamentosAtender(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1009;
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = "coavchristian@hotmail.com";

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }
}

class PageCovid extends StatefulWidget {
  @override
  _PageCovidState createState() => _PageCovidState();
}

class _PageCovidState extends State<PageCovid> {
  final generic = new Generic();
  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Listado de solicitudes para ayuda con COVID",
                style: AppTheme.themeTitulo,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: FlatButton(
                        color: AppTheme.themeColorNaranja,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.greenAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CitizenAlertEmergency("-1", "1009")),
                          );
                        },
                        child: Text("Mis atenciones"),
                      ))),
              futureCovid(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget futureCovid(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas + '/65',
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);
    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeColorVerde;
      detallePrioridad = "Media";
    }
    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  _submitCovidConcluido(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1009;
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 79; // en concluido
    registrarAyuda.usuario = "coavchristian@hotmail.com";

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se concluyo la solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }

  _submitCovidAtender(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1009;
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = "coavchristian@hotmail.com";

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              new DateFormat("HH:mm").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 20,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 20,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitCovidAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }
}

class PageMedicmanetos extends StatefulWidget {
  @override
  _PageMedicmanetosState createState() => _PageMedicmanetosState();
}

class _PageMedicmanetosState extends State<PageMedicmanetos> {
  final generic = new Generic();

  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Listado de solicitudes para ayuda con MEDICAMENTOS y ABASTECIMIENTO",
                style: AppTheme.themeTitulo,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: FlatButton(
                        color: AppTheme.themeColorNaranja,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.greenAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CitizenAlertEmergency("-1", "1009")),
                          );
                        },
                        child: Text("Mis atenciones"),
                      ))),
              future(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget future(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas + '/66',
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);
    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeColorVerde;
      detallePrioridad = "Media";
    }
    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  _submitConcluido(BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1009;
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 79; // en concluido
    registrarAyuda.usuario = "coavchristian@hotmail.com";

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se concluyo la solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }

  _submitAtender(BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1009;
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = "coavchristian@hotmail.com";

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              new DateFormat("HH:mm").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 20,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 20,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }
}

class PageBonos extends StatefulWidget {
  @override
  _PageBonosState createState() => _PageBonosState();
}

class _PageBonosState extends State<PageBonos> {
  final generic = new Generic();

  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Listado de solicitudes para ayuda con Bonos",
                style: AppTheme.themeTitulo,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: FlatButton(
                        color: AppTheme.themeColorNaranja,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.greenAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CitizenAlertEmergency("-1", "1009")),
                          );
                        },
                        child: Text("Mis atenciones"),
                      ))),
              futureBonos(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: colorCuadro,
  }

  Widget futureBonos(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetListaSolicitudesAyudas + '/77',
            primaryKeyListaSolicitudesAyudas),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemSolcitud(context, snapshot);
          }
        });
  }

  Widget buildItemSolcitud(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            SolicitudAyuda item = snapshot.data[index];
            return itemSolicitud(context, item);
          }),
    );
  }

  Widget itemSolicitud(BuildContext context, SolicitudAyuda solicitudAyuda) {
    DateTime tempDate =
        new DateFormat("dd/MM/yyyy").parse(solicitudAyuda.fecha);
    Color colorCuadro;
    String detallePrioridad;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
      detallePrioridad = "Muy alta";
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
      detallePrioridad = "Alta";
    } else {
      colorCuadro = AppTheme.themeColorVerde;
      detallePrioridad = "Media";
    }
    return contenidoAtencionSolicitudes(
        colorCuadro, detallePrioridad, tempDate, solicitudAyuda, context);
  }

  _submitMedicamentosConcluido(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1009;
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 79; // en concluido
    registrarAyuda.usuario = "coavchristian@hotmail.com";

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se concluyo la solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }

  _submitMedicamentosAtender(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1009;
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 78; // en cursoF
    registrarAyuda.usuario = "coavchristian@hotmail.com";

    final dataMap = generic.add(registrarAyuda, urlAddSolicitudAyud);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      setState(() {
        Scaffold.of(context)
            .showSnackBar(messageOk("Se puso en atención su solicitud"));
      });
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }

  Widget contenidoAtencionSolicitudes(
      Color colorCuadro,
      String detallePrioridad,
      DateTime tempDate,
      SolicitudAyuda solicitudAyuda,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
              ),
            ]),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.eye,
                          color: colorCuadro,
                          size: 30,
                        ),
                        Text(
                          detallePrioridad,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              new DateFormat("dd/MM/yyyy").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              new DateFormat("HH:mm").format(tempDate),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Detalle:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          overflow: TextOverflow.clip,
                          text: TextSpan(
                            text: solicitudAyuda.detalle,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.phoneVolume,
                                size: 20,
                              ),
                              onTap: () {
                                callNumber(solicitudAyuda.telefono);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              child: FaIcon(
                                FontAwesomeIcons.comment,
                                size: 20,
                              ),
                              onTap: () {
                                sendSMS(solicitudAyuda.telefono);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            "Atender",
                          )
                        ],
                      ),
                      onTap: () {
                        _submitMedicamentosAtender(context, solicitudAyuda);
                      },
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[],
                  ),
                ],
              ),
            ),
          ),
          //contenidoCabecera(context, tempDate, solicitudAyuda),
          //contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }
}
