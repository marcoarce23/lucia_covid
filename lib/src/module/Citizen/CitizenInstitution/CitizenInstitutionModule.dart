import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/ListEntity.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenMultimedia/CitizenImageDetailModule.dart';
import 'package:lucia_covid/src/module/General/PageViewModule.dart';
import 'package:lucia_covid/src/module/Voluntary/FoundAllVoluntaryModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class CitizenInstitutionModule extends StatefulWidget {
  final InstitucionesItems institutionItem;

  const CitizenInstitutionModule({Key key, @required this.institutionItem})
      : super(key: key);

  @override
  _CitizenInstitutionModuleState createState() =>
      _CitizenInstitutionModuleState();
}

class _CitizenInstitutionModuleState extends State<CitizenInstitutionModule> {
  final generic = new Generic();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeigh = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
        elevation: 0,
        title: Text(
          widget.institutionItem.nombreInstitucion,
          style: TextStyle(
              color: AppTheme.themeColorNaranja,
              fontSize: 17,
              fontWeight: FontWeight.w400),
        ),
        //backgroundColor: AppTheme.themeColorNaranja,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          cabeceraInstitucion(screenHeigh, screenwidth),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Grupo de voluntarios",
                    style: AppTheme.themeTitulo,
                  )),
            ),
          ),
          futureCuerpoProfesionales(context),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Galeria de fotos",
                    style: AppTheme.themeTitulo,
                  )),
            ),
          ),
          futureMultimedia(context),
          //cuerpoProfesionales()
        ]),
      ),
    );
  }

  Widget cuerpoProfesionales(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      child: Container(
        height: 170,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              ProfesionalesAgrupados listaProfesionales = snapshot.data[index];
              return tarjetaProfessional(listaProfesionales);
            }),
      ),
    );
  }

  Widget cabeceraInstitucion(double screenHeigh, double screenwidth) {
    return Container(
      height: 240,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: "assets/loading/loadingImage.gif",
            placeholderScale: 0.2,
            image: widget.institutionItem.url,
            width: 150,
            height: 230,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Institución / Grupo voluntarios",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(widget.institutionItem.nombreInstitucion),
              Text(
                "Tipo de institución",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Text(widget.institutionItem.tipoInstitucion),
              Text(
                "Ubicación",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.streetView,
                    color: Colors.black,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.institutionItem.ubicacion),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              Text(
                "Correo ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
              Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.mailBulk,
                    color: Colors.black,
                    size: 14,
                  ),
                  Text(widget.institutionItem.correo),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Opacity(
                    opacity:
                        (widget.institutionItem.urlPaginaFacebook.length > 1)
                            ? 1
                            : 0,
                    child: ClipOval(
                      child: Material(
                        color: Colors.white, // button color
                        child: InkWell(
                            splashColor: AppTheme
                                .backGroundInstitutionPrimary, // inkwell color
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset('assets/image/facebook.jpg',
                                    fit: BoxFit.cover)),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: widget.institutionItem
                                              .nombreInstitucion,
                                          selectedUrl: widget.institutionItem
                                              .urlPaginaFacebook,
                                        )))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Opacity(
                    opacity:
                        (widget.institutionItem.urlPaginaTwitter.length > 1)
                            ? 1
                            : 0,
                    child: ClipOval(
                      child: Material(
                        color: Colors.white, // button color
                        child: InkWell(
                            splashColor: AppTheme
                                .backGroundInstitutionPrimary, // inkwell color
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/image/twitter.jpg',
                                  fit: BoxFit.cover,
                                )),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: widget.institutionItem
                                              .nombreInstitucion,
                                          selectedUrl: widget
                                              .institutionItem.urlPaginaTwitter,
                                        )))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Opacity(
                    opacity:
                        (widget.institutionItem.urlPaginaYoutube.length > 1)
                            ? 1
                            : 0,
                    child: ClipOval(
                      child: Material(
                        color: Colors.white, // button color
                        child: InkWell(
                            splashColor: AppTheme
                                .backGroundInstitutionPrimary, // inkwell color
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/image/youtube.jpg',
                                  fit: BoxFit.cover,
                                )),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PageViewModule(
                                          title: widget.institutionItem
                                              .nombreInstitucion,
                                          selectedUrl: widget
                                              .institutionItem.urlPaginaYoutube,
                                        )))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Opacity(
                    opacity: (widget.institutionItem.urlPaginaWeb.length > 1)
                        ? 1
                        : 0,
                    child: ClipOval(
                      child: Material(
                        color: Colors.white, // button color
                        child: InkWell(
                          splashColor: AppTheme
                              .backGroundInstitutionPrimary, // inkwell color
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'assets/image/instagram.png',
                                fit: BoxFit.cover,
                              )),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PageViewModule(
                                        title: widget
                                            .institutionItem.nombreInstitucion,
                                        selectedUrl:
                                            widget.institutionItem.urlPaginaWeb,
                                      ))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tarjetaProfessional(ProfesionalesAgrupados profesional) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoundAllVoluntaryModule(
                      profesional: profesional,
                    )),
          );
        },
        child: Container(
          height: 150,
          width: 150,
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  ImageOpaqueNetworkCustomize(
                      profesional.imagenFondo,
                      Colors.white,
                      Size(double.maxFinite, double.maxFinite),
                      0.5,
                      BoxFit.cover),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          profesional.profesion,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Text(
                          "Contamos con " +
                              profesional.cantidadProfesionales.toString() +
                              " profesionales",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget futureCuerpoProfesionales(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new ProfesionalesAgrupados(),
            urlGetGrupoProfesionales +
                '/' +
                widget.institutionItem.idInstitucion.toString(),
            primaryKeyGrupoProfesionales),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return cuerpoProfesionales(context, snapshot);
          }
        });
  }

  Widget futureMultimedia(BuildContext context) {
    return FutureBuilder(
        future: /*generic.getAll(new Hospital())*/ getImagenesMultimedia(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return fotosMultimedia(context, snapshot);
          }
        });
  }

  Widget fotosMultimedia(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      child: Container(
        height: 170,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              MultimediaImagen imagen = snapshot.data[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CitizenImageDetailModule(
                              multimediaImagen: imagen,
                            )),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/loading/loadingImage.gif",
                        placeholderScale: 0.2,
                        image: imagen.url,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 140,
                        ),
                        Container(
                            width: 165,
                            color: Colors.white70,
                            padding: EdgeInsets.only(left: 18),
                            child: Text(
                              imagen.titulo,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        Container(
                            width: 165,
                            color: Colors.white70,
                            padding: EdgeInsets.only(left: 18),
                            child: Text(
                              imagen.subtitulo,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
