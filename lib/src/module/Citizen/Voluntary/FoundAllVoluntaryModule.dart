import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class FoundAllVoluntaryModule extends StatefulWidget {
  final ProfesionalesAgrupados profesional;
  static final String routeName ='EncontrarTodosLosVoluntarios';

  const FoundAllVoluntaryModule({Key key, @required this.profesional})
      : super(key: key);

  @override
  _FoundAllVoluntaryModuleState createState() =>
      _FoundAllVoluntaryModuleState();
}

class _FoundAllVoluntaryModuleState extends State<FoundAllVoluntaryModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();

  @override
  void initState() { 
    
    prefs.ultimaPagina = FoundAllVoluntaryModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
        elevation: 0,
        title: Text(
          widget.profesional.profesion,
          style: TextStyle(
              color: AppTheme.themeColorNaranja,
              fontSize: 17,
              fontWeight: FontWeight.w400),
        ),
        //backgroundColor: AppTheme.themeColorNaranja,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              ImageOpaqueNetworkCustomize(widget.profesional.imagenFondo,
                  Colors.white, Size(100, 100), 0.8, BoxFit.cover),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.clip,
                  text: TextSpan(
                    text: widget.profesional.descripcion,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Lista de profesionales / voluntarios registradas",
                  style: AppTheme.themeTitulo,
                )),
          ),
          futureCuerpoProfesionales(context),
        ],
      )),
    );
  }

  Widget informacionProfesional(BuildContext context,
      ProfesionalesDeInstitucion profesionalesDeInstitucion) {
    String parametroCovid = profesionalesDeInstitucion.ayudaConCovid;
    return ListTile(
      leading: imagenProfesional(profesionalesDeInstitucion),
      title: Text(profesionalesDeInstitucion.tipoProfesion),
      subtitle: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(profesionalesDeInstitucion.nombreProfesional),
          Opacity(
            opacity: (parametroCovid == "0") ? 0 : 1,
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/image/COVID-19.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Ayuda con pacientes COVID",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                )
              ],
            ),
          )
        ],
      ),
      //trailing:crearIconoProfesional(Icons.mail, 'Correo')
      trailing: Wrap(
        children: <Widget>[
          InkWell(
            child: FaIcon(
              FontAwesomeIcons.phoneVolume,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {
              callNumber(int.parse(profesionalesDeInstitucion.telefono));
            },
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            child: FaIcon(
              FontAwesomeIcons.comment,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {
              sendSMS(int.parse(profesionalesDeInstitucion.telefono));
            },
          ),
          SizedBox(
            width: 15,
          ),
          InkWell(
            child: FaIcon(
              FontAwesomeIcons.mailBulk,
              color: Colors.blue,
              size: 25,
            ),
            onTap: () {
              sendEmailAdvanced(
                  profesionalesDeInstitucion.correo,
                  "Colaboración ${profesionalesDeInstitucion.tipoProfesion}",
                  "Estimad@:  ${profesionalesDeInstitucion.nombreProfesional}, favor su colaboración en: ");
            },
          )
        ],
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
        InkWell(
          onTap: () => sendEmailAdvanced(
              'marcoarce23@gmail.com',
              'SOLICITUD CONSULTA MEDICA',
              'Estimado Sr. Marco Arce, solcitud pder contactarme cn su persona.'), //sendSMS(72038768),
          child: Icon(
            icon,
            size: 18,
            color: AppTheme.themeColorAzul,
          ),
        ),
      ],
    );
  }

  Widget futureCuerpoProfesionales(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new ProfesionalesDeInstitucion(),
            urlGetListaProfesionalesInstitucion +
                '/' +
                widget.profesional.idInstitucion.toString() +
                '/' +
                widget.profesional.idProfesion.toString(),
            primaryKeyListaProfesionalesInstitucion),
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
