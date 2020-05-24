import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Util/Util.dart';

final prefs = new PreferensUser();

final kTitleSigIn = TextStyle(
  color: Colors.black87,
  fontFamily: 'Dancing',
  fontSize: 32.0,
  height: 1.5,
);

final kSubTitleSigIn = TextStyle(
  color: Colors.black87,
  fontFamily: 'Dancing',
  fontSize: 27.0,
  height: 1.5,
);

final kTitleAppBar = TextStyle(
  color: Colors.white,
  fontSize: 17,
);

final kTitleCardStyle = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  height: 1.5,
);

final kSubTitleCardStyle = TextStyle(
  color: Colors.black87,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  height: 1.0,
);

final kSubSubTitleCardStyle = TextStyle(
  color: Colors.black87,
  fontSize: 15,
  fontWeight: FontWeight.w600,
  height: 1.5,
);

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.0,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white60,
  fontSize: 18.0,
  height: 1.2,
);

final kTitleHomeCursiveStyle = TextStyle(
  color: Colors.black87,
  fontFamily: 'Dancing',
  fontSize: 28.0,
  height: 1.5,
);

final kTitleCursiveStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Dancing',
  fontSize: 22.0,
  height: 1.5,
);

final kTitleCursive1Style = TextStyle(
  color: Colors.black,
  fontFamily: 'Dancing2',
  fontSize: 22.0,
  height: 1.5,
);
final kTitleCursive2Style = TextStyle(
  color: Colors.black,
  fontFamily: 'Dancing3',
  fontSize: 22.0,
  height: 1.5,
);
final kTitleCursive3Style = TextStyle(
  color: Colors.black,
  fontFamily: 'Dancing4',
  fontSize: 20.0,
  height: 1.5,
);

final kTitleCursive4Style = TextStyle(
  color: Colors.black,
  fontFamily: 'Dancing',
  fontSize: 14.0,
  height: 1.5,
);

Widget crearFondo(BuildContext context, String imagen) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.38,
      width: double.infinity,
      decoration: boxDecoration(),
    );
    return Stack(
      children: <Widget>[
        fondoModaro,
  
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Align(
                child: RadialProgress(
                  width: 4,
                  goalCompleted: 0.90,
                  progressColor: Colors.white,
                  progressBackgroundColor: Color.fromRGBO(165, 5, 5, 0.7),
                  child: Container(
                      child: ImageOvalNetwork(
                          imageNetworkUrl: imagen,
                          sizeImage: Size.fromWidth(90))),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
  
cabeceraInformativa() {
  return RichText(
    text: TextSpan(
      text: 'Voluntario(a): ${prefs.nombreUsuario}',
      style: kTitleCardStyle,
      children: <TextSpan>[
        TextSpan(
          text: '\n' + 'Institución: ${prefs.nombreInstitucion}',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

boxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    stops: [0.1, 0.4, 0.7, 0.9],
    colors: [
      // Color.fromRGBO(142, 12, 3, 0.8),
      // Color.fromRGBO(232, 78, 68, 1.0),
      // Color.fromRGBO(168, 18, 8, 0.6),
      // Color.fromRGBO(196, 66, 58, 1.0),
      Color.fromRGBO(168, 18, 8, 0.6),
                Color.fromRGBO(176, 30, 20, 1.0),
                Color.fromRGBO(168, 18, 8, 0.6),
                Color.fromRGBO(164, 18, 9, 1.0),
    ],
  ));
}

boxDecorationAccesos() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    stops: [0.1, 0.4, 0.7],
    colors: [
      Color.fromRGBO(255, 253, 253, 0.8),
      Color.fromRGBO(252, 250, 250, 1.0),
      Color.fromRGBO(248, 245, 245, 0.6),
      // Color.fromRGBO(196, 66, 58, 1.0),
      
      
      
      // Color.fromRGBO(168, 18, 8, 0.6),
      //           Color.fromRGBO(176, 30, 20, 1.0),
      //           Color.fromRGBO(168, 18, 8, 0.6),
      //           Color.fromRGBO(164, 18, 9, 1.0),
    ],
  ));
}

BoxDecoration contenedorCabecera() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black26,
            blurRadius: 7.0,
            offset: Offset(2.0, 2.0),
            spreadRadius: 4.0)
      ]);
}

BoxDecoration contenedorCampos() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black26,
            blurRadius: 7.0,
            offset: Offset(2.0, 3.0),
            spreadRadius: 4.0)
      ]);
}

BoxDecoration contenedorCarretes() {
  return  BoxDecoration(
        color: Color.fromRGBO(165, 5, 5, 0.8),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(2.0, 3.0),
              spreadRadius: 4.0)
        ]);
}


Container contenedorTitulo(
    BuildContext context, double height, String text, FaIcon icon) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.92,
    height: height,
    decoration: BoxDecoration(
        color: Color.fromRGBO(165, 5, 5, 0.8),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(2.0, 3.0),
              spreadRadius: 4.0)
        ]),
    child: Row(
      children: <Widget>[
        SizedBox(width: 10.0),
        icon,
        SizedBox(width: 15.0),
        Text(text,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
              height: 1.5,
            )),
      ],
    ),
  );
}

Widget fondoApp1() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.6),
            end: FractionalOffset(0.0, 1.0),
            colors: [
          Color.fromRGBO(70, 191, 167, 1.0),
          Color.fromRGBO(236, 220, 109, 1.0),
          Color.fromRGBO(245, 173, 53, 1.0),
          Color.fromRGBO(215, 78, 159, 1.0),
        ])),
  );
}

Widget fondoApp() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.6),
            end: FractionalOffset(0.0, 1.0),
            colors: [
          Color.fromRGBO(215, 78, 159, 1.0),
          Color.fromRGBO(245, 173, 53, 1.0),
          Color.fromRGBO(236, 220, 109, 1.0),
          Color.fromRGBO(70, 191, 167, 1.0),
        ])),
  );
}

Divider divider() {
  return Divider(
    thickness: 1.5,
    color: Color.fromRGBO(165, 5, 5, 1.0),
    endIndent: 20.0,
    indent: 20.0,
  );
}

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  static const Color themeColorRojo = Color.fromRGBO(255, 76, 61, 1); //ff4c3d
  static const Color themeColorCeleste =
      Color.fromRGBO(5, 147, 255, 1); //0593FF
  static const Color themeColorAzul = Color.fromRGBO(18, 64, 120, 1); //124078
  static const Color themeColorNaranja =
      Color.fromRGBO(255, 93, 19, 1); //ff5d12
  static const Color themeColorVerde =
      Color.fromRGBO(100, 179, 116, 1); //64B374
  static const Color themeColorBlanco = Colors.white;
  static const Color themeVino = Color.fromRGBO(165, 5, 5, 0.7);
  static const Color themeAmarillo = Color.fromRGBO(9, 65, 108, 1.0);

  static const TextStyle themeTitulo = TextStyle(
      fontSize: 15,
      color: AppTheme.themeColorAzul,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic);

  /// begin institution

  static const Color backGroundInstitutionPrimary = Colors.orangeAccent;
  static const Color backGroundInstitutionSecundary = Colors.white;
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 32.0,
    color: Colors.white,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.1,
  );

  /// end institution

  static const TextTheme textTheme = TextTheme(
    // display1: display1,
    // headline: headline,
    // title: title,
    // subtitle: subtitle,
    // body2: body2,
    // body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}
