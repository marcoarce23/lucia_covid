import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import '../blankModule.dart';
import 'MenuModule.dart';


class HomePageModule extends StatefulWidget {
  HomePageModule({Key key}) : super(key: key);

  @override
  _HomePageModuleState createState() => _HomePageModuleState();
}

class _HomePageModuleState extends State<HomePageModule> {
  Widget screenView;
  DrawerIndex drawerIndex;
  final prefs = new PreferensUser();

  @override
  void initState() {
    drawerIndex = DrawerIndex.Inicio;
    screenView = BlankModule();
    super.initState();
    prefs.ultimaPagina('home');
  
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          body: Container(),
        ),
      ),
    );
  }

  
}
