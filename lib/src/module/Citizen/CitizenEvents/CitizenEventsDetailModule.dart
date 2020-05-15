import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';

class CitizenEventsDetailModule extends StatefulWidget {
  final EventosItem eventosItem;

  static final String routeName = 'CiudadanoEventosDetalle';
  const CitizenEventsDetailModule({Key key, @required this.eventosItem})
      : super(key: key);

  @override
  _CitizenEventsDetailModuleState createState() =>
      _CitizenEventsDetailModuleState();
}

class _CitizenEventsDetailModuleState extends State<CitizenEventsDetailModule> {
  final prefs = new PreferensUser();

  @override
  void initState() {
    prefs.ultimaPagina = CitizenEventsDetailModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppTheme.themeColorNaranja, size: 12),
        elevation: 0,
        title: Text(
          widget.eventosItem.titulo,
          style: TextStyle(
              color: AppTheme.themeColorNaranja,
              fontSize: 17,
              fontWeight: FontWeight.w400),
        ),
        //backgroundColor: AppTheme.themeColorNaranja,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                widget.eventosItem.url,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "FECHA Y HORA:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeColorAzul),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.eventosItem.fecha + ' ' + widget.eventosItem.hora,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.themeColorNaranja),
                  ),
                ],
              ),
              Text(
                "EVENTO:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeColorAzul),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.eventosItem.titulo,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.themeColorNaranja),
                  ),
                ],
              ),
              Text(
                "EXPOSITOR:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeColorAzul),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.eventosItem.expositor,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.themeColorNaranja),
                  ),
                ],
              ),
              Text(
                "OBJETIVO:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeColorAzul),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.eventosItem.objetivo,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.themeColorNaranja),
                  ),
                ],
              ),
              Text(
                "DIRIGIDO A:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeColorAzul),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.eventosItem.dirigidoA,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.themeColorNaranja),
                  ),
                ],
              ),
              Text(
                "UBICACION:",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AppTheme.themeColorAzul),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.eventosItem.ubicacion,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.themeColorNaranja),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
