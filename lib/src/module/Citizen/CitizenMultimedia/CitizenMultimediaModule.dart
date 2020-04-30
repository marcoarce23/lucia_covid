import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/ListEntity.dart';

import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenLayoutMenu/CitizenLayoutMenuModule.dart';
import 'package:lucia_covid/src/module/General/PageViewModule.dart';


import 'CitizenImageDetailModule.dart';

class CitizenMultimediaModule extends StatefulWidget {
  const CitizenMultimediaModule({Key key}) : super(key: key);

  @override
  _CitizenMultimediaModuleState createState() =>
      _CitizenMultimediaModuleState();
}

class _CitizenMultimediaModuleState extends State<CitizenMultimediaModule> {
  int page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final List<Widget> optionPage = [PagePicture(), PageVideo()];

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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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

  Widget futureImagenes(BuildContext context) {
    return FutureBuilder(
        future: /*generic.getAll(new Hospital())*/ getImagenesMultimedia(),
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
      MultimediaImagen multimediaImagen = snapshot.data[i];
      lista.add(imageGalery(context, multimediaImagen));
    }
    return Wrap(
      children: lista,
    );
  }

  Widget imageGalery(BuildContext context, MultimediaImagen multimediaImagen) {
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
              image: multimediaImagen.url,
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
                    multimediaImagen.titulo,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  )),
              Container(
                  width: 165,
                  color: Colors.white70,
                  padding: EdgeInsets.only(left: 18),
                  child: Text(
                    multimediaImagen.subtitulo,
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

  Widget futureVideo(BuildContext context) {
    return FutureBuilder(
        future: /*generic.getAll(new Hospital())*/ getVideosMultimedia(),
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
            MultimediaVideo item = snapshot.data[index];
            return itemVideo(context, item);
          }),
    );
  }

  Widget itemVideo(BuildContext context, MultimediaVideo multimediaVideo) {
    return InkWell(
        child: ListTile(
          leading: Icon(
            Icons.movie_filter,
            size: 35,
          ),
          title: Text(
            multimediaVideo.titulo,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            multimediaVideo.subtitulo,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.navigate_next),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PageViewModule(
                    title: multimediaVideo.titulo,
                    selectedUrl: multimediaVideo.url,
                  )));
        });
  }
}
