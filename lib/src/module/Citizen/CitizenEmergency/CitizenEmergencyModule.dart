import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/module/General/PageViewModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class CitizenEmergencyModule extends StatefulWidget {
  @override
  _CitizenEmergencyModuleState createState() => _CitizenEmergencyModuleState();
}

class _CitizenEmergencyModuleState extends State<CitizenEmergencyModule> {
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
              //backgroundColor: AppTheme.themeColorNaranja,
            ),
            drawer: DrawerCitizen(),
            // backgroundColor: Colors.red,
            body: optionPage[page],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Medicina'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  title: Text('Covid'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  title: Text('Medicamentos'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.accessible_forward),
                  title: Text('bonos'),
                ),
              ],
              currentIndex: page,
              unselectedItemColor: Colors.black54,
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
              futureMedicamentoss(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: AppTheme.themeColorNaranja,
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          contenidoCabecera(context, tempDate, solicitudAyuda),
          contenidoFinal(context, solicitudAyuda),
        ],
      ),
    );
  }

  Container contenidoFinal(
      BuildContext context, SolicitudAyuda solicitudAyuda) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.white,
                  size: 25,
                ),
                Text(
                  "Atender",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onTap: () {
              _submit(context, solicitudAyuda);
            },
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            children: <Widget>[
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.handshake,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {},
              ),
              Text(
                "Concluido",
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }

  _submit(BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1006;
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

  Container contenidoCabecera(
      BuildContext context, DateTime tempDate, SolicitudAyuda solicitudAyuda) {
    Color colorCuadro;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
    } else {
      colorCuadro = AppTheme.themeColorVerde;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: colorCuadro,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                new DateFormat("dd/MM/yyyy").format(tempDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                new DateFormat("HH:mm").format(tempDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Detalle:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: solicitudAyuda.detalle,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.phoneVolume,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  callNumber(solicitudAyuda.telefono);
                },
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.comment,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  sendSMS(solicitudAyuda.telefono);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PageCovid extends StatelessWidget {
  const PageCovid({Key key}) : super(key: key);

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
              futureCovid(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: AppTheme.themeColorNaranja,
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          contenidoCabecera(context, tempDate, solicitudAyuda),
          contenidoFinal(context),
        ],
      ),
    );
  }

  Container contenidoFinal(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.white,
                  size: 25,
                ),
                Text(
                  "Atender",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onTap: () {},
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            children: <Widget>[
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.handshake,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {},
              ),
              Text(
                "Concluido",
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }

  Container contenidoCabecera(
      BuildContext context, DateTime tempDate, SolicitudAyuda solicitudAyuda) {
    Color colorCuadro;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
    } else {
      colorCuadro = AppTheme.themeColorVerde;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: colorCuadro,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                new DateFormat("dd/MM/yyyy").format(tempDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                new DateFormat("HH:mm").format(tempDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Detalle:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: solicitudAyuda.detalle,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.phoneVolume,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  callNumber(solicitudAyuda.telefono);
                },
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.comment,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  sendSMS(solicitudAyuda.telefono);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PageMedicmanetos extends StatelessWidget {
  const PageMedicmanetos({Key key}) : super(key: key);

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
                "Listado de solicitudes para ayuda con Medicamentos",
                style: AppTheme.themeTitulo,
              ),
              futureMedicamentos(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: AppTheme.themeColorNaranja,
  }

  Widget futureMedicamentos(BuildContext context) {
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          contenidoCabecera(context, tempDate, solicitudAyuda),
          contenidoFinal(context),
        ],
      ),
    );
  }

  Container contenidoFinal(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.white,
                  size: 25,
                ),
                Text(
                  "Atender",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onTap: () {},
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            children: <Widget>[
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.handshake,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {},
              ),
              Text(
                "Concluido",
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }

  Container contenidoCabecera(
      BuildContext context, DateTime tempDate, SolicitudAyuda solicitudAyuda) {
    Color colorCuadro;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
    } else {
      colorCuadro = AppTheme.themeColorVerde;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: colorCuadro,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                new DateFormat("dd/MM/yyyy").format(tempDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                new DateFormat("HH:mm").format(tempDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Detalle:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: solicitudAyuda.detalle,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.phoneVolume,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  callNumber(solicitudAyuda.telefono);
                },
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.comment,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  sendSMS(solicitudAyuda.telefono);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PageBonos extends StatelessWidget {
  const PageBonos({Key key}) : super(key: key);

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
              futureBonos(context),
            ],
          ),
        ),
      ),
    );
    //backgroundColor: AppTheme.themeColorNaranja,
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          contenidoCabecera(context, tempDate, solicitudAyuda),
          contenidoFinal(context),
        ],
      ),
    );
  }

  Container contenidoFinal(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.white,
                  size: 25,
                ),
                Text(
                  "Atender",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onTap: () {},
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            children: <Widget>[
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.handshake,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {},
              ),
              Text(
                "Concluido",
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }

  Container contenidoCabecera(
      BuildContext context, DateTime tempDate, SolicitudAyuda solicitudAyuda) {
    Color colorCuadro;
    if (solicitudAyuda.idaPrioridad == 68) {
      colorCuadro = AppTheme.themeColorRojo;
    } else if (solicitudAyuda.idaPrioridad == 69) {
      colorCuadro = AppTheme.themeColorNaranja;
    } else {
      colorCuadro = AppTheme.themeColorVerde;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: colorCuadro,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                new DateFormat("dd/MM/yyyy").format(tempDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                new DateFormat("HH:mm").format(tempDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Detalle:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: solicitudAyuda.detalle,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.phoneVolume,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  callNumber(solicitudAyuda.telefono);
                },
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                child: FaIcon(
                  FontAwesomeIcons.comment,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  sendSMS(solicitudAyuda.telefono);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
