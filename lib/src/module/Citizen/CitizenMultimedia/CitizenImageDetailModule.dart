import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';

class CitizenImageDetailModule extends StatefulWidget {
  final MultimediaImagen multimediaImagen;

  const CitizenImageDetailModule({Key key, @required this.multimediaImagen})
      : super(key: key);

  @override
  _CitizenImageDetailModuleState createState() =>
      _CitizenImageDetailModuleState();
}

class _CitizenImageDetailModuleState extends State<CitizenImageDetailModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
            child: FadeInImage.assetNetwork(
          placeholder: "assets/loading/loadingImage.gif",
          placeholderScale: 0.5,
          image: widget.multimediaImagen.url,
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
