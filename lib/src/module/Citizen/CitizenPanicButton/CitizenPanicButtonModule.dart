import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';

class CitizenPanicButtonModule extends StatefulWidget {
  const CitizenPanicButtonModule({Key key}) : super(key: key);

  @override
  _CitizenPanicButtonModuleState createState() =>
      _CitizenPanicButtonModuleState();
}

class _CitizenPanicButtonModuleState extends State<CitizenPanicButtonModule> {
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
              "Botón de ayuda",
              style: TextStyle(
                  color: AppTheme.themeColorNaranja,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            //backgroundColor: AppTheme.themeColorNaranja,
          ),
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
                ButtonPanic(titulo: "Boton ayuda "),
                ButtonPanic(titulo: "Boton emergencia medica"),
                ButtonPanic(titulo: "Boton por abastecimiento"),
              ],
            ),
          )),
    );
  }
}

class ButtonPanic extends StatefulWidget {
  final String titulo;

  const ButtonPanic({Key key, this.titulo}) : super(key: key);

  @override
  _ButtonPanic createState() => _ButtonPanic();
}

class _ButtonPanic extends State<ButtonPanic> {
  bool checkHigh = false;
  bool checkModerate = false;
  bool checkLow = false;

  @override
  void initState() {
    checkLow = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buttonPanic(),
    );
  }

  Widget buttonPanic() {
    var textStyle = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
        color: AppTheme.themeColorVerde);
        
    return Stack(
      children: <Widget>[
        Positioned(
            top: 65,
            left: 235,
            child: Opacity(
              opacity: 0.3,
                          child: Image.asset(
                'assets/image/button_panic.png',
                width: 180,
                height: 150,
                fit: BoxFit.cover,
              ),
            )),
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
                padding: const EdgeInsets.only(top: 0.0,),
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
                            Text(
                                DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(" Prioridad:",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Muy Alta",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            Checkbox(
                                value: checkHigh,
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHigh = true;
                                    checkModerate = false;
                                    checkLow = false;
                                  });
                                }),
                            Text("Alta",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                            Checkbox(
                                value: checkModerate,
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHigh = false;
                                    checkModerate = true;
                                    checkLow = false;
                                  });
                                }),
                            Text("Media",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                            Checkbox(
                                value: checkLow,
                                onChanged: (bool value) {
                                  setState(() {
                                    checkHigh = false;
                                    checkModerate = false;
                                    checkLow = true;
                                  });
                                })
                          ],
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 13),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.black),
                            labelText: "Detalle",
                            border: InputBorder.none,
                            hintText: 'Ingrese alguna observacion',
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 13),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 13, color: Colors.black),
                            labelText: "Nro telefonico",
                            border: InputBorder.none,
                            hintText: 'Ingrese el número de telefono para comunicarnos',
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                        Center(
                          child: FlatButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              /*...*/
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

    /*
    return Container(
        height: 100.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            backgroundContainer(),
            imageButton(),
            contentPanicButton(),
          ],
        ));
    */
  }

}
