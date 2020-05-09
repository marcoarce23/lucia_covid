
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Theme/BackgroundTheme.dart';
import 'package:lucia_covid/src/Theme/PageRouteTheme.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/Widget/InputField/InputFieldWidget.dart';
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class _HeaderWaveGradientPainter extends CustomPainter {

  

  @override

  void paint(Canvas canvas, Size size) {

    

    final Rect rect = new Rect.fromCircle(

      center: Offset(0.0, 55.0),

      radius: 180

    );



    final Gradient gradiente = new LinearGradient(

      begin: Alignment.topCenter,

      end: Alignment.bottomCenter,

      colors: <Color>[

        Color(0xff6D05E8),

        Color(0xffC012FF),

        Color(0xff6D05FA),

      ],

      stops: [

        0.2,

        0.5,

        1.0,

      ]

    );





    final lapiz = new Paint()..shader = gradiente.createShader(rect);



    // Propiedades

    // lapiz.color = Color(0xff615AAB);

    // lapiz.color = Colors.red;

    lapiz.style = PaintingStyle.fill; // .fill .stroke

    lapiz.strokeWidth = 20;



    final path = new Path();



    // Dibujar con el path y el lapiz

    path.lineTo( 0, size.height * 0.25 );

    path.quadraticBezierTo(size.width * 0.25, size.height * 0.30, size.width * 0.5, size.height * 0.25 );

    path.quadraticBezierTo(size.width * 0.75, size.height * 0.20, size.width, size.height * 0.25 );

    path.lineTo( size.width, 0 );



  





    canvas.drawPath(path, lapiz );

  }



  @override

  bool shouldRepaint(CustomPainter oldDelegate) {

    return true;

  }



}
class CitizenHelpModule extends StatefulWidget {
  @override
  _CitizenHelpModuleState createState() => _CitizenHelpModuleState();
}

class _CitizenHelpModuleState extends State<CitizenHelpModule> {
  InputTextField nombre;
  InputPhoneField telefono;
  InputMultilineField ubicacion;
  InputDropDown tipoAyuda;

  bool _save = false;
  int _currentIndex = 0;
  String _opcionSeleccionadaPrioridad = '';
  var result;
  var list;


  List<String> _tipoPrioridad = [
    '<Seleccionar_Prioridad>',
    'Muy Alta',
    'Alta',
    'Media'
  ];

  List<String> _tipoAyuda = [
    '<Seleccionar_Ayuda>',
    'Salud - Covid',
    'Salud',
    'Económica',
    'Alimentación'
  ];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final generic = new Generic();
  RegistroAmigo registroAmigo = new RegistroAmigo();


  @override
  void initState() {
    _opcionSeleccionadaPrioridad = '<Seleccionar_Prioridad>';
     super.initState();
    
  }

 List<DropdownMenuItem<String>> getOpcionesPrioridad() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoPrioridad.forEach((tipoPrioridad) {
      lista.add(DropdownMenuItem(
        child: Text(tipoPrioridad),
        value: tipoPrioridad,
      )
      );
    });
    return lista;
  }

 List<DropdownMenuItem<String>> getipoAy(AsyncSnapshot snapshot) {
    
    List<DropdownMenuItem<String>> lista = new List();

    for (var i = 0; i < snapshot.data.length; i++) {
      GetClasificador item = snapshot.data[i];
      lista.add(DropdownMenuItem(
        child: Text(item.nombre),
        value: item.id.toString(),//tipoPrioridad.id,
      )
      );
    }
    return lista;
  }



  @override
  Widget build(BuildContext context) {
    final RegistroAmigo registroAmigoData =
        ModalRoute.of(context).settings.arguments;

    if (registroAmigoData != null) registroAmigo = registroAmigoData;

    return Scaffold(
        key: scaffoldKey,
        appBar: _appBar(),
        body: Stack(
          children: <Widget>[
          
            _crearForm(context),
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('AYUDA A UN AMIG@'),
      backgroundColor: Colors.orange,
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
            callHelp(_currentIndex, context);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart, size: 25.0),
              title: Text('Ayudalo')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25.0), title: Text('Solicitudes')),
        ],
      ),
    );
  }

  Widget informacionProfesional(BuildContext context) {
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
                    text: 'Corina Balderrama.', // 'Dr Dan MlayahFX',
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

  Widget _crearForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            informacionProfesional(context),
            SafeArea(
              child: Container(
                height: 10.0,
              ),
            ),
            Container(

              width: size.width * 0.90,
              margin: EdgeInsets.symmetric(vertical: 0.0),
              decoration: _crearContenedorCampos(),
              child: _crearCampos(),
            ),
            crearLucia(),
          ],
        ),
      ),
    );
  }

  Widget _crearCampos() {
    nombre = InputTextField(Icon(Icons.business), 'Persona a poyar', '', '');
    telefono =  InputPhoneField(Icon(Icons.business), 'Telefono de referencia', '', '');
    ubicacion =   InputMultilineField(Icon(Icons.business), 'Donde la encuentro', '', '');

      tipoAyuda = InputDropDown(Icons.person_pin ,'Tipod e ayuda','49',urlGetClasificador+'/47');

    return Column(
      children: <Widget>[
        Text(
          'AYUDA A UN AMIG@',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        nombre,
        telefono,
        ubicacion,
        tipoAyuda,
        _crearTipoPrioridad(),
        _crearBoton(resource.save),
      ],
    );
  }

 
List<DropdownMenuItem<String>> getOpcionesTipoApoyo() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoAyuda.forEach((tipoAyuda) {
      lista.add(DropdownMenuItem(
        child: Text(tipoAyuda),
        value: tipoAyuda,
      )
      );
    });
    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesTipoAyuda() {
    List<DropdownMenuItem<String>> lista = new List();

    _tipoAyuda.forEach((tipoAyuda) {
      lista.add(DropdownMenuItem(
        child: Text(tipoAyuda),
        value: tipoAyuda,
      ));
    });
    return lista;
  }

  Widget _crearTipoPrioridad() {
    return Row(
      children: <Widget>[
        SizedBox(width: 35.0),
        Text('Prioridad:'),
        SizedBox(width: 15.0),
        DropdownButton(
          value: _opcionSeleccionadaPrioridad,
          icon: Icon(Icons.person_pin, color: Colors.orange),
          items: getOpcionesPrioridad(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionadaPrioridad = opt;
            });
          },
        ),
      ],
    );
  }

  _crearContenedorCampos() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 7.0,
              offset: Offset(0.0, 5.0),
              spreadRadius: 7.0)
        ]);
  }

  Widget _crearBoton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.blue,
        textColor: Colors.white,
        label: Text(text),
        icon: Icon(Icons.save),
        onPressed: (_save) ? null : _submit,
      ),
    );
  }

  _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();
    setState(() {
      _save = true;
    });

    registroAmigo.idcovRegistroAmigo = 0;
    registroAmigo.regPersona = nombre.objectValue;
    registroAmigo.regTelefono = telefono.objectValue;
    registroAmigo.regUbicacion = ubicacion.objectValue;
    registroAmigo.regPrioridad = _opcionSeleccionadaPrioridad;
    registroAmigo.regTipoAPoyo = int.parse(tipoAyuda.objectValue);
    registroAmigo.usuario = 'marcoarce23@gmail.com';

    // if (registroAmigo.idcovRegistroAmigo == null) {

    print("valores: ${registroAmigo.regPersona}");
    print("valores: ${registroAmigo.regTelefono}");
    print("valores: ${registroAmigo.regPrioridad}");
    print("valores: ${registroAmigo.regUbicacion}");
    print("valores: ${registroAmigo.regTipoAPoyo.toString()}");
    print("valores: ${registroAmigo.usuario}");

    final dataMap = generic.add(registroAmigo, urlAddVoluntary);

    await dataMap.then((respuesta) => result = respuesta["TIPO_RESPUESTA"]);
    print('resultado:$result');

    // } else {
    //   //  generic.update(citizen);
    //   print("MODIFICO");
    // }

    setState(() {
      _save = false;
    });

    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SliderShowModule()));
  }
}
