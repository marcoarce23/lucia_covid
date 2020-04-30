
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucia_covid/src/module/CitizenPage/CitizenModule.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';

callPage(BuildContext context, int currentIdex)
{

  print('INDEX:$currentIdex');
    if(currentIdex == 0)
        Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => CitizenModule())); 
    if(currentIdex == 1)
       Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SignUpModule())); 
    if(currentIdex == 2)
       Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SignUpModule()));    
    else
     Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => CitizenModule())); 
}


 