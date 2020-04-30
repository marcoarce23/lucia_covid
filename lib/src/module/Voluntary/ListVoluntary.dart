import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/ListEntity.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';

class ListVoluntary extends StatefulWidget {
  final ProfesionalesAgrupados profesional;

  const ListVoluntary({Key key, @required this.profesional}) : super(key: key);

  @override
  _ListVoluntaryState createState() => _ListVoluntaryState();
}

class _ListVoluntaryState extends State<ListVoluntary> {
  final generic = new Generic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.profesional.profesion),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: FormaRecorte(),
              child: Container(
                height: 150,
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
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Hero(
                    tag: widget.profesional.imagenFondo,
                    child: ImageOpaqueAssets(widget.profesional.imagenFondo,
                        Colors.white, Size(170.0, 150.0), 0.50),
                  ),
                ),
                futureCuerpoProfesionales(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget informacionProfesional(BuildContext context,
      ProfesionalesDeInstitucion profesionalesDeInstitucion) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.black12,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                imagenProfesional(profesionalesDeInstitucion),
                RichText(
                  text: TextSpan(
                    text: profesionalesDeInstitucion
                        .tipoProfesion, // 'Dr Dan MlayahFX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '\n' + profesionalesDeInstitucion.nombreProfesional,
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: Container(
                child: Column(
                  children: <Widget>[
                    Text("Datos personales"),
                  ],
                ),
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    crearIconoProfesional(Icons.mail, 'Correo'),
                    crearIconoProfesional(Icons.phone, 'Correo'),
                    crearIconoProfesional(Icons.bug_report, 'Ayuda con covid'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Image imagenProfesional(
      ProfesionalesDeInstitucion profesionalesDeInstitucion) {
    Image imagenAvatar;

    if (profesionalesDeInstitucion.sexo == "F") {
      imagenAvatar = Image.asset(
        "assets/image/circled_user_female.png",
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      );
    } else {
      imagenAvatar = Image.asset(
        "assets/image/circled_user_male.png",
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      );
    }
    return imagenAvatar;
  }

  Column crearIconoProfesional(icon, title) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget futureCuerpoProfesionales(BuildContext context) {
    return FutureBuilder(
        future: getListaProfesionalesDeInstitucion(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return tarjetaPresentacionProfesional(context, snapshot);
          }
        });
  }

  Widget tarjetaPresentacionProfesional(
      BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            ProfesionalesDeInstitucion listaProfesionales =
                snapshot.data[index];
            return informacionProfesional(context, listaProfesionales);
          }),
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
