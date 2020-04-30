import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/module/Citizen/CitizenHelp/CitizenFamilyModule.dart';



import 'package:lucia_covid/src/module/Citizen/CitizenReference/CitizenRegisterReferenceModule.dart';

import 'package:lucia_covid/src/module/Voluntary/VoluntaryModule.dart';

class CitizenReferenceModule extends StatefulWidget {
  const CitizenReferenceModule({Key key}) : super(key: key);

  @override
  _CitizenReferenceModuleState createState() => _CitizenReferenceModuleState();
}

class _CitizenReferenceModuleState extends State<CitizenReferenceModule> {
  int _currentIndex;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  Hospital hospital = new Hospital();

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  _callPage(int currentIdex) {
    if (currentIdex == 0)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => VoluntaryModule()));
    if (currentIdex == 1)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => CitizenReferenceModule()));
    if (currentIdex == 2)
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => CitizenFamilyModule()));
  }

  @override
  Widget build(BuildContext context) {
    final Hospital hospitalData = ModalRoute.of(context).settings.arguments;

    if (hospitalData != null) hospital = hospitalData;

    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(),
      body: Stack(
        children: <Widget>[
          _crearForm(context),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _floatButton(),
    );
  }

  _floatButton() {
    return FloatingActionButton(
        backgroundColor: Colors.orange,
        focusColor: Colors.blue,
        hoverColor: Colors.blue,
        splashColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) =>
                CitizenRegisterReferenceModule())));
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Referencias Familiares'),
      backgroundColor: Colors.orange,
      actions: <Widget>[],
    );
  }

  Widget _crearForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            informacionSospechoso(context),
            Divider(),
            Text(
              '- REFERENCIAS DEL SOSPECHOSO-',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SafeArea(
              child: Container(
                height: 10.0,
              ),
            ),
            Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              child: _showData(),
            ),
            crearLucia(),
          ],
        ),
      ),
    );
  }

  Widget _showData() {
    // return FutureBuilder(
    //   future: generic.getAll(new Hospital()),
    //   builder: (BuildContext context, AsyncSnapshot<List<Entity>> snapshot) {
    //     if (snapshot.hasData) {
    //       return ListView.builder(
    //           itemCount: snapshot.data.length,
    //           itemBuilder: (context, i) =>
    //               _createItem(context, snapshot.data[i]));
    //     } else
    //       return Center(child: CircularProgressIndicator());
    //   },
    // );
        return _createItem(context, new Hospital());
  }

  Widget _createItem(BuildContext context, Hospital entityList) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text('Juan Perez'),
            subtitle: Text('Carnet: 4538412 CBB' + '\n' + 'XXXXX: XXXX CBB'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: IconButton(
                    icon: Icon(Icons.delete_forever, color: Colors.orange),
                    onPressed: null),
                onPressed: null,
              ),
              FlatButton(
               
                child: IconButton(
                  
                    icon: Icon(Icons.mode_edit, color: Colors.orange, ),
                    onPressed: null),
                onPressed: null,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.blueGrey))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            _callPage(_currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Ciudadano')),
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Referencias')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle, size: 25.0),
              title: Text('Familiares')),
        ],
      ),
    );
  }

   Widget informacionSospechoso(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.black12,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                imagenProfesional(),
                RichText(
                  text: TextSpan(
                    text: 'Marco ANtonio Arce Valdivia .', // 'Dr Dan MlayahFX',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n' + 'Carnet: 4538412 CBB',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: '\n' + 'CElular: 72038768',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                crearIconoProfesional(Icons.mail, 'Correo'),
                crearIconoProfesional(Icons.phone, 'Correo'),
                crearIconoProfesional(Icons.bug_report, 'Ayuda con covid'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Image imagenProfesional() {
    Image imagenAvatar;

    //if (profesionalesDeInstitucion.sexo == "F") {
    imagenAvatar = Image.asset(
      "assets/image/circled_user_female.png",
      width: 50,
      height: 50,
      fit: BoxFit.fill,
    );
    // } else {
    //   imagenAvatar = Image.asset(
    //     "assets/image/circled_user_male.png",
    //     width: 50,
    //     height: 50,
    //     fit: BoxFit.fill,
    //   );
    // }
    return imagenAvatar;
  }

  Column crearIconoProfesional(icon, title) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

}
