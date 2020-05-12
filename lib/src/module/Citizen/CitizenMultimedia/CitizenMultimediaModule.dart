import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/ListEntity.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/module/General/PageViewModule.dart';
import 'CitizenImageDetailModule.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';



class CitizenMultimediaModule extends StatefulWidget {
  const CitizenMultimediaModule({Key key}) : super(key: key);


  @override
  _CitizenMultimediaModuleState createState() =>
      _CitizenMultimediaModuleState();
}

class _CitizenMultimediaModuleState extends State<CitizenMultimediaModule> {
  final generic = new Generic();
  int page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List<Widget> optionPage = [PagePicture(), PageVideo(), PageDocuments()];
 
 
  @override
  void initState() {
    page = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
        elevation: 0,
        title: Text(
          "Multimedia",
          style: TextStyle(
              color: AppTheme.themeColorNaranja,
              fontSize: 17,
              fontWeight: FontWeight.w400),
        ),
        //backgroundColor: AppTheme.themeColorNaranja,
      ),
      drawer: DrawerCitizen(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.photo,
            size: 30,
            color: AppTheme.themeColorAzul,
          ),
          Icon(Icons.video_library, size: 30, color: AppTheme.themeColorAzul),
          Icon(Icons.description, size: 30, color: AppTheme.themeColorAzul),
        ],
        color: AppTheme.themeColorNaranja,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white70,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
            print(page);
          });
        },
      ),
      body: optionPage[page],
    );
  }
}

class PagePicture extends StatelessWidget {
  const PagePicture({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              campoBuscarPorInstitucionCategoria(),
              Text(
                "Galería de imagenes de institución",
                style: AppTheme.themeTitulo,
              ),
              futureImagenes(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoBuscarPorInstitucionCategoria() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.themeColorNaranja,
        ),
        hintText: "Buscar por institución / categoria",
        hintStyle: TextStyle(fontSize: 12, color: AppTheme.themeColorNaranja),
      ),
    );
  }

  Widget futureImagenes(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new ListaMultimedia(),
            urlGetListaMultimedia +
                '/74',
            primaryKeyListaMultimedia), 
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildImage(context, snapshot);
          }
        });
  }

  Widget buildImage(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> lista = new List<Widget>();
    for (var i = 0; i < snapshot.data.length; i++) {
      ListaMultimedia multimediaImagen = snapshot.data[i];
      lista.add(imageGalery(context, multimediaImagen));
    }
    return Wrap(
      children: lista,
    );
  }

  Widget imageGalery(BuildContext context, ListaMultimedia multimediaImagen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CitizenImageDetailModule(
                    multimediaImagen: multimediaImagen,
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
              image: multimediaImagen.mulEnlace,
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
                    multimediaImagen.mulTitulo,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  )),
              Container(
                  width: 165,
                  color: Colors.white70,
                  padding: EdgeInsets.only(left: 18),
                  child: Text(
                    multimediaImagen.mulResumen,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class PageVideo extends StatefulWidget {
  const PageVideo({Key key}) : super(key: key);

  @override
  _PageVideoState createState() => _PageVideoState();
}

class _PageVideoState extends State<PageVideo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              campoBuscarPorInstitucionCategoria(),
              Text(
                "Galería de videos de institución",
                style: AppTheme.themeTitulo,
              ),
              futureVideo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoBuscarPorInstitucionCategoria() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.themeColorNaranja,
        ),
        hintText: "Buscar por institución / categoria",
        hintStyle: TextStyle(fontSize: 12, color: AppTheme.themeColorNaranja),
      ),
    );
  }

  Widget futureVideo(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new ListaMultimedia(),
            urlGetListaMultimedia +
                '/75',
            primaryKeyListaMultimedia),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildItemVideo(context, snapshot);
          }
        });
  }

  Widget buildItemVideo(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            ListaMultimedia item = snapshot.data[index];
            return itemVideo(context, item);
          }),
    );
  }

  Widget itemVideo(BuildContext context, ListaMultimedia multimediaVideo) {
    return InkWell(
        child: ListTile(
          leading: Icon(
            Icons.movie_filter,
            size: 35,
          ),
          title: Text(
            multimediaVideo.mulTitulo,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            multimediaVideo.mulResumen,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.navigate_next),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PageViewModule(
                    title: multimediaVideo.mulTitulo,
                    selectedUrl: multimediaVideo.mulEnlace,
                  )));
        });
  }
}

class PageDocuments extends StatelessWidget {
  const PageDocuments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              campoBuscarPorInstitucionCategoria(),
              Text(
                "Galería de imagenes de institución",
                style: AppTheme.themeTitulo,
              ),
              futureDocumentos(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoBuscarPorInstitucionCategoria() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: AppTheme.themeColorNaranja,
        ),
        hintText: "Buscar por institución / categoria",
        hintStyle: TextStyle(fontSize: 12, color: AppTheme.themeColorNaranja),
      ),
    );
  }

  Widget futureDocumentos(BuildContext context) {
    return FutureBuilder(
        future: Generic().getAll(
            new ListaMultimedia(),
            urlGetListaMultimedia +
                '/76',
            primaryKeyListaMultimedia),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              //mostramos los datos
              return buildDocumentos(context, snapshot);
          }
        });
  }

  Widget buildDocumentos(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            ListaMultimedia item = snapshot.data[index];
            return itemDocumento(context, item);
          }),
    );
  }

  Widget itemDocumento(
      BuildContext context, ListaMultimedia multimediaDocumento) {
    return InkWell(
        child: ListTile(
          leading: Icon(
            Icons.description,
            size: 35,
          ),
          title: Text(
            multimediaDocumento.mulTitulo,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            multimediaDocumento.mulResumen,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.navigate_next),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PageViewModule(
                    title: multimediaDocumento.mulTitulo,
                    selectedUrl: multimediaDocumento.mulEnlace,
                  )));
        });
  }
}
