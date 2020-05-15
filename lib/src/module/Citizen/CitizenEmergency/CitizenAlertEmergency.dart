import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/HomePage/HomePageModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class CitizenAlertEmergency extends StatefulWidget {
  String personal;
  String voluntario;
  static final String routeName ='CiudadanoAlertaEmergencia';

  CitizenAlertEmergency(@required this.personal, @required this.voluntario);

  @override
  _CitizenAlertEmergencyState createState() => _CitizenAlertEmergencyState();
}

class _CitizenAlertEmergencyState extends State<CitizenAlertEmergency> {
  final prefs = new PreferensUser();
  RegistrarAyuda registrarAyuda = new RegistrarAyuda();

@override
  void initState() {
    prefs.ultimaPagina = CitizenAlertEmergency.routeName;
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
                "Historial de solicitudes",
                style: TextStyle(
                    color: AppTheme.themeColorNaranja,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              //backgroundColor: colorCuadro,
            ),
            drawer: DrawerCitizen(),
            // backgroundColor: Colors.red,
            body: Column(
              children: <Widget>[              
                cuerpoSolicitudes(),
              ],
            )));
  }

  Widget cuerpoSolicitudes() {
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
              futureSolicitudes(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget futureSolicitudes(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new SolicitudAyuda(),
            urlGetHistorialListaSolicitudesAyudas +
                '/${widget.personal}' +
                '/${widget.voluntario}',
            primaryKeyHistorialListaSolicitudesAyudas),
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
                         Text(
                          "Fecha solicitud:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        
                        Row(
                          children: <Widget>[
                        SizedBox(width: 15,),   
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
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15,),
                            RichText(
                              overflow: TextOverflow.clip,
                              text: TextSpan(
                                text: solicitudAyuda.detalle,
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Atendido por:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15,),
                            Text(
                              solicitudAyuda.nombrePersonalAtendio,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                         Text(
                          "Institución:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15,),
                            Text(
                              solicitudAyuda.nombreInstitucionAtencion,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                          Text(
                          "Fecha atención:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15,),
                            Text(
                              solicitudAyuda.fechaAtencion,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        /*
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
                        )*/
                      ],
                    ),
                    trailing: Opacity(
                      opacity: (widget.voluntario == '-1') ? 0 : 1,
                      child: InkWell(
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
                          _submitConcluirAtencionr(context, solicitudAyuda);
                        },
                      ),
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

  _submitConcluirAtencionr(
      BuildContext context, SolicitudAyuda solicitudAyuda) async {
    registrarAyuda.idaBotonPanico = solicitudAyuda.idaBotonPanico;
    registrarAyuda.idaPersonal = 1006;
    registrarAyuda.fecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
    registrarAyuda.idaEstado = 79; // en cursoF
    registrarAyuda.usuario = "coavchristian@hotmail.com";

    final dataMap = Generic().add(registrarAyuda, urlAddSolicitudAyud);
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
