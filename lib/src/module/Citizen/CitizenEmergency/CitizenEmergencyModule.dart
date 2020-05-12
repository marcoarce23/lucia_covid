import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';


class CitizenEmergencyModule extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
 final items = <ItemBoton>[
      new ItemBoton( Icon(Icons.aspect_ratio  ), 'Motor Accident', Color(0xff6989F5), Color(0xff906EF5) ),
      new ItemBoton( Icon(Icons.assistant_photo  ), 'Medical Emergency', Color(0xff66A9F2), Color(0xff536CF6) ),
      new ItemBoton( Icon(Icons.block  ), 'Theft / Harrasement', Color(0xffF2D572), Color(0xffE06AA3) ),
      new ItemBoton( Icon(Icons.photo_album  ), 'Awards', Color(0xff317183), Color(0xff46997D) ),
      
    ];

List<Widget> itemMap = items.map(
      (item) => FadeInLeft(
        duration: Duration( milliseconds: 250 ),
        child: BotonGordo(
          icon: item.icon,
          texto: item.texto,
          color1: item.color1,
          color2: item.color2,
          onPress: () { print('hola'); },
        ),
      )
    ).toList();



     return Scaffold(
        drawer: DrawerCitizen(),
      // backgroundColor: Colors.red,
      body: Stack(
        children: <Widget>[
          
          Container(
            margin: EdgeInsets.only( top: 200 ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox( height: 90, ),
                ...itemMap
              ],
            ),
          ),

          _Encabezado()

        ],
      )
   );
    
    
     }
}


class _Encabezado extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconHeader(
          icon: Icon(Icons.accessibility), 
          titulo: 'Asistencia Médica', 
          subtitulo: 'Haz solicitado',
          color1: Color(0xff536CF6),
          color2: Color(0xff66A9F2),
        ),

        Positioned(
          right: 0,
          top: 45,
          child: RawMaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.add)
          )
        )

      ],
    );
  }
}

class ItemBoton {

  final Icon icon;
  final String texto;
  final Color color1;
  final Color color2;

  ItemBoton( this.icon, this.texto, this.color1, this.color2 );
}




class BotonGordo extends StatelessWidget {

  final Icon icon;
  @required final String texto;
  final Color color1;
  final Color color2;
  @required final Function onPress;

  const BotonGordo({
    this.icon ,
    this.texto,
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
    this.onPress
  });

  
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Stack(
        children: <Widget>[
          _BotonGordoBackground( this.icon, this.color1, this.color2 ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox( height: 140, width: 40 ),
              Icon(Icons.account_box),
              SizedBox( width: 20 ),
              Expanded(child: Text( this.texto, style: TextStyle( color: Colors.white, fontSize: 18 ) )),
              FaIcon( FontAwesomeIcons.chevronRight, color: Colors.white ),
              SizedBox( width: 40 ),
            ],
          )

        ],
      ),
    );
  }


}

class _BotonGordoBackground extends StatelessWidget {
  
    final Icon icon;
    final Color color1;
    final Color color2;

  const _BotonGordoBackground( this.icon, this.color1, this.color2 );

  @override
  Widget build(BuildContext context) {
    return Container(

      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -20,
              top: -20,
              child: Icon(Icons.accessible_forward) 
            )
          ],
        ),
      ),

      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all( 20 ),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow( color: Colors.black.withOpacity(0.2), offset: Offset(4,6), blurRadius: 10 ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: <Color>[
            this.color1,
            this.color2,
          ]
        )
      ),
    );
  }
}



class IconHeader extends StatelessWidget {

  final Icon icon;
  final String titulo;
  final String subtitulo;
  final Color color1;
  final Color color2;

  const IconHeader({
    @required this.icon,
    @required this.titulo,
    @required this.subtitulo, 
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey
  });
  
  @override
  Widget build(BuildContext context) {

    final Color colorBlanco = Colors.white.withOpacity(0.7);

    return Stack(

      children: <Widget>[
        _IconHeaderBackground(
          color1: this.color1,
          color2: this.color2,
        ),

        Positioned(
          top: -50,
          left: -70,
          child: Icon(Icons.account_circle)
        ),

        Column(
          children: <Widget>[
            SizedBox(height: 80, width: double.infinity ),
            Text( this.subtitulo, style: TextStyle( fontSize: 20, color: colorBlanco ) ),
            SizedBox(height: 20),
            Text( this.titulo, style: TextStyle( fontSize: 25, color: colorBlanco, fontWeight: FontWeight.bold ) ),
            SizedBox(height: 20),
            Icon(Icons.account_circle)
          ],
        )

      ],

    );
  }
}


class _IconHeaderBackground extends StatelessWidget {

  final Color color1;
  final Color color2;

  const _IconHeaderBackground({
    Key key, 
    @required this.color1, 
    @required this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(80) ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color> [
            this.color1,
            this.color2,
          ]
        )
      ),
    );
  }
}