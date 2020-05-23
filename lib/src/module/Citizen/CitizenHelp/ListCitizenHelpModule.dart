import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Theme/ThemeModule.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/Widget/GeneralWidget.dart';
import 'package:lucia_covid/src/Widget/Message/Message.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class ListCitizenHelpModule extends StatefulWidget {
  static final String routeName = 'ListaCiudadanoAyuda';
  @override
  _ListCitizenHelpModuleState createState() => _ListCitizenHelpModuleState();
}

class _ListCitizenHelpModuleState extends State<ListCitizenHelpModule> {
  final generic = new Generic();
  final prefs = new PreferensUser();
  var result;


  @override
  void initState() {
    prefs.ultimaPagina = ListCitizenHelpModule.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.0), 
          Container(
              width: size.width * 0.96,
              margin: EdgeInsets.symmetric(vertical: 0.0),
          child: contenedorTitulo(
              context,
              40.0,
              'LISTADO DE AYUDA A UN AMIGO',
              FaIcon(FontAwesomeIcons.userMd, color: Colors.white60),
            ),
          ),
          divider(),
          futureItemsEntity(context),
          copyRigth(),
          
          ],
      ),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: generic.getAll(
            new RegistroAmigo(), urlGetDevuelveAyuda, primaryKeyGetAyudaAmigo),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              return listItemsEntity(context, snapshot);
          }
        });
  }

  Widget listItemsEntity(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) 
        {
          RegistroAmigo entityItem = snapshot.data[index];

          return Column(
            children: <Widget>[
              Container(
                width: size.width * 0.97,
                  margin: EdgeInsets.symmetric(vertical: 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: <BoxShadow>[
                       BoxShadow(
                  color: Colors.black26,
                  blurRadius: 7.0,
                  offset: Offset(2.0, 3.0),
                  spreadRadius: 4.0)
                    ]
                    ),
                     
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: iconEntity(entityItem),
                      title: listEntity(context, entityItem),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ],
                ),
               

              ),
              divider(),
            ],
           
          ); 

          
           
        },
       
      ),
    );
  }

  Widget listEntity(BuildContext context, RegistroAmigo entityItem) {
    final item = entityItem.idcovRegistroAmigo;

    return Dismissible(
      key: Key(item.toString()), //UniqueKey(),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          'Eliminar registro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onDismissed: (value) {
        setState(() {
          final dataMap = generic.add(new RegistroAmigo(), '$urlDeleteAyudaAmigo${item.toString()}/${prefs.userId}');

          dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
          print('resultado:$result');
        });

        if (result != null || result != '-1')
          Scaffold.of(context)
          .showSnackBar(messageOk("Se elimino el registro."));
        else
          Scaffold.of(context)
          .showSnackBar(messageNOk("Se  produjo un error. Vuelva a intentarlo."));
      },

      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width -160,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.gamepad,
                        color: AppTheme.themeVino,
                        size: 15,
                      ),
                      Text('Persona: ${entityItem.regPersona} ',
                          style: kTitleCardStyle),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: AppTheme.themeVino,
                    size: 15,
                  ),
                  Text('Prioridad: ${entityItem.regPrioridad}',
                      style: kSubTitleCardStyle)
                ],
              ),
              Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                      Icons.phone_android,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                      Text(
                'Telefono: ${entityItem.regTelefono}',
                style: kSubTitleCardStyle,
              ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width ,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.store_mall_directory,
                      color: AppTheme.themeVino,
                      size: 15,
                    ),
                    Text(
                      'Ubicacion: ${entityItem.regUbicacion}',
                      style: kSubTitleCardStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container iconEntity(RegistroAmigo entityItem) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: prefs.avatarImagen, sizeImage: Size.fromWidth(40)),
            SizedBox(height: 1.5,),
        Text(
          '${entityItem.regPrioridad}',
          style: TextStyle(
              fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        ),
      ],
    ));
  }

}
