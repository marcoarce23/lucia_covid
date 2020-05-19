import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenEmergency/CitizenAlertEmergency.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class CitizenPanicButtonModule extends StatefulWidget {
  static final String routeName = 'CiudadanoBotonPanico';

  const CitizenPanicButtonModule({Key key}) : super(key: key);

  @override
  _CitizenPanicButtonModuleState createState() =>
      _CitizenPanicButtonModuleState();
}

class _CitizenPanicButtonModuleState extends State<CitizenPanicButtonModule> {
  final prefs = new PreferensUser();
   int _currentIndex =0;
  @override
  void initState() {
    prefs.ultimaPagina = CitizenPanicButtonModule.routeName;
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
              "Botón de ayuda",
              style: TextStyle(
                  color: AppTheme.themeColorNaranja,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            //backgroundColor: AppTheme.themeColorNaranja,
           
          ),

// drawer: DrawerCitizen(), 
//         bottomNavigationBar: _bottomNavigationBar(context)),

          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "El boton de panico es para notificar a las personas que colaboran al covid",
                    style: AppTheme.themeTitulo,
                  ),
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
                                      CitizenAlertEmergency(prefs.userId, "-1")),
                            );
                          },
                          child: Text("Mis solicitudes"),
                        ))),
                ButtonPanic(
                    titulo: "Boton ayuda COVID", tipoBoton: "65", ),
                ButtonPanic(
                    titulo: "Boton ayuda Medica",
                    tipoBoton: "64",
                    ),
                ButtonPanic(
                    titulo: "Boton para medicamentos",
                    tipoBoton: "66",
                   ),
                ButtonPanic(
                    titulo: "Boton para bonos", tipoBoton: "77",), 

              ],
            ),
          )
        
          ),
    );
  }
}

class ButtonPanic extends StatefulWidget {
  final String titulo;
  final String tipoBoton;

  const ButtonPanic({Key key, this.titulo, this.tipoBoton,})
      : super(key: key);

  @override
  _ButtonPanic createState() => _ButtonPanic();
}

class _ButtonPanic extends State<ButtonPanic> {
  BotonPanico botonPanico = new BotonPanico();
  final generic = new Generic();

  bool checkMuyAlto = false;
  bool checkAlto = false;
  bool checkMedio = false;

  final prefs = new PreferensUser();

  @override
  void initState() {
    checkMedio = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buttonPanic(),
    );
  }

  Widget buttonPanic() {
    botonPanico.idaCatalogo = int.parse(widget.tipoBoton);
    //botonPanico.botFecha=DateTime.now();

    String fechaNotificacion = "-/-/- --:--";

    botonPanico.botFecha =
        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());

    botonPanico.usuario = prefs.correoElectronico;

    ///72 Solicitud enviada
    botonPanico.idaEstadoSolicitud = 72;

    var textStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: AppTheme.themeColorVerde);

    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
              //color: Colors.white
            ),
            //color: Colors.red,
            margin: EdgeInsets.only(top: 5, left: 15, right: 15),
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                ),
                child: ListTile(
                  title: Container(
                    padding: EdgeInsets.only(top: 1, left: 5),
                    //height: 20.0,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget.titulo, style: textStyle),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(" Prioridad:",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Muy Alta",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            Checkbox(
                                value: checkMuyAlto,
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);

                                    botonPanico.idaPrioridad = 68;
                                    print(botonPanico.idaPrioridad);
                                    checkMuyAlto = true;
                                    checkAlto = false;
                                    checkMedio = false;
                                  });
                                }),
                            Text("Alta",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                            Checkbox(
                                value: checkAlto,
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    botonPanico.idaPrioridad = 69;
                                    print(botonPanico.idaPrioridad);

                                    checkMuyAlto = false;
                                    checkAlto = true;
                                    checkMedio = false;
                                  });
                                }),
                            Text("Media",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                            Checkbox(
                                value: checkMedio,
                                onChanged: (bool value) {
                                  setState(() {
                                    print(value);
                                    botonPanico.idaPrioridad = 70;
                                    print(botonPanico.idaPrioridad);

                                    checkMuyAlto = false;
                                    checkAlto = false;
                                    checkMedio = true;
                                  });
                                })
                          ],
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 13),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            labelText: "Detalle",
                            border: InputBorder.none,
                            hintText: 'Ingrese alguna observacion',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          onChanged: (value) {
                            botonPanico.botDetalle = value;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            labelText: "Nro  telefono",
                            border: InputBorder.none,
                            hintText:
                                'Ingrese el número de telefono para comunicarnos',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          onChanged: (value) {
                            botonPanico.botTelefono = value;
                          },
                        ),
                        Center(
                          child: FlatButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              _submit();
                              setState(() {    
                                fechaNotificacion =
                                    DateFormat("dd/MM/yyyy HH:mm")
                                        .format(DateTime.now());
                              });
                            },
                            child: Icon(Icons.pan_tool),
                          ),
                        )
                      ],
                    ),
                  ),
                ))),
      ],
    );
  }

  _submit() async {
    print(botonPanico);
    LatLng latLng;
    latLng = await getLocation().then((onvalue) => latLng = onvalue);


print(' el valorrr.... ${prefs.userId}');
    botonPanico.idLogin= int.parse(prefs.userId);
    botonPanico.botCordenadalat = latLng.latitude;
    botonPanico.botCordenadalon = latLng.longitude;
    final dataMap = generic.add(botonPanico, urlAddBotonPanico);
    var result;
    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    if (result == "0") {
      Scaffold.of(context).showSnackBar(messageOk(
          "Se registro correctamente, a las ${DateFormat("HH:mm").format(DateTime.now())} del ${DateFormat("dd/MM/yyyy").format(DateTime.now())}"));
    } else {
      Scaffold.of(context)
          .showSnackBar(messageNOk("Ocurrio un error inseperado"));
    }

    print('resultado:$result');
  }
}
