import 'package:flutter/material.dart';
import 'package:lucia_covid/src/module/Citizen/Voluntary/VoluntaryModule.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';


class BlankModule extends StatefulWidget {
  @override
  _BlankModuleState createState() => _BlankModuleState();
}

class _BlankModuleState extends State<BlankModule>
{    
 
@override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: MultiLevelDrawer(
          backgroundColor: Colors.white,
          rippleColor: Colors.white,
          subMenuBackgroundColor: Colors.grey.shade100,
          divisionColor: Colors.grey,
          header: Container(
            height: size.height * 0.25,
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/dp_default.png",width: 100,height: 100,),
                SizedBox(height: 10,),
                Text("RetroPortal Studio")
              ],
            )),
          ),
          children: [
            MLMenuItem(
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "My Profile",
                ),
                subMenuItems: [
                  MLSubmenu(onClick: () {}, submenuContent: Text("Option 1")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Option 2")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Option 3")),
                ],
                onClick: () {}),
            MLMenuItem(
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_right),
                content: Text("Settings"),
                onClick: () {},
                subMenuItems: [
                  MLSubmenu(onClick: () {}, submenuContent: Text("Option 1")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Option 2"))
                ]),
            MLMenuItem(
              leading: Icon(Icons.notifications),
              content: Text("Multimedia"),
              onClick: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryModule()),
                )),
         
            MLMenuItem(
                leading: Icon(Icons.payment),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "Eventos",
                ),
                subMenuItems: [
                  MLSubmenu(onClick: (){

                   print('HOLA ENTRE A OCPION 1');
                   Navigator.of(context).pushNamed('login');

                  }, submenuContent: Text("Option evento 1")),




                  MLSubmenu(onClick: () {}, submenuContent: Text("Option 2")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Option 3")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Option 4")),
                ],
                onClick:  () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VoluntaryModule()),
                )),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Multi Level Menu",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient:
              LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                Color.fromRGBO(255, 65, 108, 1.0),
                Color.fromRGBO(255, 75, 43, 1.0),
              ]),
            ),
            child: Center()),
      ),
    );
  }
}
 
