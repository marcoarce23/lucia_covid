import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenMultimedia/CitizenImageDetailModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/FoundAllVoluntaryModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';
import 'package:lucia_covid/src/module/UtilModule/PageViewModule.dart';

class CitizenInstitutionModule extends StatefulWidget {
  final InstitucionesItems institutionItem;
  static final String routeName = 'CiudadanoInstitucion';

  const CitizenInstitutionModule({Key key, @required this.institutionItem})
      : super(key: key);

  @override
  _CitizenInstitutionModuleState createState() =>
      _CitizenInstitutionModuleState();
}

class _CitizenInstitutionModuleState extends State<CitizenInstitutionModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = CitizenInstitutionModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeigh = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: AppTheme.themeVino,
        toolbarOpacity: 0.7,
        iconTheme: IconThemeData(color: AppTheme.themeColorBlanco, size: 12),
        elevation: 0,
        title:
            Text(widget.institutionItem.nombreInstitucion, style: kTitleAppBar),
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
                child: contenedorTitulo(
                  context,
                  40.0,
                  "Grupo de voluntarios".toUpperCase(),
                  FaIcon(FontAwesomeIcons.peopleCarry, color: Colors.white60),
                ),
              ),
            ),
          ),
          futureCuerpoProfesionales(context),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: contenedorTitulo(
                  context,
                  40.0,
                  "Galeria de fotos".toUpperCase(),
                  FaIcon(FontAwesomeIcons.photoVideo, color: Colors.white60),
                ),
              ),
            ),
          ),
          futureMultimedia(context),
          copyRigth(),
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
      height: 210,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ImageOvalNetwork(
              imageNetworkUrl: widget.institutionItem.url,
              sizeImage: Size.fromWidth(140)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.business,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    "Institución / Grupo voluntarios",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Text(widget.institutionItem.nombreInstitucion),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.category,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    "Tipo de institución",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Text(widget.institutionItem.tipoInstitucion),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    "Ubicación",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Text(widget.institutionItem.ubicacion),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.mail,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text(
                    "Correo ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Text(widget.institutionItem.correo),
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
        future: Generic().getAll(
            new ListaMultimedia(),
            urlGetListaMultimediaPorInstitucion +
                '/' +
                widget.institutionItem.idInstitucion.toString() +
                '/74',
            primaryKeyListaMultimediaPorInstitucion),
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
              ListaMultimedia imagen = snapshot.data[index];
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
                        image: imagen.mulEnlace,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 130,
                        ),
                        Container(
                            width: 160,
                            color: Colors.white70,
                            padding: EdgeInsets.only(left: 18),
                            child: Text(
                              imagen.mulTitulo,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        Container(
                            width: 160,
                            color: Colors.white70,
                            padding: EdgeInsets.only(left: 18),
                            child: Text(
                              imagen.mulResumen,
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
