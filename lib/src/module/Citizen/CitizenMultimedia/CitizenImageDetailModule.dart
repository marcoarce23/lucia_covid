import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';

class CitizenImageDetailModule extends StatefulWidget {
  final ListaMultimedia multimediaImagen;
  static final String routeName ='ImagenDetalle';

  const CitizenImageDetailModule({Key key, @required this.multimediaImagen})
      : super(key: key);

  @override
  _CitizenImageDetailModuleState createState() =>
      _CitizenImageDetailModuleState();
}

class _CitizenImageDetailModuleState extends State<CitizenImageDetailModule> {

  final prefs = new PreferensUser();


@override
void initState() { 
  prefs.ultimaPagina = CitizenImageDetailModule.routeName;
  super.initState();
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: <Widget>[
                Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topRight,
                          child: InkWell(
                              splashColor: AppTheme
                                  .backGroundInstitutionPrimary, // inkwell color
                              child: FaIcon(
                                FontAwesomeIcons.shareAlt,
                                color: Colors.white,
                                size: 55,
                              ),
                              onTap: () => sharedImage(widget.multimediaImagen.mulEnlace, "ss",
                                  ".jpg", ".jpg", "ss")),
                        ),
            Container(
                child: FadeInImage.assetNetwork(
              placeholder: "assets/loading/loadingImage.gif",
              placeholderScale: 0.5,
              image: widget.multimediaImagen.mulEnlace,
              fit: BoxFit.cover,
            )),
          ],
        ),
      ),
    );
  }
}
