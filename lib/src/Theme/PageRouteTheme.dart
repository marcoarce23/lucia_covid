

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucia_covid/src/module/Entity/AtentionEntityodule.dart';
import 'package:lucia_covid/src/module/Entity/EntityModule.dart';
import 'package:lucia_covid/src/module/Entity/EventEntityModule.dart';
import 'package:lucia_covid/src/module/Material/ListMaterialModule.dart';
import 'package:lucia_covid/src/module/Multimedia/MultimediaModule.dart';

import 'package:lucia_covid/src/module/Voluntary/AtentionModule.dart';
import 'package:lucia_covid/src/module/Voluntary/EventModule.dart';
import 'package:lucia_covid/src/module/Voluntary/VoluntaryModule.dart';

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
          builder: (BuildContext context) => EventModule()));
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
          builder: (BuildContext context) => EventEntityModule()));
  }

 callMaterial(int currentIdex, BuildContext context) {
    print('INDEX:$currentIdex');
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => MultimediaModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => ListMaterialModule()));
     }

class PageRouteTheme extends PageRouteBuilder
{
    final Widget child;
     PageRouteTheme(this.child) 
     :super ( pageBuilder: (BuildContext context, 
                            Animation<double> animation, 
                            Animation<double> secundaryAnimation)
                            {
                              return child;
                            },
              transitionsBuilder:(BuildContext context, 
                            Animation<double> animation, 
                            Animation<double> secundaryAnimation,
                            Widget child)
                            {
                              return Transform.scale(
                                scale: animation.value,
                                child:  Transform.rotate(
                                  angle:  9 -9 * animation.value,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                  ),
                                );
                            }
     );
}