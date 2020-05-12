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
              iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
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
       decoration: BoxDecoration(
          color: Color.fromRGBO(191, 191, 191, 0.55),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
      width: MediaQuery.of(context).size.width,
      height: 50,
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.blue,
                  size: 25,
                ),
                Text(
                  "Atender",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            onTap: () {
              _submitMedicamentosAtender(context, solicitudAyuda);
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
                  color: Colors.blue,
                  size: 25,
                ),
                onTap: () {
                  _submitMedicamentosConcluido(context, solicitudAyuda);
                },
              ),
              Text(
                "Concluido",
                style: TextStyle(color: Colors.blue),
              )
            ],
          )
        ],
      ),
    );
  }

  _submitMedicamentosConcluido(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1006;
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

    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(191, 191, 191, 0.15),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),

      width: MediaQuery.of(context).size.width,
      height: 70,
      //color: colorCuadro,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.eye,
                color: colorCuadro,
                size: 30,
              ),
              Text(
                detallePrioridad,
                style: TextStyle(
                    fontSize: 12,
                    color: colorCuadro,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
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
                  color: colorCuadro,
                  fontSize: 14,
                ),
              ),
              Text(
                new DateFormat("HH:mm").format(tempDate),
                style: TextStyle(
                  color: colorCuadro,
                  fontSize: 14,
                ),
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
                      color: colorCuadro,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: solicitudAyuda.detalle,
                    style: TextStyle(fontSize: 14, color: colorCuadro),
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
                  color: colorCuadro,
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
                  color: colorCuadro,
                  size: 25,
                ),
                onTap: () {
                  sendSMS(solicitudAyuda.telefono);
                },
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
    );
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
       decoration: BoxDecoration(
          color: Color.fromRGBO(191, 191, 191, 0.55),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
      width: MediaQuery.of(context).size.width,
      height: 50,
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.blue,
                  size: 25,
                ),
                Text(
                  "Atender",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            onTap: () {
              _submitCovidAtender(context, solicitudAyuda);
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
                  color: Colors.blue,
                  size: 25,
                ),
                onTap: () {
                  _submitCovidConcluido(context, solicitudAyuda);
                },
              ),
              Text(
                "Concluido",
                style: TextStyle(color: Colors.blue),
              )
            ],
          )
        ],
      ),
    );
  }

  _submitCovidConcluido(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1006;
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

    return Container(
       decoration: BoxDecoration(
          color: Color.fromRGBO(191, 191, 191, 0.15),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      width: MediaQuery.of(context).size.width,
      height: 70,
      
      child: Row(
        children: <Widget>[
          
          
  Column(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.eye,
                color: colorCuadro,
                size: 30,
              ),
              Text(
                detallePrioridad,
                style: TextStyle(
                    fontSize: 12,
                    color: colorCuadro,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),

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
                    color: colorCuadro,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                new DateFormat("HH:mm").format(tempDate),
                style: TextStyle(
                    color: colorCuadro,
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
                      color: colorCuadro,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: solicitudAyuda.detalle,
                    style: TextStyle(fontSize: 14, color: colorCuadro),
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
                  color: colorCuadro,
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
                  color: colorCuadro,
                  size: 25,
                ),
                onTap: () {
                  sendSMS(solicitudAyuda.telefono);
                },
              )
            ],
          ),
           SizedBox ( width:10),
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
                "Listado de solicitudes para ayuda con MEDICAMENTOS",
                style: AppTheme.themeTitulo,
              ),
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
       decoration: BoxDecoration(
          color: Color.fromRGBO(191, 191, 191, 0.55),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
      width: MediaQuery.of(context).size.width,
      height: 50,
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.blue,
                  size: 25,
                ),
                Text(
                  "Atender",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            onTap: () {
              _submitAtender(context, solicitudAyuda);
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
                  color: Colors.blue,
                  size: 25,
                ),
                onTap: () {
                  _submitConcluido(context, solicitudAyuda);
                },
              ),
              Text(
                "Concluido",
                style: TextStyle(color: Colors.blue),
              )
            ],
          )
        ],
      ),
    );
  }

  _submitConcluido(BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1006;
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


    return Container(
       decoration: BoxDecoration(
          color: Color.fromRGBO(191, 191, 191, 0.15),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      width: MediaQuery.of(context).size.width,
      height: 70,
      
      child: Row(
        children: <Widget>[
          
  Column(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.eye,
                color: colorCuadro,
                size: 30,
              ),
              Text(
                detallePrioridad,
                style: TextStyle(
                    fontSize: 12,
                    color: colorCuadro,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),

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
                    color: colorCuadro,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                new DateFormat("HH:mm").format(tempDate),
                style: TextStyle(
                    color: colorCuadro,
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
                      color: colorCuadro,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: solicitudAyuda.detalle,
                    style: TextStyle(fontSize: 14, color: colorCuadro),
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
                  color: colorCuadro,
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
                  color: colorCuadro,
                  size: 25,
                ),
                onTap: () {
                  sendSMS(solicitudAyuda.telefono);
                },
              )
            ],
          ),
          SizedBox(width: 10,)
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
       decoration: BoxDecoration(
          color: Color.fromRGBO(191, 191, 191, 0.55),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))),
      width: MediaQuery.of(context).size.width,
      height: 50,
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: Colors.blue,
                  size: 25,
                ),
                Text(
                  "Atender",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            onTap: () {
              _submitMedicamentosAtender(context, solicitudAyuda);
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
                  color: Colors.blue,
                  size: 25,
                ),
                onTap: () {
                  _submitMedicamentosConcluido(context, solicitudAyuda);
                },
              ),
              Text(
                "Concluido",
                style: TextStyle(color: Colors.blue),
              )
            ],
          )
        ],
      ),
    );
  }

  _submitMedicamentosConcluido(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1006;
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


    return Container(
       decoration: BoxDecoration(
          color: Color.fromRGBO(191, 191, 191, 0.15),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      width: MediaQuery.of(context).size.width,
      height: 70,
      
      child: Row(
        children: <Widget>[
            Column(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.eye,
                color: colorCuadro,
                size: 30,
              ),
              Text(
                detallePrioridad,
                style: TextStyle(
                    fontSize: 12,
                    color: colorCuadro,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
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
                    color: colorCuadro,
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                new DateFormat("HH:mm").format(tempDate),
                style: TextStyle(
                    color: colorCuadro,
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
                      color: colorCuadro,
                      fontSize: 14,
                      fontWeight: FontWeight.w800),
                ),
                RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: solicitudAyuda.detalle,
                    style: TextStyle(fontSize: 14, color: colorCuadro),
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
                  color: colorCuadro,
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
                  color: colorCuadro,
                  size: 25,
                ),
                onTap: () {
                  sendSMS(solicitudAyuda.telefono);
                },
              )
            ],
          ),
           SizedBox(
                width: 10,
              )
        ],
      ),
    );
  }
}
