import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/ListEntity.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/module/General/PageViewModule.dart';
import 'package:lucia_covid/src/module/Voluntary/ListVoluntary.dart';

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
      body: Column(children: <Widget>[
        cabeceraInstitucion(screenHeigh, screenwidth),

        Align(
          alignment: Alignment.topLeft,
                  child: Container(
            child: Padding(
                padding: EdgeInsets.all(1),
                child: Text(
                  "Lista de s registradas",
                  style: AppTheme.themeTitulo,
                )),
          ),
        ),
        SizedBox(height: 10,),
        futureCuerpoProfesionales(context),
        //cuerpoProfesionales()
      ]),
    );
  }

  Widget cuerpoProfesionales(BuildContext context, AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      child: Container(
        height: 250,
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
          Container(
            height: 230,
            width: 150,
            child: ImageOpaqueNetwork(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg/450px-Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg',
                Colors.white12,
                Size(150, 230)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Institución",
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
                  Icon(
                    Icons.pin_drop,
                    color: Colors.black,
                    size: 15,
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: AppTheme
                            .backGroundInstitutionPrimary, // inkwell color
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                                'https://cdn.pixabay.com/photo/2017/08/20/10/30/facebook-2661207_960_720.jpg',
                                fit: BoxFit.cover)),
                        onTap: () {},
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: AppTheme
                            .backGroundInstitutionPrimary, // inkwell color
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                              'https://s23527.pcdn.co/wp-content/uploads/2019/12/twitter.jpg.optimal.jpg',
                              fit: BoxFit.cover,
                            )),
                        onTap: () {},
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: AppTheme
                            .backGroundInstitutionPrimary, // inkwell color
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                              'https://creamostuvideo.com/wp-content/uploads/2019/05/Youtube-Copiar-300x211.jpg',
                              fit: BoxFit.cover,
                            )),
                        onTap: () {},
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: AppTheme
                            .backGroundInstitutionPrimary, // inkwell color
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                              'https://www.alltechbuzz.net/wp-content/uploads/2019/09/57e6d2464c55ac14ea898579ce203e7c1d22dfe05558774075277dd2_640.png',
                              fit: BoxFit.cover,
                            )),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PageViewModule(
                                      title: 'https://www.youtube.com',
                                      selectedUrl: 'https://www.youtube.com',
                                    ))),
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

    /*
    Container(
      height: 240,
      child: Stack(
        children: <Widget>[
          ImageOpaqueNetwork(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg/450px-Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg',
              AppTheme.backGroundInstitutionPrimary,
              Size(double.maxFinite, 220)),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                RadialProgress(
                  width: 4,
                  goalCompleted: 0.85,
                  child: Container(
                      child: ImageOvalNetwork(
                          imageNetworkUrl:
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                          sizeImage: Size.fromWidth(90))),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.institutionItem.nombreInstitucion),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.institutionItem.tipoInstitucion),
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
                        Text(widget.institutionItem.ubicacion),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          barraRedesSociales(screenHeigh, screenwidth),
        ],
      ),
    );

    */
  }

  Widget blank() {
    return Center(
      child: Container(
        child: Text("Citizen Institution"),
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
                builder: (context) => ListVoluntary(
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
                  GestureDetector(
                    child: Hero(
                      tag: profesional.imagenFondo,
                      child: ImageOpaqueAssets(
                          profesional.imagenFondo,
                          Colors.white,
                          Size(double.maxFinite, double.maxFinite),
                          0.50),
                    ),
                  ),
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
        future: /*generic.getAll(new Hospital())*/ getListaProfesionalesAgrupadosInstitucion(),
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
}
