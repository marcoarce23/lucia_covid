

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucia_covid/src/Util/Util.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenHelpModule.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/ListCitizenHelpModule.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/AtentionEntityodule.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/EntityModule.dart';
import 'package:lucia_covid/src/module/Citizen/Entity/ListEntityModule.dart';
import 'package:lucia_covid/src/module/Citizen/Multimedia/ListMultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/Multimedia/MultimediaModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/AtentionModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/EventModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/ListEventModule.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/ListVoluntary.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/VoluntaryModule.dart';
import 'package:lucia_covid/src/module/Map/MapAdressModule.dart';


callPageEventVoluntary(int currentIdex, BuildContext context) {
    print('INDEX:$currentIdex');
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => EventModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => ListEventModule()));
   }


 callPage(int currentIdex, BuildContext context) {
    print('INDEX:$currentIdex');
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => VoluntaryModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => AtentionModule()));
    if (currentIdex == 2)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => ListVoluntaryModule()));
          
  }

 callPageInstitucion(int currentIdex, BuildContext context) {
    print('INDEX:$currentIdex');
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => EntityModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => AtentionEntityModule()));
    if (currentIdex == 2)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => ListEntityModule()));
  }

 callPageMap(int currentIdex, BuildContext context) {
    print('INDEX:$currentIdex');
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => MapAdressModule()));
    if (currentIdex == 1)
     openWeb('http://mapacovid19.ruta88.net/');
   
  }

 callMultimedia(int currentIdex, BuildContext context) {
    print('INDEX:$currentIdex');
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => MultimediaModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => ListMultimediaModule()));
     }

 callHelp(int currentIdex, BuildContext context) {
    print('INDEX:$currentIdex');
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => CitizenHelpModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => ListCitizenHelpModule()));
     }
