import 'package:flutter/material.dart';
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
              "Botón de pánico",
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
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: FormaRecorte(),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppTheme.themeColorAzul,
                              AppTheme.themeColorCeleste
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          children: <Widget>[
                            Text(
                              "El boton de panico es para notificar a las personas que colaboran al covid",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.orange),
                            ),
                          ],
                        ),
                        Text(
                          "Se activan los protocolos de accion para el covid",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 45,
                    ),
                    ButtonPanic(),
                    SizedBox(height: 25,),
                    ButtonPanic(),
                    SizedBox(height: 25,),
                    ButtonPanic(),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class FormaRecorte extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    //path.lineTo(0,size.height-80);
    print(size.width);
    print(size.height);
    path.lineTo(0, size.height);
    path.lineTo((size.width / 2) - 30, size.height);
    path.quadraticBezierTo(size.width - 20, size.height - 20, size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ButtonPanic extends StatefulWidget {
  ButtonPanic({Key key}) : super(key: key);

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
    return Stack(
      children: <Widget>[
        Card(
          elevation: 2,
                  child: Container(
                    
              color: Colors.red,
              margin: EdgeInsets.only(top: 5, left: 50, right: 20),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                      leading: Text("f"),
                      title: Text("f"),
                      trailing: Text("f")))),
        ),
        Positioned(
            top: 5,
            left: 20,
            child: Image.asset(
              'assets/image/button.png',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ))
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

  Widget contentPanicButton() {
    return InkWell(
      onTap: () {
      
      },
      child: Container(
        margin: new EdgeInsets.only(left: 120.0, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20.0,
              child: Row(
                children: <Widget>[
                  Text("Alta"),
                  Checkbox(
                      value: checkHigh,
                      onChanged: (bool value) {
                        setState(() {
                          checkHigh = true;
                          checkModerate = false;
                          checkLow = false;
                        });
                      }),
                  Text("Media"),
                  Checkbox(
                      value: checkModerate,
                      onChanged: (bool value) {
                        setState(() {
                          checkHigh = false;
                          checkModerate = true;
                          checkLow = false;
                        });
                      }),
                  Text("Bajas"),
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
            ),
            TextFormField(
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                  labelText: "Detalle",
                  border: InputBorder.none,
                  hintText: 'Ingrese alguna observacion'),
            )
          ],
        ),
      ),
    );
  }

  Widget imageButton() {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 10.0),
      alignment: FractionalOffset.centerLeft,
      child: Image.network(
        "https://images-na.ssl-images-amazon.com/images/I/61QKhYL%2BeCL.png",
        height: 155,
        width: 125,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget backgroundContainer() {
    return Container(
      height: 100.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: AppTheme.themeColorNaranja,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
  }
}
