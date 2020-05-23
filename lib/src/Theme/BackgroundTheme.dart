import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';



Widget crearFondoForm(BuildContext context, String imagen) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.30,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
             Color.fromRGBO(215, 78, 159, 1.0),
                    Color.fromRGBO(245, 173, 53, 1.0),
                    Color.fromRGBO(236, 220, 109, 1.0),
                    Color.fromRGBO(70, 191, 167 , 1.0),
        // Color.fromRGBO(243, 124, 18, 1.0),
        // Color.fromRGBO(255, 209, 18, 3.0),
        // Color.fromRGBO(243, 156, 18, 1.0),
        // Color.fromRGBO(243, 223, 18, 1.0)

        // Color.fromRGBO(15, 94, 241, 1.0),
        // Color.fromRGBO(18, 202, 243, 2.0),
        // Color.fromRGBO(18, 144, 243, 1.0),
        // Color.fromRGBO(131, 225, 246, 1.0)

      ])),
    );

    final circulo = Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(243, 124, 18, 0.4)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: 20.0, right: 30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Align(
                child: RadialProgress(
                  width: 4,
                  goalCompleted: 0.85,
                  child: Container(
                      child: ImageOvalNetwork(
                          imageNetworkUrl: imagen,
                          sizeImage: Size.fromWidth(90))),
                ),
              ),
            
          
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Registrar Ubicación"),
                      ],
                    ),
                    Text("Lat:  -  Lng:"),
                  ],
                )

            ],
          ),
        )
      ],
    );
  }

  Widget crearFondo1(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.35,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(243, 124, 18, 1.0),
        Color.fromRGBO(255, 209, 18, 3.0),
        Color.fromRGBO(243, 156, 18, 1.0),
        Color.fromRGBO(243, 223, 18, 1.0)

        // Color.fromRGBO(15, 94, 241, 1.0),
        // Color.fromRGBO(18, 202, 243, 2.0),
        // Color.fromRGBO(18, 144, 243, 1.0),
        // Color.fromRGBO(131, 225, 246, 1.0)

      ])),
    );

    final circulo = Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(243, 124, 18, 0.4)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: 20.0, right: 30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Align(
                child: RadialProgress(
                  width: 4,
                  goalCompleted: 0.85,
                  child: Container(
                      child: ImageOvalNetwork(
                          imageNetworkUrl:
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                          sizeImage: Size.fromWidth(90))),
                ),
              )
            ],
          ),
        )
      ],
    );
  }